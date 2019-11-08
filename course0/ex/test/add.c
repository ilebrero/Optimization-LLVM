// RUN: %clang -O2 %s -o %t.ref
// RUN: %clang -O2 -S -emit-llvm %s -o %t.ll
// RUN: %opt -load %lib_basic -mba -S %t.ll -o %t.obf.ll
// RUN: %clang %t.obf.ll -o %t 
// RUN: %t.ref > %t.ref.out
// RUN: %t > %t.out
// RUN: diff %t.out %t.ref.out
//
//
// two compilation yield the exact same code !
// RUN: %opt -load %lib_basic -mba -S %t.ll -o %t.obf2.ll
// RUN: diff %t.obf.ll %t.obf2.ll

#include <stdio.h>

// CHECK: @add
// CHECK: {{and|xor|or}}
// CHECK: ret
int add(int a, int b) {
  return a+b;
}

// CHECK: @main
int main() {
  for(int i = 0; i != 256; ++i) {
    for(int j = 0; j != 256; ++j) {
      printf("%d + %d = %d\n", i, j, add(i, j));
    }
  }
  return 0;
}
