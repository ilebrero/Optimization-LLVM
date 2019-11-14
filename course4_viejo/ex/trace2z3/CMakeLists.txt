add_llvm_executable(Trace2Z3 Trace2Z3.cpp)

set_target_properties(Trace2Z3
  PROPERTIES
  RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/../
)

llvm_map_components_to_libnames(llvm_libs CodeGen Core ExecutionEngine IRReader 
  Interpreter MC MCJIT Object OrcJIT RuntimeDyld SelectionDAG Support Target TransformUtils native)

target_include_directories(Trace2Z3 PRIVATE ${LLVM_INCLUDE_DIRS} ${Z3_INCLUDE_DIR})
target_compile_definitions(Trace2Z3 PRIVATE ${LLVM_DEFINITIONS})
target_link_directories(Trace2Z3 PRIVATE ${LLVM_LIBRARY_DIRS})
target_link_libraries(Trace2Z3 PRIVATE z3 ${llvm_libs})
