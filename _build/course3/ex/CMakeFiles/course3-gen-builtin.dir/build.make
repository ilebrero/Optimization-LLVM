# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.15

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /home/nacho/Documentos/LLVM/_deps/cmake/bin/cmake

# The command to remove a file.
RM = /home/nacho/Documentos/LLVM/_deps/cmake/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/nacho/Documentos/LLVM

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/nacho/Documentos/LLVM/_build

# Utility rule file for course3-gen-builtin.

# Include the progress variables for this target.
include course3/ex/CMakeFiles/course3-gen-builtin.dir/progress.make

course3/ex/CMakeFiles/course3-gen-builtin: course3/ex/builtins.h


course3/ex/builtins.h: ../course3/ex/builtins.py
course3/ex/builtins.h: ../course3/ex/builtin/detect_ptrace.c
course3/ex/builtins.h: ../course3/ex/builtin/readlink_gdb.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/nacho/Documentos/LLVM/_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating builtin header"
	cd /home/nacho/Documentos/LLVM/course3/ex && /home/nacho/anaconda3/bin/python3.6 ./builtins.py builtin/readlink_gdb.c builtin/detect_ptrace.c > /home/nacho/Documentos/LLVM/_build/course3/ex/builtins.h

course3-gen-builtin: course3/ex/CMakeFiles/course3-gen-builtin
course3-gen-builtin: course3/ex/builtins.h
course3-gen-builtin: course3/ex/CMakeFiles/course3-gen-builtin.dir/build.make

.PHONY : course3-gen-builtin

# Rule to build all files generated by this target.
course3/ex/CMakeFiles/course3-gen-builtin.dir/build: course3-gen-builtin

.PHONY : course3/ex/CMakeFiles/course3-gen-builtin.dir/build

course3/ex/CMakeFiles/course3-gen-builtin.dir/clean:
	cd /home/nacho/Documentos/LLVM/_build/course3/ex && $(CMAKE_COMMAND) -P CMakeFiles/course3-gen-builtin.dir/cmake_clean.cmake
.PHONY : course3/ex/CMakeFiles/course3-gen-builtin.dir/clean

course3/ex/CMakeFiles/course3-gen-builtin.dir/depend:
	cd /home/nacho/Documentos/LLVM/_build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/nacho/Documentos/LLVM /home/nacho/Documentos/LLVM/course3/ex /home/nacho/Documentos/LLVM/_build /home/nacho/Documentos/LLVM/_build/course3/ex /home/nacho/Documentos/LLVM/_build/course3/ex/CMakeFiles/course3-gen-builtin.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : course3/ex/CMakeFiles/course3-gen-builtin.dir/depend

