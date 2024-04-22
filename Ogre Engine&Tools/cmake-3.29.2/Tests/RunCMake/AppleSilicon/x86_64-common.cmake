enable_language(C)

if(NOT CMAKE_HOST_SYSTEM_PROCESSOR STREQUAL "x86_64")
  message(FATAL_ERROR "CMAKE_HOST_SYSTEM_PROCESSOR is '${CMAKE_HOST_SYSTEM_PROCESSOR}', not 'x86_64'")
endif()
if(NOT CMAKE_OSX_ARCHITECTURES STREQUAL "")
  message(FATAL_ERROR "CMAKE_OSX_ARCHITECTURES is '${CMAKE_OSX_ARCHITECTURES}', not empty ''")
endif()

add_library(x86_64 x86_64.c)
