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

# Utility rule file for install-WhiteboxMe-stripped.

# Include the progress variables for this target.
include course5/ex/CMakeFiles/install-WhiteboxMe-stripped.dir/progress.make

course5/ex/CMakeFiles/install-WhiteboxMe-stripped: course5/ex/libWhiteboxMe.so
	cd /home/nacho/Documentos/LLVM/_build/course5/ex && ../../../_deps/cmake/bin/cmake -DCMAKE_INSTALL_COMPONENT="WhiteboxMe" -DCMAKE_INSTALL_DO_STRIP=1 -P /home/nacho/Documentos/LLVM/_build/cmake_install.cmake

install-WhiteboxMe-stripped: course5/ex/CMakeFiles/install-WhiteboxMe-stripped
install-WhiteboxMe-stripped: course5/ex/CMakeFiles/install-WhiteboxMe-stripped.dir/build.make

.PHONY : install-WhiteboxMe-stripped

# Rule to build all files generated by this target.
course5/ex/CMakeFiles/install-WhiteboxMe-stripped.dir/build: install-WhiteboxMe-stripped

.PHONY : course5/ex/CMakeFiles/install-WhiteboxMe-stripped.dir/build

course5/ex/CMakeFiles/install-WhiteboxMe-stripped.dir/clean:
	cd /home/nacho/Documentos/LLVM/_build/course5/ex && $(CMAKE_COMMAND) -P CMakeFiles/install-WhiteboxMe-stripped.dir/cmake_clean.cmake
.PHONY : course5/ex/CMakeFiles/install-WhiteboxMe-stripped.dir/clean

course5/ex/CMakeFiles/install-WhiteboxMe-stripped.dir/depend:
	cd /home/nacho/Documentos/LLVM/_build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/nacho/Documentos/LLVM /home/nacho/Documentos/LLVM/course5/ex /home/nacho/Documentos/LLVM/_build /home/nacho/Documentos/LLVM/_build/course5/ex /home/nacho/Documentos/LLVM/_build/course5/ex/CMakeFiles/install-WhiteboxMe-stripped.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : course5/ex/CMakeFiles/install-WhiteboxMe-stripped.dir/depend

