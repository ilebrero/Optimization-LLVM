#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Constant.h"
#include "llvm/ADT/DenseMap.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/Support/raw_ostream.h"

#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"

#include "llvm/Support/CommandLine.h"

#include "MBAHandlers.h"

#include <random>
#include <algorithm>

using namespace llvm;

namespace {

static cl::opt<double> Ratio("mba-ratio", 
    cl::init(1.0), cl::desc("Ratio to control the MBA pass"));

struct MBA : public FunctionPass {
  static char ID;
  MBA() : FunctionPass(ID) {}

  bool runOnFunction(Function &F) override {

    DenseMap<unsigned, HandlerTy> Handlers;
    Handlers.insert(std::make_pair<unsigned, HandlerTy>(Instruction::Add, HandleAdd));
    // TODO: Add handlers for A-B and A^B
    // TODO (more difficult, they require a cast): Add handlers for A&B and A|B

    SmallVector<Instruction*, 8> Candidates;

    for(BasicBlock &B : F) {
      for(Instruction &I : B) {
        if(Handlers.count(I.getOpcode()))
            Candidates.push_back(&I);
      }
    }

    // Ver 
    // Keep only Candidates.size()*ratio candidates
    std::mt19937 RandomEngine(0);
    std::shuffle(Candidates.begin(), Candidates.end(), RandomEngine);
    size_t N = std::max<size_t>(std::min<size_t>(Ratio * Candidates.size(), Candidates.size()), 0);
    Candidates.erase(Candidates.begin()+N, Candidates.end());

    for(Instruction *I : Candidates) {
      IRBuilder<> B(I);
      Value *NewI = Handlers[I->getOpcode()](*I);

      if (NewI != NULL) {
        // TODO: replace old instruction with new, see Value::replaceAllUsesWith
        I->replaceAllUsesWith(NewI);
        I->eraseFromParent();
      }
    }

    // for(Instruction *I : Candidates) {
    //   // TODO: erase old instructions, see Instruction::eraseFromParent 

    // }

    return !Candidates.empty();
  }
}; 
char MBA::ID = 0;
} 

static RegisterPass<MBA> X("mba", "Mixed-Boolean-Arithmetic", false, false);
