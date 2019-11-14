#include "llvm/Pass.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Transforms/Utils/ModuleUtils.h"
#include "llvm/Support/raw_ostream.h"

#include "InjectBuiltin.h"
#include "builtins.h"

using namespace llvm;

namespace {

static cl::opt<bool> Startup("startup", cl::init(true), cl::desc("Inject startup checks."));
static cl::opt<bool> Inject("inject", cl::init(true), cl::desc("Inject checks in the code."));
static cl::opt<unsigned> InjectThreashold("inject-threshold", cl::init(0), cl::desc("Inject checks in executed functions under a threashold. 0 means do not use profile."));

// TODO create a new function with type void(void), if the test fails, write a 0 on the address 0x0 to crash the application
// TODO add the newly created function to the startup functions using llvm::appendToGlobalCtors with a priority of 500 
void InsertStartupCheck(Function *DetectPTrace) {
  Module* M = DetectPTrace->getParent();
  LLVMContext &C = M->getContext();

  // Armar la funcion general
  std::vector<Type*> Arguments;
  Type* ReturnType = Type::getVoidTy(C);

  // Todos tienen el mismo tipo
  FunctionType* Aridad = FunctionType::get(ReturnType, Arguments, false);
  
  // Funciones
  Function* StartupCheckFunction = Function::Create(Aridad, llvm::GlobalValue::LinkageTypes::ExternalLinkage, "__startup_check", M);

  // Armo los bloques 
  BasicBlock* FirstBlock = BasicBlock::Create(C, "FailIfDebug", StartupCheckFunction);
  BasicBlock* EndBlock   = BasicBlock::Create(C, "endBlock", StartupCheckFunction);
  BasicBlock* CrashBlock = BasicBlock::Create(C, "crashBlock", StartupCheckFunction);

  // Armar los builders
  IRBuilder<> MainBuilder(FirstBlock);
  IRBuilder<> CrashBlockBuilder(CrashBlock);
  IRBuilder<> EndBlockBuilder(EndBlock);

  // Constantes
  Value* ConstCero    = ConstantInt::get(Type::getInt64Ty(C), 0);
  Value* ConstNullPtr = ConstantPointerNull::get(PointerType::get(Type::getInt64Ty(C), 0));

  // Crash Block
  CrashBlockBuilder.CreateStore(ConstCero, ConstNullPtr, false);
  CrashBlockBuilder.CreateRetVoid();

  // Create call a la instancia
  CallInst* DetectPTraceCall = MainBuilder.CreateCall(DetectPTrace);
  Value* ConstCeroPTrace = ConstantInt::get(DetectPTraceCall->getType(), 0);
  Value* DetectPTraceResultcomparission = MainBuilder.CreateICmpEQ(DetectPTraceCall, ConstCeroPTrace, "comparassion");

  //Si es 0 no crasheo
  BranchInst* CheckDetectPTraceCall = MainBuilder.CreateCondBr(DetectPTraceResultcomparission, EndBlock, CrashBlock);

  // Crash y End Block fin
  EndBlockBuilder.CreateRetVoid();

  // Appendear a las globales de init
  llvm::appendToGlobalCtors(*M, StartupCheckFunction, 500);
}


bool IsInjectCandidateFun(Function &F) {
  if(InjectThreashold == 0)
    return true;

  auto EntryCount = F.getEntryCount();
  
  // only insert in executed functions under a threshold
  if(!EntryCount)
    return false;
  return EntryCount.getCount() < InjectThreashold;
}

// TODO return true if it is a BinaryOperator, ReturnInst or a CallInst with an integer operand 
bool IsInjectCandidateInst(Instruction &I) {
  if( !(
    isa<BinaryOperator>(I) 
    || isa<ReturnInst>(I) 
    || isa<CallInst>(I)
  )) return false;
  
  bool ContainsIntegerOperand = false;

  auto IsIntegerOperand = [&](Value* V) {
      ContainsIntegerOperand |= isa<IntegerType>(V->getType());
  };
  
  std::for_each(
    I.op_begin(), 
    I.op_end(), 
    IsIntegerOperand);

  return ContainsIntegerOperand;
}

// TODO Call the check and corrupt one of the operands if the check is positive 
void DoInject(Instruction &I, Function* Detect) {
  auto operand = I.op_begin();
  while(!operand->get()->getType()->isIntegerTy())
    operand++;

  Use* O = operand;
  IRBuilder<> B(&I);

  CallInst* DetectCallResult = B.CreateCall(Detect);
  Value* CorrupedValue = B.CreateAdd(O->get(), DetectCallResult, "CualquierCosa");
  O->set(CorrupedValue);
}

  // TODO: Find an inject candidate and do the injection
void InsertInjectChecks(Function* DetectReadlink) {
  for(Function &F : *DetectReadlink->getParent()) {
    if(&F == DetectReadlink || !IsInjectCandidateFun(F))
      continue;

    for (BasicBlock &B : F) {
      for (Instruction &I : B) {
        if (IsInjectCandidateInst(I)) {
          DoInject(I, DetectReadlink);
        }
      }      
    }
  }
}

struct AntiDebug : public ModulePass {
  static char ID;
  AntiDebug() : ModulePass(ID) {}

  bool runOnModule(Module &M) override {
    if(Inject) {
      // TODO Inject the detect_readlink anti debug
      Function *DetectReadlink = InjectBuiltin(readlink_gdb_c, M, "detect_readlink");
      if(!DetectReadlink)
        llvm::report_fatal_error("Could not load builtin", false);
      DetectReadlink->setLinkage(Function::PrivateLinkage);

      InsertInjectChecks(DetectReadlink);
    }

    if(Startup) {
      // TODO Inject the detect_ptrace anti debug
      Function *DetectPTrace = InjectBuiltin(detect_ptrace_c, M, "detect_ptrace");
      if(!DetectPTrace)
        llvm::report_fatal_error("Could not load builtin", false);
      DetectPTrace->setLinkage(Function::PrivateLinkage);

      InsertStartupCheck(DetectPTrace);
    }
    return Startup || Inject;
  }
};
char AntiDebug::ID = 0;
}

static RegisterPass<AntiDebug> X("anti-debug", 
    "Inject anti-debug verifications in the executable.", 
    false, false);
