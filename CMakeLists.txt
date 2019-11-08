cmake_minimum_required(VERSION 3.13)

project(course_uba)

if("${CMAKE_CURRENT_SOURCE_DIR}" STREQUAL "${CMAKE_CURRENT_BINARY_DIR}")
  message(FATAL_ERROR "Do not set the build directory equal to the source directory!")
endif()

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake/")

find_package(LLVM 8.0 REQUIRED CONFIG)
find_package(Python 3 REQUIRED)
# find_package(Z3 4.8 REQUIRED)

list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")
include(AddLLVM)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_subdirectory(course0)
add_subdirectory(course1)
add_subdirectory(course2)
add_subdirectory(course3)
add_subdirectory(course4)
add_subdirectory(course5)
