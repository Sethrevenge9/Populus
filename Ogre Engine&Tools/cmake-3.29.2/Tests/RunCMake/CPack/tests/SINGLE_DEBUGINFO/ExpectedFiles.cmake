set(whitespaces_ "[\t\n\r ]*")
set(EXPECTED_FILES_COUNT "0")
set(EXPECTED_FILES_NAME_GENERATOR_SPECIFIC_FORMAT TRUE)

if(RunCMake_SUBTEST_SUFFIX STREQUAL "valid" OR RunCMake_SUBTEST_SUFFIX STREQUAL "no_debuginfo")
  set(EXPECTED_FILES_COUNT "4")
  set(EXPECTED_FILE_1 "single_debuginfo-0.1.1-1.*.rpm")
  set(EXPECTED_FILE_CONTENT_1_LIST "/foo;/foo/test_prog")
  set(EXPECTED_FILE_2 "single_debuginfo*-headers.rpm")
  set(EXPECTED_FILE_CONTENT_2_LIST "/bar;/bar/CMakeLists.txt")
  set(EXPECTED_FILE_3 "single_debuginfo*-libs.rpm")
  set(EXPECTED_FILE_CONTENT_3_LIST "/bas;/bas/libtest_lib.so;/empty_dir")

  set(EXPECTED_FILE_4_COMPONENT "debuginfo")
  set(EXPECTED_FILE_CONTENT_4 ".*/src${whitespaces_}/src/src_1${whitespaces_}/src/src_1/main.cpp${whitespaces_}/src/src_1/test_lib.cpp.*\.debug.*")
elseif(RunCMake_SUBTEST_SUFFIX STREQUAL "one_component" OR RunCMake_SUBTEST_SUFFIX STREQUAL "one_component_no_debuginfo")
  set(EXPECTED_FILES_COUNT "2")
  set(EXPECTED_FILE_1 "single_debuginfo-0*-applications.rpm")
  set(EXPECTED_FILE_CONTENT_1_LIST "/foo;/foo/test_prog")

  set(EXPECTED_FILE_2 "single_debuginfo-applications-debuginfo*.rpm")
  set(EXPECTED_FILE_CONTENT_2 ".*/src${whitespaces_}/src/src_1${whitespaces_}/src/src_1/main.cpp.*\.debug.*")
elseif(RunCMake_SUBTEST_SUFFIX STREQUAL "one_component_main" OR RunCMake_SUBTEST_SUFFIX STREQUAL "no_components")
  set(EXPECTED_FILES_COUNT "2")
  set(EXPECTED_FILE_1 "single_debuginfo-0*.rpm")
  set(EXPECTED_FILE_CONTENT_1_LIST "/foo;/foo/test_prog")

  set(EXPECTED_FILE_2 "single_debuginfo-debuginfo*.rpm")
  set(EXPECTED_FILE_CONTENT_2 ".*/src${whitespaces_}/src/src_1${whitespaces_}/src/src_1/main.cpp.*\.debug.*")
endif()
