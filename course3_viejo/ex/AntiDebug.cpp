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

void InsertStartupCheck(Function *DetectPTrace) {

  // TODO create a new function with type void(void), if the test fails, write a 0 on the address 0x0 to crash the application 
  // TODO add the newly created function to the startup functions using llvm::appendToGlobalCtors with a priority of 500 
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

bool IsInjectCandidateInst(Instruction &I) {
  // TODO retur true if it is a BinaryOperator, ReturnInst or a CallInst with an integer operand 
  return false;
}

void DoInject(Instruction &I, Function* Detect) {
  auto operand = I.op_begin();
  while(!operand->get()->getType()->isIntegerTy())
    operand++;

  Use* O = operand;
  IRBuilder<> B(&I);

  // TODO Call the check and corrupt one of the operands if the check is positive 
}

void InsertInjectChecks(Function* DetectReadlink) {
  // TODO Find an inject candidate and do the injection
  for(Function &F : *DetectReadlink->getParent()) {
    if(&F == DetectReadlink)
      continue;

  }
}

struct AntiDebug : public ModulePass {
  static char ID;
  AntiDebug() : ModulePass(ID) {}

  bool runOnModule(Module &M) override {
    if(Inject) {
      // TODO Inject the detect_readlink anti debug
      Function *DetectReadlink;
      if(!DetectReadlink)
        llvm::report_fatal_error("Could not load builtin", false);
      DetectReadlink->setLinkage(Function::PrivateLinkage);

      InsertInjectChecks(DetectReadlink);
    }

    if(Startup) {
      // TODO Inject the detect_ptrace anti debug
      Function *DetectPTrace;
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
