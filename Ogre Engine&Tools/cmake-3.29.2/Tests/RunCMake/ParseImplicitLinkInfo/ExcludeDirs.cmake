include("${info}")
list(GET INFO_CMAKE_C_IMPLICIT_LINK_DIRECTORIES -1 last_dir)
set(ENV{CMAKE_C_IMPLICIT_LINK_DIRECTORIES_EXCLUDE} "${last_dir}")
enable_language(C)
message(STATUS "INFO_CMAKE_C_IMPLICIT_LINK_DIRECTORIES=[${INFO_CMAKE_C_IMPLICIT_LINK_DIRECTORIES}]")
message(STATUS "ENV{CMAKE_C_IMPLICIT_LINK_DIRECTORIES_EXCLUDE}=[$ENV{CMAKE_C_IMPLICIT_LINK_DIRECTORIES_EXCLUDE}]")
message(STATUS "CMAKE_C_IMPLICIT_LINK_DIRECTORIES=[${CMAKE_C_IMPLICIT_LINK_DIRECTORIES}]")
if("${last_dir}" IN_LIST CMAKE_C_IMPLICIT_LINK_DIRECTORIES)
  message(FATAL_ERROR "${last_dir} was not excluded!")
endif()
