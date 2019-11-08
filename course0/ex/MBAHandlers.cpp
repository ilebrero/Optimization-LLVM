#include "MBAHandlers.h"

#include "llvm/IR/Instruction.h"
#include "llvm/IR/Constant.h"

using namespace llvm;
  
Value* HandleAdd(Instruction &I) {
  IRBuilder<> B(&I);

  // TODO: Recover the operands X,Y. See User::getOperand
  Value* X = I.getOperand(0);
  Value* Y = I.getOperand(1);

  // TODO: Get the constant one for the shift left. See ConstantInt::get and Value::getType 
  Value* constUno = ConstantInt::get((IntegerType*) X->getType(), 1);

  // TODO: Do ((X&Y)<<1 + (X^Y)). see IRBuilder<>
  // 1_ X&Y
  Value* XAndY = B.CreateAnd(X, Y, "XAndY");

  // 2_ 1_ << 1
  Value* shiftUno = B.CreateShl(XAndY, constUno, "shift1");

  // 3_ X^Y
  Value* XXorY = B.CreateXor(X, Y, "XXorY");
  
  // 4_ 3_ + 4_ 
  Value* result = B.CreateAdd(shiftUno, XXorY, "Result");

  return result;
}