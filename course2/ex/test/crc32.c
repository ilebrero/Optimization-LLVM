// RUN: %clang -S -emit-llvm -O2 %s -o %t.ll
//
// build a reference
// RUN: %clang -O2 %t.ll -o %t.ref
// RUN: %t.ref 01234 > %t.ref.out 
//
// obfuscate
// RUN: %opt -S -load %lib_basic -mba -opaque-constants -mba -opaque-constants-algo=0 -O3 %t.ll -o %t.oc.ll
//
// let's skip dissasembling, enumerate and instrument 
// RUN: %opt -S -load %lib_instrument -enumerate -O2 %t.oc.ll -o %t.enum.ll
// RUN: %opt -S -load %lib_instrument -instrument -O2 %t.enum.ll -o %t.instr.ll 
// RUN: RUNTIME_PATH=`dirname %lib_instrument_runtime`
// RUN: %clang -O2 %t.instr.ll -L ${RUNTIME_PATH} -rpath ${RUNTIME_PATH} -lInstrumentValuesRuntime -o %t.instr
//
// fuzz the input !
// RUN: rm -f %t.profile
// RUN: INSTR_FILE=%t.profile %t.instr a
// RUN: INSTR_FILE=%t.profile %t.instr ba
// RUN: INSTR_FILE=%t.profile %t.instr cba
// RUN: INSTR_FILE=%t.profile %t.instr abcd
// RUN: INSTR_FILE=%t.profile %t.instr 98761 
// RUN: INSTR_FILE=%t.profile %t.instr abcdef
// RUN: INSTR_FILE=%t.profile %t.instr abcdefg
// RUN: INSTR_FILE=%t.profile %t.instr abcdefgh
//
// patch !
// RUN: %opt -S -load %lib_instrument -patch-constants -patch-constants-profile=%t.profile -O2 %t.enum.ll -o %t.patch.ll 
// RUN: %clang -O2 %t.patch.ll -o %t.patch
// RUN: %t.patch 01234 > %t.patch.out 
//
// behaves the same as the original
// RUN: diff %t.ref.out %t.patch.out
//
// look for crc32 signature
// RUN: %FileCheck %s < %t.patch.ll
// CHECK: {{3988292384|-306674912}}

#include <stdio.h>
#include <stdint.h>

// CRC32
static uint32_t crc32(const unsigned char *message) {
  int i, j;
  uint32_t byte, crc, mask;

  i = 0;
  crc = 0xFFFFFFFF;
  // main_loop
  while (message[i] != 0) {
    byte = message[i]; // Get next byte.
    crc = crc ^ byte;
    for (j = 7; j >= 0; j--) { // Do eight times.
      mask = -(crc & 1);
      crc = (crc >> 1) ^ (0xEDB88320 & mask);
    }
    i = i + 1;
  }
  return ~crc;
}

int main(int argc, char **argv) {
  if (argc < 2) {
    fprintf(stderr, "Usage: %s message\n", argv[0]);
    return 1;
  }

  const char *msg = argv[1];
  const unsigned int crc = crc32((const unsigned char *)msg);

  printf("0x%04x-%s\n", crc, msg);
  return 0;
}
// end CRC32
