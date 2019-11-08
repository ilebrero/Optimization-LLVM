add_library(InstrumentValuesRuntime SHARED Runtime/InstrumentValuesRuntime.cpp)

add_llvm_library(Instrument Enumerate.cpp InstrumentValues.cpp PatchConstantValues.cpp IdUtils.cpp ProfileFile.cpp SHARED)

target_include_directories(Instrument PRIVATE ${LLVM_INCLUDE_DIRS})
target_compile_definitions(Instrument PRIVATE ${LLVM_DEFINITIONS})
target_link_directories(Instrument PRIVATE ${LLVM_LIBRARY_DIRS})

add_subdirectory(test)
