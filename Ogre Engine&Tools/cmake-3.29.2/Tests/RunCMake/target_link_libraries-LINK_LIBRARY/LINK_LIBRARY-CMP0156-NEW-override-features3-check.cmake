
include("${RunCMake_BINARY_DIR}/LINK_LIBRARY-CMP0156-NEW-build/LIBRARIES_PROCESSING.cmake")

if (CMAKE_C_LINK_LIBRARIES_PROCESSING MATCHES "ORDER=FORWARD")
  if (NOT actual_stdout MATCHES "(/|-)-LIBFLAG.*${LINK_SHARED_LIBRARY_PREFIX}base1${LINK_SHARED_LIBRARY_SUFFIX}\"? +\"?(/|-)-LIBFLAG.*${LINK_SHARED_LIBRARY_PREFIX}base3${LINK_SHARED_LIBRARY_SUFFIX}\"? +\"?${CMAKE_LINK_LIBRARY_FLAG}other1")
    set (RunCMake_TEST_FAILED "Not found expected '--LIBFLAG<base1> --LIBFLAG<base3> <other1>'.")
  endif()
else()
  if (NOT actual_stdout MATCHES "(/|-)-LIBFLAG.*${LINK_SHARED_LIBRARY_PREFIX}base3${LINK_SHARED_LIBRARY_SUFFIX}\"? +\"?(/|-)-LIBFLAG.*${LINK_SHARED_LIBRARY_PREFIX}base1${LINK_SHARED_LIBRARY_SUFFIX}\"? +\"?${CMAKE_LINK_LIBRARY_FLAG}other1")
    set (RunCMake_TEST_FAILED "Not found expected '--LIBFLAG<base3> --LIBFLAG<base1> <other1>'.")
  endif()
endif()
