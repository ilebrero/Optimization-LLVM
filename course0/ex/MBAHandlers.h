#include <functional>
#include "llvm/IR/IRBuilder.h"

using HandlerTy = std::function<llvm::Value*(llvm::Instruction &I)>;

llvm::Value* HandleAdd(llvm::Instruction &I); 
