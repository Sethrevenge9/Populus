file(READ "${RunCMake_TEST_BINARY_DIR}/mytargets.cmake" mytargets)
if(NOT "${mytargets}" MATCHES "find_dependency\\(P1")
  string(APPEND RunCMake_TEST_FAILED "P1 dependency should be exported but it is not\n")
endif()
if(NOT "${mytargets}" MATCHES "find_dependency\\(P2")
  string(APPEND RunCMake_TEST_FAILED "P2 dependency should be exported but it is not\n")
endif()
if(NOT "${mytargets}" MATCHES "find_dependency\\(P3")
  string(APPEND RunCMake_TEST_FAILED "P3 dependency should be exported but it is not\n")
endif()
if(NOT "${mytargets}" MATCHES "find_dependency\\(P4")
  string(APPEND RunCMake_TEST_FAILED "P4 dependency should be exported but it is not\n")
endif()
