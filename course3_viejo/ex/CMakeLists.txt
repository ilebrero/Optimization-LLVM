set(BUILTIN_FILE ${CMAKE_CURRENT_BINARY_DIR}/builtins.h)
set(CLANG_CONFIG_FILE ${CMAKE_CURRENT_BINARY_DIR}/clang_config.h)

configure_file(clang_config.h.in ${CLANG_CONFIG_FILE})

add_custom_command(OUTPUT ${BUILTIN_FILE}
  COMMAND ${Python_EXECUTABLE} ./builtins.py builtin/readlink_gdb.c builtin/detect_ptrace.c > ${BUILTIN_FILE}
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
  DEPENDS builtins.py builtin/detect_ptrace.c builtin/readlink_gdb.c
  COMMENT "Generating builtin header"  
)

add_custom_target(course3-gen-builtin DEPENDS ${BUILTIN_FILE})

add_llvm_library(AntiDebug AntiDebug.cpp InjectBuiltin.cpp SHARED
                 DEPENDS course3-gen-builtin)

target_include_directories(AntiDebug PRIVATE ${LLVM_INCLUDE_DIRS} ${CMAKE_CURRENT_BINARY_DIR})
target_compile_definitions(AntiDebug PRIVATE ${LLVM_DEFINITIONS})
target_link_directories(AntiDebug PRIVATE ${LLVM_LIBRARY_DIRS})

add_subdirectory(test)
