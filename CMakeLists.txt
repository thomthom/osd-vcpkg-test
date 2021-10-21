cmake_minimum_required(VERSION 3.16)

# # Set -MT(d) to be default for master project.
# if(MASTER_PROJECT)
  # Use static CRT to avoid having to bundle additional DLLs with the
  # executable.
  set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
# endif()

# I've not been able find a way to control the generation of static/dynamic
# libraries vith VSCode+CMake+Vcpkg(Manifest) mode in a cross platform manner.
#
# .vscode/settings.json won't let you set values per-platform.
#
# So set the triplet for Windows here instead. Default triplet for macOS is
# already set to static libs.
# https://github.com/microsoft/vcpkg/blob/master/docs/users/integration.md#changing-the-triplet-1
message(DEBUG "VCPKG_LIBRARY_LINKAGE: ${VCPKG_LIBRARY_LINKAGE}")
message(DEBUG "VCPKG_CRT_LINKAGE: ${VCPKG_CRT_LINKAGE}")
message(DEBUG "VCPKG_TARGET_TRIPLET: ${VCPKG_TARGET_TRIPLET}")

if(WIN32)
  set(VCPKG_TARGET_TRIPLET "x64-windows-static" CACHE STRING "" FORCE)
endif()

message(DEBUG "VCPKG_LIBRARY_LINKAGE: ${VCPKG_LIBRARY_LINKAGE}")
message(DEBUG "VCPKG_CRT_LINKAGE: ${VCPKG_CRT_LINKAGE}")
message(DEBUG "VCPKG_TARGET_TRIPLET: ${VCPKG_TARGET_TRIPLET}")

# Use Vcpkg for package management.
# https://github.com/microsoft/vcpkg#vcpkg-as-a-submodule
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/vcpkg/scripts/buildsystems/vcpkg.cmake
  CACHE STRING "Vcpkg toolchain file")

project(OSDVCPKGTest
  VERSION 1.0.0
  DESCRIPTION "OpenSubdiv vcpkg Test"
  LANGUAGES C CXX
)

list(PREPEND CMAKE_MODULE_PATH
  "${PROJECT_SOURCE_DIR}/cmake"
  # "${PROJECT_SOURCE_DIR}/ThirdParty/slapi-lib/cmake"
)

# list(PREPEND CMAKE_PREFIX_PATH
#   "${PROJECT_SOURCE_DIR}/ThirdParty/sketchup-ruby"
# )

# https://cmake.org/cmake/help/latest/variable/BUILD_SHARED_LIBS.html
# https://cmake.org/cmake/help/latest/guide/tutorial/Selecting%20Static%20or%20Shared%20Libraries.html
# option(BUILD_SHARED_LIBS "Build using shared libraries" ON)
# set(BUILD_SHARED_LIBS OFF CACHE BOOL "Build dynamic libs by default")

# get_cmake_property(_variableNames VARIABLES)
# list (SORT _variableNames)
# foreach (_variableName ${_variableNames})
#     message(STATUS "${_variableName}=${${_variableName}}")
# endforeach()

find_package(fmt REQUIRED)
# find_package(opensubdiv REQUIRED)
find_package(OpenSubdiv REQUIRED)

add_executable(testapp main.cpp)
target_link_libraries(testapp
  PUBLIC
    fmt::fmt
    pixar::opensubdiv-cpu
    # osd_static_cpu
)
