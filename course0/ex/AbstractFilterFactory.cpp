#include "AbstractFilterFactory.h"
#include <llvm/Support/raw_ostream.h>

using namespace llvm;

AbstractFilterFactory& __attribute__((weak)) AbstractFilterFactory::get() {
  static NoFilter _No;
  return _No;
}
