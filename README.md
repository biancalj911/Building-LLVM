# Building-LLVM
Building with LLVM8.0 and CLang8.0

This directory and its subdirectories contain source code for LLVM 8.0,
a toolkit including clang 8.0 for the construction of highly optimized compilers,
optimizers, and runtime environments.

How to Build on vs 2017:

git clone this project  
mkdir build           
cd build  
cmake -DLLVM_ENABLE_PROJECTS=clang -G "Visual Studio 15 2017" -A Win32 Thost=x64 ..\llvm-8.0.0  
  
To build for 64 bits, you must type x64 instead of Win32.

Then, you can find the visual studio solution file in build folder.
