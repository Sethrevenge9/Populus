
if (NOT actual_stdout MATCHES "(/|-)-PREFIXGROUP\"? +\"?(/|-)-LIBFLAG.*${LINK_SHARED_LIBRARY_PREFIX}base1${LINK_SHARED_LIBRARY_SUFFIX}\"? +\"?(/|-)-ITEMFLAG.*${LINK_SHARED_LIBRARY_PREFIX}base1${LINK_SHARED_LIBRARY_SUFFIX}\"? +\"?(/|-)-LIBFLAGother${LINK_EXTERN_LIBRARY_SUFFIX}\"? +\"?(/|-)-ITEMFLAGother\"? +\"?(/|-)-SUFFIXGROUP")
  set (RunCMake_TEST_FAILED "Not found expected '--PREFIXGROUP --LIBFLAG<base1> --ITEMFLAG<base1> --LIBFLAG<other> --ITEMFLAG<other> --SUFFIXGROUP'.")
endif()
