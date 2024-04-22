
if (NOT DEFINED DEVICE_LINK)
  set (DEVICE_LINK FALSE)
endif()

if (DEVICE_LINK)
  set (VALID_ID DEVICE_LINK)
  set (INVALID_ID NORMAL_LINK)
else()
  set (VALID_ID NORMAL_LINK)
  set (INVALID_ID DEVICE_LINK)
endif()

if (NOT actual_stdout MATCHES "BADFLAG_${VALID_ID}")
  set (RunCMake_TEST_FAILED "Not found expected 'BADFLAG_${VALID_ID}'.")
endif()
if (actual_stdout MATCHES "BADFLAG_${INVALID_ID}")
  if (RunCMake_TEST_FAILED)
    string (APPEND RunCMake_TEST_FAILED "\n")
  endif()
  string (APPEND RunCMake_TEST_FAILED "Found unexpected 'BADFLAG_${INVALID_ID}'.")
endif()
