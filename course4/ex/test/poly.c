// RUN: %clang -O2 -S -emit-llvm %s -o %t.ll
// RUN: %opt -load %lib_basic -mba -opaque-constants -O2 -S %t.ll -o %t.obf.ll
// RUN: %opt -load %lib_z3 -ir2z3 %t.obf.ll 1>/dev/null 2>%t.out
// RUN: %FileCheck %s < %t.out
//
// CHECK: model 
// CHECK: x 
// CHECK: #x0002
#include <stdint.h>

uint64_t __attribute__((section("solve.eq.0"))) polynome(uint16_t x) {
  return 2*x*x*x*x + 13*x*x*x - 7*x*x - 72*x + 36;
}
