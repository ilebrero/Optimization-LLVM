#ifndef ID_UTILS
#define ID_UTILS

namespace llvm {
  class Instruction;
}

void SetId(llvm::Instruction &I, size_t);
size_t GetId(llvm::Instruction &I); // -1 is no id

#endif
