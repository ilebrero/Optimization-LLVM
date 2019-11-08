#include <stdio.h>
#include <stdint.h>

// RUN: %clang -O2 %s -o %t.ref
// RUN: %clang -O2 -S -emit-llvm %s -o %t.ll
// RUN: %opt -load %lib_wb -whitebox-me -O2 -S %t.ll -o %t.obf.ll
// RUN: %clang %t.obf.ll -o %t 
// RUN: %t.ref abcde0123asf10gkdjslfuggfakdf > %t.ref.out
// RUN: %t abcde0123asf10gkdjslfuggfakdf > %t.out
// RUN: diff %t.out %t.ref.out > %t.diff

#define MASK_IF_1(crc) ((uint8_t)(0U-(uint8_t)(crc & 1U))) // gives 0xff if crc&1 == 1
#define ROUND(crc)  ((MASK_IF_1(crc) & ((crc >> 1) ^ 0xB2U)) | ((~MASK_IF_1(crc)) & (crc >> 1))) 

static uint8_t __attribute__((section("whitebox.me"))) __attribute__((noinline)) crc8(const uint8_t *message) {
  if(message[0] == '\0')
    return 0;
  uint8_t crc = 0xff;
  for(unsigned i = 0; message[i]; ++i) {
    crc ^= message[i];
    for(unsigned j = 0; j != 8; ++j)
      crc = ROUND(crc);
  }
  return crc;
}

int main(int argc, char **argv) {
  if (argc < 2) {
    fprintf(stderr, "Usage: %s message\n", argv[0]);
    return 1;
  }

  const char *msg = argv[1];
  const unsigned int crc = crc8((const unsigned char *)msg);

  printf("0x%04x-%s\n", crc, msg);
  return 0;
}
