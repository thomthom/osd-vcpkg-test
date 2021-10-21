# define OPENSUBDIV_VERSION_MAJOR 3
# define OPENSUBDIV_VERSION_MINOR 4
# define OPENSUBDIV_VERSION_PATCH 3
find_file(_OpenSubdiv_VERSION_H "opensubdiv/version.h")

# https://stackoverflow.com/questions/47066115/cmake-get-version-from-multiline-text-file
file(READ ${_OpenSubdiv_VERSION_H} version_h_content)

string(REGEX MATCH "OPENSUBDIV_VERSION_MAJOR ([0-9]*)" _ ${version_h_content})
set(version_major ${CMAKE_MATCH_1})

string(REGEX MATCH "OPENSUBDIV_VERSION_MINOR ([0-9]*)" _ ${version_h_content})
set(version_minor ${CMAKE_MATCH_1})

string(REGEX MATCH "OPENSUBDIV_VERSION_PATCH ([0-9]*)" _ ${version_h_content})
set(version_patch ${CMAKE_MATCH_1})

set(OpenSubdiv_VERSION "${version_major}.${version_minor}.${version_patch}")


find_path(OpenSubdiv_INCLUDE_DIR "opensubdiv/version.h")
find_library(OpenSubdiv_CPU_LIBRARY "osdCPU")

message(DEBUG "OpenSubdiv_INCLUDE_DIR: ${OpenSubdiv_INCLUDE_DIR}")
message(DEBUG "OpenSubdiv_CPU_LIBRARY: ${OpenSubdiv_CPU_LIBRARY}")

mark_as_advanced(
  OpenSubdiv_INCLUDE_DIR
  OpenSubdiv_CPU_LIBRARY
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(OpenSubdiv
  REQUIRED_VARS
    OpenSubdiv_INCLUDE_DIR
    OpenSubdiv_CPU_LIBRARY
  VERSION_VAR
    OpenSubdiv_VERSION)

# https://cmake.org/cmake/help/latest/manual/cmake-developer.7.html#a-sample-find-module
if(OpenSubdiv_FOUND AND NOT TARGET pixar::opensubdiv-cpu)
  add_library(pixar::opensubdiv-cpu UNKNOWN IMPORTED)
  set_target_properties(pixar::opensubdiv-cpu PROPERTIES
    IMPORTED_LOCATION "${OpenSubdiv_CPU_LIBRARY}"
    INTERFACE_INCLUDE_DIRECTORIES "${OpenSubdiv_INCLUDE_DIR}"
  )
endif()
