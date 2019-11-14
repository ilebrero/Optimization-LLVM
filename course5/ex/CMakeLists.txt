add_llvm_library(WhiteboxMe WhiteboxMe.cpp SHARED)

target_include_directories(WhiteboxMe PRIVATE ${LLVM_INCLUDE_DIRS} ${Z3_INCLUDE_DIRS})
target_compile_definitions(WhiteboxMe PRIVATE ${LLVM_DEFINITIONS})
target_link_directories(WhiteboxMe PRIVATE ${LLVM_LIBRARY_DIRS})

add_subdirectory(test)
