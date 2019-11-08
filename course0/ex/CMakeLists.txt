add_llvm_library(Basic MBA.cpp OpaqueConstants.cpp MBAHandlers.cpp AbstractFilterFactory.cpp SHARED)

target_include_directories(Basic PRIVATE ${LLVM_INCLUDE_DIRS})
target_compile_definitions(Basic PRIVATE ${LLVM_DEFINITIONS})
target_link_directories(Basic PRIVATE ${LLVM_LIBRARY_DIRS})

add_subdirectory(test)
