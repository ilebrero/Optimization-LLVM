set -e
set -x

rm -fr llvm_8
mkdir llvm_8
cd llvm_8

git clone git@github.com:llvm/llvm-project.git -b release/8.x --depth=1 

mkdir _release && cd _release
cmake ../llvm-project/llvm -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_ASSERTIONS=ON -DLLVM_TARGETS_TO_BUILD=X86 -DBUILD_SHARED_LIBS=ON -DLLVM_BUILD_TOOLS=ON -DLLVM_INCLUDE_TOOLS=ON -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;lld;compiler-rt" -G Ninja 
ninja
cpack .

cd ..
