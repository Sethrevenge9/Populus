if(NOT IS_DIRECTORY ${out}/parent/child)
  set(RunCMake_TEST_FAILED "child directory was not created")
endif()
