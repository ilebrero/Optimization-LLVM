#include "llvm/Pass.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Support/raw_ostream.h"

#include "IdUtils.h"

using namespace llvm;

namespace {

bool IsInstrumentable(Instruction &I) {
  return I.getType()->isIntegerTy() && !I.isTerminator() && !isa<PHINode>(I);
}

struct Enumerate : public ModulePass {
  static char ID;
  Enumerate() : ModulePass(ID) {}

  bool runOnModule(Module &M) override {
    size_t Id = 0;

    for(Function &F : M) {
      for(Instruction &I : instructions(F)) {
        if(IsInstrumentable(I)) {
          SetId(I, Id++);
        }
      }
    }
    return true;
  }
};
char Enumerate::ID = 0;
} 

static RegisterPass<Enumerate> X("enumerate", 
    "Assign an ID for every instruction to instrument", 
    false, false);
