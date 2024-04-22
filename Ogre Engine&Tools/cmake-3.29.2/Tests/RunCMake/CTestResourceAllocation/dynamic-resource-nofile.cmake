add_test(NAME RealTest COMMAND "${CMAKE_COMMAND}" -E true)
add_test(NAME GenerateSpecFile COMMAND "${CMAKE_COMMAND}" -E true)
set_tests_properties(GenerateSpecFile PROPERTIES
  GENERATED_RESOURCE_SPEC_FILE "${CMAKE_BINARY_DIR}/dynamic-resspec.json"
  FIXTURES_SETUP "ResourceSpec"
  )
set_tests_properties(RealTest PROPERTIES
  FIXTURES_REQUIRED "ResourceSpec"
  RESOURCE_GROUPS "widgets:1"
  )
