set(var "CMAKE_C_COMPILE_OPTIONS_MSVC_DEBUG_INFORMATION_FORMAT_Embedded")
string(REPLACE "-Z7" "-Z7;-DTEST_Z7" "${var}" "${${var}}")
string(REPLACE "-gcodeview" "-gcodeview;-DTEST_Z7" "${var}" "${${var}}")
set(var "CMAKE_C_COMPILE_OPTIONS_MSVC_DEBUG_INFORMATION_FORMAT_ProgramDatabase")
string(REPLACE "-Zi" "-Zi;-DTEST_Zi" "${var}" "${${var}}")
set(var "CMAKE_C_COMPILE_OPTIONS_MSVC_DEBUG_INFORMATION_FORMAT_EditAndContinue")
string(REPLACE "-ZI" "-ZI;-DTEST_ZI" "${var}" "${${var}}")
