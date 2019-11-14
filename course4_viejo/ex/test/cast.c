// RUN: %clang -O2 -S -emit-llvm %s -o %t.ll
// RUN: %opt -load %lib_basic -mba -S %t.ll -o %t.obf.ll
// RUN: %opt -load %lib_z3 -ir2z3 %t.obf.ll 1>/dev/null 2>%t.out
// RUN: %FileCheck %s < %t.out
//
// CHECK: model 

#include <stdio.h>
#include <stdint.h>

int  add(int a, int b) {
  return a+b;
}

int __attribute__((section("solve.eq.1"))) main(int argc, char** argv) {
  uint32_t x = atoi(argv[1]);
  uint32_t y = atoi(argv[2]);
  return (uint8_t)((x+y)>>31); 
}
