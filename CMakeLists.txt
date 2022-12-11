cmake_minimum_required(VERSION 3.20)

# vcpkg
# vcpkg user note:
#  ------------------------------------------------------------------------------
#     To cooperate with CMake, add "-DCMAKE_TOOLCHAIN_FILE=path-to-vcpkg/scripts/buildsystems/vcpkg.cmake"
#
#     Please add the intended users to the group 'vcpkg':
#     # gpasswd -a <user> vcpkg
# set VCPKG_ROOT to you vcpkg install path
set(CMAKE_TOOLCHAIN_FILE "$ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake")

project(HelloProject
  VERSION
    1.0
  DESCRIPTION
    "a Hello Project!"
  LANGUAGES
    CXX
)

### Require out-of-source builds
file(TO_CMAKE_PATH "${PROJECT_BINARY_DIR}/CMakeLists.txt" LOC_PATH)
if(EXISTS "${LOC_PATH}")
  message(FATAL_ERROR "You cannot build in a source directory 
  (or any directory with a CMakeLists.txt file). 
  Please make a build subdirectory. 
  Feel free to remove CMakeCache.txt and CMakeFiles."
  )
endif()

# For clangd
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Options
option(BUILD_TESTS "Build test executable" OFF)

# add ccache 
find_program(CCACHE_FOUND ccache)
if(CCACHE_FOUND)
  message(use ccache to speed compile!)
  set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE ccache)
  set_property(GLOBAL PROPERTY RULE_LAUNCH_LINK ccache)
endif(CCACHE_FOUND)

# TODO: set you target name!
set(LIBRARY_NAME mylib)

# 3rdparty dir:
set(PROJECT_TRDPARTY_DIR ${PROJECT_SOURCE_DIR}/3rdparty)

add_subdirectory(src)

if (BUILD_TESTS)
  include(CTest)
  enable_testing()
  add_subdirectory(tests)
endif (BUILD_TESTS)

add_subdirectory(example)

# cmake module
list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)

include(FormatAndTidy)
include(CppLint)
