#include "AbstractFilterFactory.h"
#include <llvm/Support/raw_ostream.h>
#include <llvm/ADT/SmallPtrSet.h>
#include <llvm/ADT/SmallVector.h>
#include <llvm/IR/Instruction.h>

using namespace llvm;

SmallPtrSet<Value*, 32> GetBackwardsSlice(Instruction &II) {
  // TODO Compute the backwards slice of II
  // * it can be done in an iterative way
  // * if can also be done by doing a single bfs in the good direction
  SmallVector<Value*, 32> ValuesToCheck;
  SmallPtrSet<Value*, 32> Slice;
  SmallPtrSet<Value*, 32> SeenInstructions;

  auto PushValue = [&](Value* V) {
      ValuesToCheck.push_back(V);
  };

  ValuesToCheck.push_back(&II);

  // Uses -> relacion entre user y un value
  // checkear si te la posicion tambien.

  while(ValuesToCheck.size() > 0) {
    Value* currentSlize = ValuesToCheck.pop_back_val();
    
    User* currentUser = dyn_cast<User>(currentSlize);
    if (!currentUser) {
      //count == 0
      if (SeenInstructions.count(currentUser) == 0) {
        std::for_each(currentUser->operands().begin(), currentUser->operands().end(), PushValue);
        SeenInstructions.insert(currentUser);
      }
    } else {

      Instruction* currentInst = dyn_cast<Instruction>(currentSlize);
      if (!currentInst) {
        
        // Si no es null, es instruccion
        if (SeenInstructions.count(currentInst) == 0) {
          std::for_each(currentInst->operands().begin(), currentInst->operands().end(), PushValue);
          SeenInstructions.insert(currentInst);
        }
      } else {
        
        //Si es Null, tengo un value
        if (Slice.count(currentSlize) == 0) {
          Slice.insert(currentSlize);
        }
      }
    }
  }


  return Slice;
}

struct SmartFilterFactory : public AbstractFilterFactory {
  FilterTy createFilter(llvm::Value& I) override {
    Instruction *II = dyn_cast<Instruction>(&I);
    if(!II)
      return [](Value& V) { return true; };

    // compute the backwards slice of I
    auto BackwardsSlice = GetBackwardsSlice(*II);

    // return a filter such that filter(V) <-> V is not used to compute I 
    return [BS=std::move(BackwardsSlice)](llvm::Value& V) {
      return BS.count(&V) == 0;
    };
  }
};

AbstractFilterFactory& AbstractFilterFactory::get() {
  static SmartFilterFactory _Smart;
  return _Smart;
}
