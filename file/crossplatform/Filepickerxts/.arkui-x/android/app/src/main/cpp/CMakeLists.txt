# the minimum version of CMake.
cmake_minimum_required(VERSION 3.4.1)
project(Filepickerxts)

# Set Path
set(NATIVERENDER_ROOT_PATH ${CMAKE_CURRENT_SOURCE_DIR})
set(NATIVE_SOURCE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../../../../../../entry/src/main/cpp)
if (DEFINED ENV{ARKUIX_SDK_HOME})
    set(NATIVE_INCLUDE_PATH "$ENV{ARKUIX_SDK_HOME}/11/arkui-x/engine/lib/include/")
endif ()

# Macro isolation
add_definitions(-DANDROID_PLATFORM)

# include_directories 对齐OH
include_directories(${NATIVERENDER_ROOT_PATH})
include_directories(${NATIVERENDER_ROOT_PATH}/../../../../../../entry/src/main/cpp/include)
include_directories(${NATIVE_INCLUDE_PATH})

# Compile files 对齐OH
add_library(entry SHARED
        ${NATIVE_SOURCE_PATH}/napi_module.cpp
        ${NATIVE_SOURCE_PATH}/src/platform_napi_impl.cpp
        ${NATIVE_SOURCE_PATH}/src/platform_napi_jni.cpp
        )

# deps
add_library(arkui_android SHARED IMPORTED GLOBAL)
set_target_properties(
        arkui_android
        PROPERTIES IMPORTED_LOCATION
        ${CMAKE_CURRENT_SOURCE_DIR}/../../../libs/${CMAKE_ANDROID_ARCH_ABI}/libarkui_android.so
)

# target link
target_link_libraries(entry PUBLIC arkui_android)
target_link_libraries(entry PUBLIC libc++.a)
target_link_libraries(entry PUBLIC log)
