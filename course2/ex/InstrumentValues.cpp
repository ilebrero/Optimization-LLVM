#include "llvm/Pass.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Support/raw_ostream.h"

#include "IdUtils.h"

using namespace llvm;

// Cosas Utiles
// Type::getVoid
// Type::getInt64Ty
// FunctionType::get
// Function::Create

// Id2InstrValues Values;
// Values[0] -> std::vector<uint64_t>

namespace {

// Ver el codigo de forma visual: opt -view-eFG a.ll
Function* GetInsturmentFunction(Module &M) {
  Function *F;

  if(F = M.getFunction("__instrument_value"))
    return F;

  LLVMContext &C = M.getContext();

  std::vector<Type*> Arguments;
  Arguments.push_back(Type::getInt64Ty(C));
  Arguments.push_back(Type::getInt64Ty(C));

  Type* ReturnType = Type::getVoidTy(C);

  //is var args????
  FunctionType* Aridad = FunctionType::get(ReturnType, Arguments, true);
  Function* InstrumentValue = Function::Create(Aridad, llvm::GlobalValue::LinkageTypes::ExternalLinkage, "__instrument_value", &M);

  // F = Function::Create(FunctionType::, LinkageType::ExternalLinkage )
  // TODO Create the declaration of the __instrument_value function
  // see FunctionType::Create, Function::Create
  // use ExternalLinkage for the created function ! The type must respect the type of the definition at Runtime/InstrumentValuesRuntime.cpp 
  return InstrumentValue;
} 

struct InstrumentValues : public ModulePass {
  static char ID;
  InstrumentValues() : ModulePass(ID) {}

  bool runOnModule(Module &M) override {
    LLVMContext &C = M.getContext();
    Function* Instrument = GetInsturmentFunction(M); 

    Type *I64 = Type::getInt64Ty(C);

    // TODO Iterate over all the instructions in the module, if it has an id, create a call to the instrumented function
    // You must cast the instruction to an appropiate type
    for (Function &F : M) {
      for (BasicBlock &B : F) {
        for (Instruction &I : B) {
          
          size_t InstructionId = GetId(I);
          if (InstructionId != -1) {

            // Sino con: IRBuilder<> B(I.getParent()->getTerminator());
            IRBuilder<> B(I.getNextNode());
            std::vector<Value*> InstructionArgs;
            
            InstructionArgs.push_back(
              ConstantInt::get(
                I64, 
                InstructionId
              )
            );
            
            InstructionArgs.push_back(
              B.CreateIntCast(
                &I, 
                I64, 
                false
              )
            );
            
            CallInst* Instruemntado = B.CreateCall(Instrument, ArrayRef(InstructionArgs));
          }
        }
      }
    }

    return true;
  }
};
char InstrumentValues::ID = 0;
} 

static RegisterPass<InstrumentValues> X("instrument", 
    "Instrument every instruction containing an id", 
    false, false);
