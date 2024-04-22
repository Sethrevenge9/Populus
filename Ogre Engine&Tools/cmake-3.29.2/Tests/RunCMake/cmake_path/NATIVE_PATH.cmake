
include ("${RunCMake_SOURCE_DIR}/check_errors.cmake")
unset (errors)

if (WIN32)
  set (path  "c:/a//b\\c/..\\d")
  cmake_path(NATIVE_PATH path output)
  if (NOT output STREQUAL "c:\\a\\\\b\\c\\..\\d")
    list (APPEND errors "'${output}' instead of 'c:\\a\\\\b\\c\\..\\d'")
  endif()
  cmake_path(NATIVE_PATH path output NORMALIZE)
  if (NOT output STREQUAL "c:\\a\\b\\d")
    list (APPEND errors "'${output}' instead of 'c:\\a\\b\\d'")
  endif()

  set (path  "//host/a//b\\c/..\\d")
  cmake_path(NATIVE_PATH path output)
  if (NOT output STREQUAL "\\\\host\\a\\\\b\\c\\..\\d")
    list (APPEND errors "'${output}' instead of '\\\\host\\a\\\\b\\c\\..\\d'")
  endif()
  cmake_path(NATIVE_PATH path output NORMALIZE)
  if (NOT output STREQUAL "\\\\host\\a\\b\\d")
    list (APPEND errors "'${output}' instead of '\\\\host\\a\\b\\d'")
  endif()
else()
  set (path  "/a//b/c/../d")
  cmake_path(NATIVE_PATH path output)
  if (NOT output STREQUAL "/a//b/c/../d")
    list (APPEND errors "'${output}' instead of '/a//b/c/../d'")
  endif()
  cmake_path(NATIVE_PATH path NORMALIZE output)
  if (NOT output STREQUAL "/a/b/d")
    list (APPEND errors "'${output}' instead of '/a/b/d'")
  endif()
endif()

check_errors (NATIVE_PATH ${errors})
