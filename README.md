# Tiny C++ Project Template
This is a tiny C++ project template using CMake.  

The requirements are:
- CMake 3.14+ highly recommended.
- A C++17 compatible compiler (doctest needed!).
- fmt
- doctest

## How To Use ?
To configure:
```
cmake -S . -B build
```
Add `-GNinja` if you have Ninja.

if you want to add tests, just add `-DBUILD_TESTS`  

To build:
```
cmake --build build
```

To test(`--target` can be written as `-t` in CMake 3.15+):
```
cmake --build build --target test
```
