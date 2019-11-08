// RUN: %clang -O2 -S -emit-llvm %s -o %t.ll
// RUN: %opt -load %lib_basic -mba -S %t.ll -o %t.obf.ll
// RUN: %opt -load %lib_z3 -ir2z3 %t.obf.ll 1>/dev/null 2>%t.out
// RUN: %FileCheck %s < %t.out
//
// CHECK: model 
// CHECK-DAG: a -> 
// CHECK-DAG: b ->

#include <stdio.h>

int __attribute__((section("solve.eq.10"))) add(int a, int b) {
  return a+b;
}

int main() {
  for(int i = 0; i != 256; ++i) {
    for(int j = 0; j != 256; ++j) {
      printf("%d + %d = %d\n", i, j, add(i, j));
    }
  }
  return 0;
}
