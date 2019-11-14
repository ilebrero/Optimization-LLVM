#include "llvm/ADT/StringExtras.h"
#include "llvm/ADT/Triple.h"
#include "llvm/Bitcode/BitcodeReader.h"
#include "llvm/CodeGen/CommandFlags.inc"
#include "llvm/CodeGen/LinkAllCodegenComponents.h"
#include "llvm/Config/llvm-config.h"
#include "llvm/ExecutionEngine/GenericValue.h"
#include "llvm/ExecutionEngine/Interpreter.h"
#include "llvm/ExecutionEngine/JITEventListener.h"
#include "llvm/ExecutionEngine/MCJIT.h"
#include "llvm/ExecutionEngine/ObjectCache.h"
#include "llvm/ExecutionEngine/Orc/ExecutionUtils.h"
#include "llvm/ExecutionEngine/Orc/JITTargetMachineBuilder.h"
#include "llvm/ExecutionEngine/Orc/LLJIT.h"
#include "llvm/ExecutionEngine/Orc/OrcRemoteTargetClient.h"
#include "llvm/ExecutionEngine/OrcMCJITReplacement.h"
#include "llvm/ExecutionEngine/SectionMemoryManager.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/Verifier.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Object/Archive.h"
#include "llvm/Object/ObjectFile.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/DynamicLibrary.h"
#include "llvm/Support/Format.h"
#include "llvm/Support/InitLLVM.h"
#include "llvm/Support/ManagedStatic.h"
#include "llvm/Support/MathExtras.h"
#include "llvm/Support/Memory.h"
#include "llvm/Support/MemoryBuffer.h"
#include "llvm/Support/Path.h"
#include "llvm/Support/PluginLoader.h"
#include "llvm/Support/Process.h"
#include "llvm/Support/Program.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Support/WithColor.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Instrumentation.h"
#include <cerrno>

using namespace llvm;

namespace {

  cl::opt<std::string>
  InputFile(cl::desc("<input bitcode>"), cl::Positional, cl::init("-"));

  cl::list<std::string>
  InputArgv(cl::ConsumeAfter, cl::desc("<program arguments>..."));

  ExitOnError ExitOnErr;
}

LLVM_ATTRIBUTE_NORETURN
static void reportError(SMDiagnostic Err, const char *ProgName) {
  Err.print(ProgName, errs());
  exit(1);
}

int main(int argc, char **argv, char * const *envp) {
  InitLLVM X(argc, argv);

  if (argc > 1)
    ExitOnErr.setBanner(std::string(argv[0]) + ": ");

  cl::ParseCommandLineOptions(argc, argv,
                              "llvm interpreter & dynamic compiler\n");

  LLVMContext Context;

  // Load the bitcode...
  SMDiagnostic Err;
  std::unique_ptr<Module> Owner = parseIRFile(InputFile, Err, Context);

  // TODO Instrument Owner
  // * execute_inst(%iid, %res) -> updates a real state and a virtual state 
  // * br_taken(%iid, %bid_from, %bid_to) 
  // * call_in(%fid) 
  // * call_out(%fid) 

  Module *Mod = Owner.get();
  if (!Mod)
    reportError(Err, argv[0]);

  // If not jitting lazily, load the whole bitcode file eagerly too.
  // Use *argv instead of argv[0] to work around a wrong GCC warning.
  ExitOnError ExitOnErr(std::string(*argv) +
                        ": bitcode didn't read correctly: ");
  ExitOnErr(Mod->materializeAll());

  std::string ErrorMsg;
  EngineBuilder builder(std::move(Owner));
  builder.setMArch(MArch);
  builder.setMCPU(getCPUStr());
  builder.setMAttrs(getFeatureList());
  if (RelocModel.getNumOccurrences())
    builder.setRelocationModel(RelocModel);
  if (CMModel.getNumOccurrences())
    builder.setCodeModel(CMModel);
  builder.setErrorStr(&ErrorMsg);
  builder.setEngineKind(EngineKind::Interpreter);
  builder.setUseOrcMCJITReplacement(false);

  TargetOptions Options = InitTargetOptionsFromCodeGenFlags();
  builder.setTargetOptions(Options);

  std::unique_ptr<ExecutionEngine> EE(builder.create());
  if (!EE) {
    if (!ErrorMsg.empty())
      WithColor::error(errs(), argv[0])
          << "error creating EE: " << ErrorMsg << "\n";
    else
      WithColor::error(errs(), argv[0]) << "unknown error creating EE!\n";
    exit(1);
  }

  EE->DisableLazyCompilation(true);

  // Otherwise, if there is a .bc suffix on the executable strip it off, it
  // might confuse the program.
  if (StringRef(InputFile).endswith(".bc"))
    InputFile.erase(InputFile.length() - 3);

  // Add the module's name to the start of the vector of arguments to main().
  InputArgv.insert(InputArgv.begin(), InputFile);

  // Call the main function from M as if its signature were:
  //   int main (int argc, char **argv, const char **envp)
  // using the contents of Args to determine argc & argv, and the contents of
  // EnvVars to determine envp.
  //
  Function *EntryFn = Mod->getFunction("main");
  if (!EntryFn) {
    WithColor::error(errs(), argv[0])
        << '\'' << "main" << "\' function not found in module.\n";
    return -1;
  }

  // Reset errno to zero on entry to main.
  errno = 0;

  int Result = -1;

  if (true) {
    // If the program doesn't explicitly call exit, we will need the Exit
    // function later on to make an explicit call, so get the function now.
    Constant *Exit = Mod->getOrInsertFunction("exit", Type::getVoidTy(Context),
                                                      Type::getInt32Ty(Context));

    // Run static constructors.
    EE->runStaticConstructorsDestructors(false);

    // Trigger compilation separately so code regions that need to be
    // invalidated will be known.
    (void)EE->getPointerToFunction(EntryFn);

    // Run main.
    Result = EE->runFunctionAsMain(EntryFn, InputArgv, envp);

    // Run static destructors.
    EE->runStaticConstructorsDestructors(true);

    // If the program didn't call exit explicitly, we should call it now.
    // This ensures that any atexit handlers get called correctly.
    if (Function *ExitF = dyn_cast<Function>(Exit)) {
      std::vector<GenericValue> Args;
      GenericValue ResultGV;
      ResultGV.IntVal = APInt(32, Result);
      Args.push_back(ResultGV);
      EE->runFunction(ExitF, Args);
      WithColor::error(errs(), argv[0]) << "exit(" << Result << ") returned!\n";
      abort();
    } else {
      WithColor::error(errs(), argv[0])
          << "exit defined with wrong prototype!\n";
      abort();
    }
  } 

  return Result;
}
