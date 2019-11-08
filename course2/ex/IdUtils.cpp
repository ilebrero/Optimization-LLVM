#include "llvm/IR/Instruction.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Metadata.h"

using namespace llvm;

const char InstrIdMDStr[] = "instr.id";

void SetId(llvm::Instruction &I, size_t Id) {
  LLVMContext &C = I.getContext();
  Type* I64 = Type::getInt64Ty(C);
  
  Constant* IdC = ConstantInt::get(I64, Id);
  Metadata* IdMD = ConstantAsMetadata::get(IdC);

  MDNode* MD = MDNode::get(C, {IdMD});
  I.setMetadata(InstrIdMDStr, MD);
}

size_t GetId(llvm::Instruction &I) {
  MDNode* MD = I.getMetadata(InstrIdMDStr);
  if(!MD)
    return -1;
  ConstantAsMetadata &IdMD = cast<ConstantAsMetadata>(*MD->getOperand(0));
  ConstantInt *IdC = cast<ConstantInt>(IdMD.getValue());
  return IdC->getZExtValue();
}
