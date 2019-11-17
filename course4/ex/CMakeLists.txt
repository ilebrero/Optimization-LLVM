add_llvm_library(Function2Z3 Function2Z3.cpp PrepareForZ3.cpp SHARED)

target_include_directories(Function2Z3 PRIVATE ${LLVM_INCLUDE_DIRS} ${Z3_INCLUDE_DIR})
target_compile_definitions(Function2Z3 PRIVATE ${LLVM_DEFINITIONS})
target_link_directories(Function2Z3 PRIVATE ${LLVM_LIBRARY_DIRS})
# target_link_directories(Function2Z3 PRIVATE ${LLVM_LIBRARY_DIRS} ${Z3_LIBRARIES})
target_link_libraries(Function2Z3 PRIVATE z3)
add_subdirectory(test)
# add_subdirectory(trace2z3)