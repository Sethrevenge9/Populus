add_library(imported_no_var_global_target SHARED IMPORTED GLOBAL)
add_executable(imported_no_var_global_ex IMPORTED GLOBAL)

add_library(imported_no_var_local_target SHARED IMPORTED)
add_executable(imported_no_var_local_ex IMPORTED)

add_library(not_imported_not_global INTERFACE)
