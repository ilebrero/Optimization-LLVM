#include <stdio.h>
#include <stdint.h>

// RUN: %clang -O2 %s -o %t.ref
// RUN: %clang -O2 -S -emit-llvm %s -o %t.ll
// RUN: %opt -load %lib_wb -whitebox-me -O2 -S %t.ll -o %t.obf.ll
// RUN: %clang %t.obf.ll -o %t 
// RUN: %t.ref > %t.ref.out
// RUN: %t > %t.out
// RUN: diff %t.out %t.ref.out > %t.diff
// RUN: %FileCheck %s < %t.obf.ll

#define for_ab(x,y) for(unsigned x = 0; x != 256; x++) for(unsigned y = 0; y != 256; y++)

// CHECK-NOT: add i8
static uint8_t __attribute__((section("whitebox.me"))) __attribute__((noinline)) add(uint8_t a, uint8_t b) {
  return a+b;
}

// CHECK-NOT: xor i8
static uint8_t __attribute__((section("whitebox.me"))) __attribute__((noinline)) xor(uint8_t a, uint8_t b) {
  return a^b;
}

// CHECK-NOT: mul i8
static uint8_t __attribute__((section("whitebox.me"))) __attribute__((noinline)) mul(uint8_t a, uint8_t b) {
  return a*b;
}

static uint8_t __attribute__((section("whitebox.me"))) __attribute__((noinline)) linear(uint8_t a, uint8_t b) {
  return 2*a + b*3;
}

static uint8_t __attribute__((section("whitebox.me"))) __attribute__((noinline)) mix(uint8_t a, float b) {
  return (3*a) + (uint8_t)(b*3.33);
}

int main() {
  
  for_ab(x,y) printf("add(%d, %d) = %d\n", x, y, add(x, y));
  for_ab(x,y) printf("xor(%d, %d) = %d\n", x, y, xor(x, y));
  for_ab(x,y) printf("mul(%d, %d) = %d\n", x, y, mul(x, y));
  for_ab(x,y) printf("linear(%d, %d) = %d\n", x, y, linear(x, y));
  for_ab(x,y) printf("mix(%d, %d) = %d\n", x, y, mix(x, y));
  
  return 0;  
}
