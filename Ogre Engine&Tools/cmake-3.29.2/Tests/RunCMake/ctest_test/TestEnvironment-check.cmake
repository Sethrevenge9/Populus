file(READ "${RunCMake_TEST_BINARY_DIR}/Testing/TAG" _tag)
string(REGEX REPLACE "^([^\n]*)\n.*$" "\\1" _date "${_tag}")
file(READ "${RunCMake_TEST_BINARY_DIR}/Testing/${_date}/Test.xml" _test_contents)

if(NOT _test_contents MATCHES "<Value>ENV1=env1\nENV2=env2\n#CTEST_RESOURCE_GROUP_COUNT=</Value>")
  string(APPEND RunCMake_TEST_FAILED "Could not find expected environment variables in Test.xml")
endif()
if(_test_contents MATCHES "BAD_ENVIRONMENT_VARIABLE")
  string(APPEND RunCMake_TEST_FAILED "Found BAD_ENVIRONMENT_VARIABLE in Test.xml")
endif()
