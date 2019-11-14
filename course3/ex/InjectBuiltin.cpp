#include "InjectBuiltin.h"
#include "clang_config.h"

#include "llvm/IR/Module.h"
#include "llvm/Bitcode/BitcodeReader.h"
#include "llvm/Bitcode/BitcodeReader.h"
#include "llvm/Linker/Linker.h"
#include "llvm/Support/MemoryBuffer.h"
#include "llvm/Support/FileSystem.h"

using namespace llvm;

// Usar esto
// CCode es el codigo a injectar
// M el modulo donde se quiere injectar

// En gidra se puede ver el ptero de ejecucion que va a init array y se puede ver si en init esta injectado ptrace o algo asi
// Para builear: se genera un builtin.h que tiene los checks antidebug
// Builtins.h se genera con builtins.py
// Ej: "detect_ptrace" | detecta gdb usando ptrace | toma 
// Los cheqcks dan 0 si esta todo bien | 1 si no.
// Los tests imprimen algo, lo ejecutan como siempre. Otra cosa es correr la app con gdb para detectarlo

llvm::Function* InjectBuiltin(llvm::StringRef const CCode, llvm::Module &M, 
                              llvm::StringRef const FName) {
  if(Function *F = M.getFunction(FName))
    return F;

  // get a tmp file
  std::string TempC = std::string(std::tmpnam(nullptr)) + ".c";
  std::string TempBC = std::string(std::tmpnam(nullptr)) + ".bc";

  // write the c code
  {
    std::error_code EC;
    raw_fd_ostream fd(TempC, EC);
    if(EC) {
      errs() << "error writing temporary builtin code to " << TempC << "\n";
      errs() << EC.message() << "\n";
      return nullptr;
    }
    fd << CCode;
  }

  // call clang using system. in a real world case forward the platform flags. 
  Twine Command = llvm::Twine(clang_path) + " -O2 -x c " + TempC + " -c -emit-llvm -o " + TempBC;
  int ret_code = system(Command.str().c_str()); // ugly A
  
  if(ret_code != 0) {
    errs() << "error calling external clang command to compile builtin.\n";
    errs() << "command: " << Command << "\n";
    return nullptr;
  }

  // recover the .ll
  auto BuiltinRawIR = MemoryBuffer::getFileAsStream(TempBC);
  if(!BuiltinRawIR) {
    errs() << "error reading builtin ir from file.\n";
    return nullptr;
  }

  auto BuiltinM = llvm::parseBitcodeFile(*BuiltinRawIR.get(), M.getContext());
  if(!BuiltinM) {
    errs() << "error parsing builtin ir.\n";
    
    handleAllErrors(BuiltinM.takeError(), 
         [](ErrorInfoBase const &E) { errs() << E.message() << "\n"; return; });
    return nullptr;
  }

  // link
  std::unique_ptr<Module> BuiltinIR(std::move(BuiltinM.get()));
  if(Linker::linkModules(M, std::move(BuiltinIR))) {
    errs() << "error while linking builtin ir.\n";
    return nullptr;
  }

  Function* F = M.getFunction(FName);
  if(!F) {
    errs() << "could not find function " << FName << " in builtin ir.\n";
    return nullptr;
  }

  return F;
}
