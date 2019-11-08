get_target_property(Basic_SRC Basic SOURCES)
get_target_property(Basic_SRC_DIR Basic SOURCE_DIR)

foreach(SRC ${Basic_SRC})
  if(SRC MATCHES ".cpp$")
    list(APPEND Basic_SRC_FULL_PATH "${Basic_SRC_DIR}/${SRC}")
  endif()
endforeach(SRC)

add_llvm_library(SmartBasic ${Basic_SRC_FULL_PATH} SmartFilterFactory.cpp SHARED)

target_include_directories(SmartBasic PRIVATE ${LLVM_INCLUDE_DIRS} ${Basic_SRC_DIR})
target_compile_definitions(SmartBasic PRIVATE ${LLVM_DEFINITIONS})
target_link_directories(SmartBasic PRIVATE ${LLVM_LIBRARY_DIRS})

add_subdirectory(test)
