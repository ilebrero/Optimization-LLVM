#include "llvm/Pass.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/CFG.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/Scalar.h"
#include "llvm/Transforms/IPO.h"
#include "llvm/Transforms/Utils.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Support/raw_ostream.h"


using namespace llvm;

namespace {

bool breakLoops(Function &F, LoopInfo &LI) {
  LLVMContext& C = F.getContext();
  SmallVector<Loop*, 4> Loops(LI.begin(), LI.end());

  for(Loop* L : Loops) {
    BasicBlock* H = L->getHeader();

    BasicBlock* U = BasicBlock::Create(C, "unreachable", &F); // unreachable
    new UnreachableInst(C, U);

    BasicBlock* D = BasicBlock::Create(C, "dummy", &F); // block that jumps to the header 
    BranchInst::Create(H, D);

    // a single one thx to loop-simpligy
    BasicBlock *Latch = L->getLoopLatch(); 

    Latch->getTerminator()->replaceUsesOfWith(H, U);

    auto IH = H->begin();
    while(PHINode *PHI = dyn_cast<PHINode>(&*IH)) {
      for(unsigned i = 0; i != PHI->getNumIncomingValues(); ++i) {
        BasicBlock* InB = PHI->getIncomingBlock(i); 
        if(InB == Latch) {
          PHI->setIncomingBlock(i, D);
          PHI->setIncomingValue(i, UndefValue::get(PHI->getType()));
        }
      }
      IH++;
    }
  }

  return false;
}

struct PrepareForZ3 : public ModulePass {
  static char ID;
  PrepareForZ3() : ModulePass(ID) {
  }

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.addRequired<LoopInfoWrapperPass>();
  }

  bool runOnModule(Module &M) override {
    legacy::PassManager PM;
    PM.add(llvm::createLoopUnrollPass(3, false, 999999, 8, true, true, 0, true));
    PM.add(llvm::createFunctionInliningPass(999999));
    PM.add(llvm::createLoopSimplifyPass());
    bool Changed = PM.run(M);

    for(Function &F : M)
      if(!F.isDeclaration())
        Changed |= breakLoops(F, getAnalysis<LoopInfoWrapperPass>(F).getLoopInfo());

    return Changed;
  }
};
char PrepareForZ3::ID = 0;
} 

static RegisterPass<PrepareForZ3> X("prepare-for-z3", 
    "Prepare the code for performing static analysis. Unroll and Inline.", 
    false, false);
