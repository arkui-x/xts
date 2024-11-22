# the minimum version of CMake.
cmake_minimum_required(VERSION 3.4.1)
project(Filepickerxts)

# Set Path
set(NATIVERENDER_ROOT_PATH ${CMAKE_CURRENT_SOURCE_DIR})

# include_directories
include_directories(${NATIVERENDER_ROOT_PATH})
include_directories(${NATIVERENDER_ROOT_PATH}/../../../../../../entry/src/main/cpp/include)

# shared library
add_library(entry SHARED napi_module.cpp)

# target link
target_link_libraries(entry PUBLIC libace_napi.z.so)