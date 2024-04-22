enable_language(C)
enable_testing()
if(CMAKE_CROSSCOMPILING)
  message(FATAL_ERROR "cross compiling")
endif()

cmake_policy(SET CMP0158 NEW)

enable_testing()
add_test(NAME DoesNotUseEmulator
  COMMAND ${CMAKE_COMMAND} -E echo "Hi")

add_executable(exe main.c)

add_test(NAME ShouldNotUseEmulator
  COMMAND exe)

add_test(NAME DoesNotUseEmulatorWithGenex
  COMMAND $<TARGET_FILE:exe>)

add_subdirectory(AddTest)

add_test(NAME ShouldNotUseEmulatorWithExecTargetFromSubdirAddedWithoutGenex
  COMMAND subdir_exe_no_genex)

add_test(NAME DoesNotUseEmulatorWithExecTargetFromSubdirAddedWithGenex
  COMMAND $<TARGET_FILE:subdir_exe_with_genex>)
