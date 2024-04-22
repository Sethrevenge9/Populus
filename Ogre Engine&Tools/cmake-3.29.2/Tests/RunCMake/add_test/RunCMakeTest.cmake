include(RunCMake)

set(ENV{CTEST_OUTPUT_ON_FAILURE} 1)

function(run_case CASE_NAME)
  set(RunCMake_TEST_BINARY_DIR ${RunCMake_BINARY_DIR}/CMP0110-${CASE_NAME}-build)
  run_cmake(CMP0110-${CASE_NAME})
  # Run ctest on the generated CTestTestfile.cmake.
  set(RunCMake_TEST_NO_CLEAN 1)
  run_cmake_command(CMP0110-${CASE_NAME}-ctest ${CMAKE_CTEST_COMMAND} -C Debug)
endfunction()

set(cases
  AlphaNumeric
  ValidSpecialChars
  OtherSpecialChars
  EscapedSpecialChars
  Space
  LeadingAndTrailingWhitespace
  Semicolon
  Quote
  BracketArgument
  )

if(RunCMake_GENERATOR_IS_MULTI_CONFIG)
  list(APPEND cases FormerInvalidSpecialCharsMC)
else()
  list(APPEND cases FormerInvalidSpecialChars)
endif()

foreach(case IN LISTS cases)
  run_case(WARN-${case})
  run_case(OLD-${case})
  run_case(NEW-${case})
endforeach()

block()
  set(RunCMake_TEST_BINARY_DIR ${RunCMake_BINARY_DIR}/EmptyArgument-build)
  run_cmake(EmptyArgument)
  # Run ctest on the generated CTestTestfile.cmake.
  set(RunCMake_TEST_NO_CLEAN 1)
  run_cmake_command(EmptyArgument-ctest ${CMAKE_CTEST_COMMAND} -C Debug)
endblock()

set(RunCMake_TEST_OPTIONS "-DCMAKE_TEST_LAUNCHER=${PSEUDO_EMULATOR}")
run_cmake(TestLauncherProperty)
block()
  set(RunCMake_TEST_BINARY_DIR ${RunCMake_BINARY_DIR}/TestLauncher-build)

  run_cmake(TestLauncher)
  unset(RunCMake_TEST_OPTIONS)

  set(RunCMake_TEST_NO_CLEAN 1)
  set(RunCMake_TEST_OUTPUT_MERGE 1)
  run_cmake_command(TestLauncher-build ${CMAKE_COMMAND} --build . --config Debug)
  unset(RunCMake_TEST_OUTPUT_MERGE)

  run_cmake_command(TestLauncher-test ${CMAKE_CTEST_COMMAND} -C Debug -V)
endblock()
unset(RunCMake_TEST_OPTIONS)
