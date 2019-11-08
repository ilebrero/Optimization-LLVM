// RUN: %clang -O2 -S -emit-llvm %s -o %t.ll
// RUN: %opt -load %lib_basic -mba -S %t.ll -o %t.obf.ll
// RUN: %opt -load %lib_z3 -ir2z3 %t.obf.ll 1>/dev/null 2>%t.out
// RUN: %FileCheck %s < %t.out
//
// CHECK: model 

#include <stdio.h>

int  add(int a, int b) {
  return a+b;
}

int __attribute__((section("solve.eq.0"))) main(int argc, char** argv) {
  if(argc < 2) {
    return -1;
  }
  int n = atoi(argv[1]);
  if(n & 2) {
    printf("das is gut");
    return 0;
  } else {
    printf("bad!");
    return 7;
  }
}
