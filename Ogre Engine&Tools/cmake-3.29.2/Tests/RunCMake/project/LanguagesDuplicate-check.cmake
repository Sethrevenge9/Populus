if(NOT actual_stderr MATCHES "The following language has been specified multiple times: C\n")
  set(RunCMake_TEST_FAILED "'LANGUAGES C C C' should report only 'C' and only once.")
endif()

if(NOT actual_stderr MATCHES "The following languages have been specified multiple times: C, CXX\n")
  if(RunCMake_TEST_FAILED)
    string(APPEND RunCMake_TEST_FAILED "\n")
  endif()
  string(APPEND RunCMake_TEST_FAILED "'LANGUAGES C C CXX CXX' should report 'C' and 'CXX'.")
endif()
