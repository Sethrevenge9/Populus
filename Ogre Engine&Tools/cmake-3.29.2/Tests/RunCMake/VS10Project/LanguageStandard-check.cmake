set(vcProjectFile "${RunCMake_TEST_BINARY_DIR}/foo.vcxproj")
if(NOT EXISTS "${vcProjectFile}")
  set(RunCMake_TEST_FAILED "Project file ${vcProjectFile} does not exist.")
  return()
endif()

set(found_LanguageStandard_stdcpp17 0)
set(found_LanguageStandard_C_stdc11 0)
file(STRINGS "${vcProjectFile}" lines)
foreach(line IN LISTS lines)
  if(line MATCHES "<LanguageStandard>stdcpp17</LanguageStandard>")
    set(found_LanguageStandard_stdcpp17 1)
  endif()
  if(line MATCHES "<LanguageStandard_C>stdc11</LanguageStandard_C>")
    set(found_LanguageStandard_C_stdc11 1)
  endif()
endforeach()
if(NOT found_LanguageStandard_stdcpp17)
  string(APPEND RunCMake_TEST_FAILED "LanguageStandard stdcpp17 not found in\n  ${vcProjectFile}\n")
endif()
if(NOT found_LanguageStandard_C_stdc11)
  string(APPEND RunCMake_TEST_FAILED "LanguageStandard_C stdc11 not found in\n  ${vcProjectFile}\n")
endif()
