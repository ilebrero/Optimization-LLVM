#include "llvm/Pass.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Support/raw_ostream.h"

#include "IdUtils.h"
#include "ProfileFile.h"

using namespace llvm;

namespace {

static cl::opt<std::string> ProfileFile("patch-constants-profile", 
    cl::init(""), cl::desc("Path to the profile file."));

bool IsConstant(Id2InstrValues const &Profile, size_t Id) {
  // TODO return true if all the entries for a given ID have the same value
  if (Profile.count(Id) > 0 && Profile.at(Id).size() > 0) {
    const std::vector InstrValues = Profile.at(Id);
    const size_t val = InstrValues[0];
    
    for (const size_t curr : InstrValues) {
      if (curr != val) {
        return false;
      }
    }

    return true;
  }

  return false;
}

struct PatchValues : public ModulePass {
  static char ID;
  PatchValues() : ModulePass(ID) {}

  bool runOnModule(Module &M) override {

    if(ProfileFile.empty())
      return false;

    auto Profile = ReadProfile(ProfileFile);

    if(Profile.empty())
      return false;

    for (Function &F : M) {
      for (BasicBlock &B : F) {
        for (Instruction &I : B) {

          size_t InstructionID = GetId(I);
          if (InstructionID != -1) {
              if (IsConstant(Profile, InstructionID)) {
                  size_t constantValue = Profile[InstructionID][0];
                  Value* constant = ConstantInt::get(I.getType(), constantValue);
                  I.replaceAllUsesWith(constant);
              }
          }
        }
      }
    }
    // TODO iterate over all the instructions,
    // get the constant value for the associated Id, and replace all the uses with the appropiate value
    // use ConstantInt::get(...)

    return true;
  }
};
char PatchValues::ID = 0;
} 

static RegisterPass<PatchValues> X("patch-constants", 
    "Patch instructions that always yield a constant value in profiling.", 
    false, false);
