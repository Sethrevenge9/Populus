include(RunCMake)
set(RunCMake_IGNORE_POLICY_VERSION_DEPRECATION ON)

list(APPEND RunCMake_TEST_OPTIONS -DCMAKE_BUILD_TYPE=Debug)

run_cmake(CMP0043-OLD)
run_cmake(CMP0043-NEW)
run_cmake(CMP0043-WARN)
