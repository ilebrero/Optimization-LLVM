set -xe 

test -d _deps || mkdir -p _deps
cd _deps

test -f cmake-3.15.5-Linux-x86_64.sh || wget https://github.com/Kitware/CMake/releases/download/v3.15.5/cmake-3.15.5-Linux-x86_64.sh -O cmake-3.15.5-Linux-x86_64.sh 
test -f z3.zip || wget https://github.com/Z3Prover/z3/releases/download/z3-4.8.6/z3-4.8.6-x64-ubuntu-16.04.zip -O z3.zip
test -f retdec.zip || wget https://github.com/avast/retdec/releases/download/v3.3/retdec-v3.3-ubuntu-64b.zip -O retdec.zip

test -d cmake || { mkdir cmake && bash cmake-3.15.5-Linux-x86_64.sh --skip-license --prefix=`pwd`/cmake ; }
test -d z3 || { unzip -x z3.zip -d . && mv z3-* ./z3 ; }
test -d retdec || { unzip -x retdec.zip -d . ; }
test -d llvm || { mkdir llvm && bash ../misc/LLVM-8.0.1-Linux.sh --skip-license --prefix=`pwd`/llvm ; }
cd ..

test -d _build || mkdir -p _build
cd _build
../_deps/cmake/bin/cmake .. -DLLVM_DIR=`pwd`/../_deps/llvm/lib/cmake/llvm -DZ3_EXECUTABLE=`pwd`/../_deps/z3/bin/z3 -DZ3_INCLUDE_DIR=`pwd`/../_deps/z3/include
cd ..
