cmake_minimum_required(VERSION 3.16)

# # Set -MT(d) to be default for master project.
# if(MASTER_PROJECT)
#   # Use static CRT to avoid having to bundle additional DLLs with the
#   # executable.
#   set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
# endif()

# I've not been able find a way to control the generation of static/dynamic
# libraries vith VSCode+CMake+Vcpkg(Manifest) mode in a cross platform manner.
#
# .vscode/settings.json won't let you set values per-platform.
#
# So set the triplet for Windows here instead. Default triplet for macOS is
# already set to static libs.
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
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/third-party/vcpkg/scripts/buildsystems/vcpkg.cmake
  CACHE STRING "Vcpkg toolchain file")

project(OSDVCPKGTest
  VERSION 1.0.0
  DESCRIPTION "OpenSubdiv vcpkg Test"
  LANGUAGES C CXX
)

find_package(opensubdiv REQUIRED)
