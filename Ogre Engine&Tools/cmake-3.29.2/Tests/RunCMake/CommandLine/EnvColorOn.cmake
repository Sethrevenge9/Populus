message(STATUS "CMAKE_COLOR_DIAGNOSTICS='${CMAKE_COLOR_DIAGNOSTICS}'")
if(DEFINED CMAKE_COLOR_MAKEFILE)
  message(FATAL_ERROR "CMAKE_COLOR_MAKEFILE incorrectly defined.")
endif()
