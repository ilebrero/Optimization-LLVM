// RUN: %clang -O2 %s -o %t.ref
// RUN: %clang -O2 -S -emit-llvm %s -o %t.ll
// RUN: %opt -load %lib_basic -opaque-constants -opaque-constants-algo=0 -S %t.ll -o %t.obf.ll
// RUN: %clang %t.obf.ll -lm -o %t 
// RUN: %t.ref > %t.ref.out
// RUN: %t > %t.out
// RUN: diff %t.out %t.ref.out
//
// two compilation yield the exact same code !
// RUN: %opt -load %lib_basic -opaque-constants -opaque-constants-algo=0 -S %t.ll -o %t.obf2.ll
// RUN: diff %t.obf.ll %t.obf2.ll

#include <stdio.h>

// CHECK: @main
// CHECK-NOT: i{{.*}} 1234 
int main() {
  for(int i = 0; i != 256; ++i) {
    for(int j = 0; j != 256; ++j) {
      printf("%d + %d + stuff = %d\n", i, j, i+j+1234);
    }
  }
  return 0;
}
