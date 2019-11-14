// RUN: %clang %s -S -emit-llvm -o %t.ll
// RUN: %opt %t.ll -S -load %lib_antidebug -anti-debug -startup=true -inject=true -o %t.inject.ll
//
// CHECK-DAG: detect_readlink
// CHECK-DAG: detect_ptrace
