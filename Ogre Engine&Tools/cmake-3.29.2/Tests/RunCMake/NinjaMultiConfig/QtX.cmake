enable_language(CXX)

set(QtX Qt${with_qt_version})

find_package(${QtX} REQUIRED COMPONENTS Core)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOMOC_COMPILER_PREDEFINES OFF)

# Source files are always named qt5.* for simplicity but apply to Qt5 and later
add_executable(exe qt5.cxx)
target_link_libraries(exe PRIVATE ${QtX}::Core)

include(${CMAKE_CURRENT_LIST_DIR}/Common.cmake)
generate_output_files(exe)

set(moc_writes_depfiles 0)
if(${QtX}Core_VERSION VERSION_GREATER_EQUAL "5.15.0")
  set(moc_writes_depfiles 1)
endif()

foreach(CONFIG IN LISTS CMAKE_CONFIGURATION_TYPES)
  set(config_suffix "_${CONFIG}")
  if (CMAKE_AUTOGEN_BETTER_GRAPH_MULTI_CONFIG)
    set(autogen_files_config_suffix "${config_suffix}")
  endif()
  set(autogen_files)
  if(moc_writes_depfiles)
    list(APPEND autogen_files "${CMAKE_BINARY_DIR}/exe_autogen/deps${autogen_files_config_suffix}")
    list(APPEND autogen_files "${CMAKE_BINARY_DIR}/exe_autogen/timestamp${autogen_files_config_suffix}")
  endif()
  if (CMAKE_AUTOGEN_BETTER_GRAPH_MULTI_CONFIG)
    list(APPEND autogen_files "${CMAKE_BINARY_DIR}/exe_autogen/mocs_compilation${config_suffix}.cpp")
    list(APPEND autogen_files "${CMAKE_BINARY_DIR}/exe_autogen/include${config_suffix}/moc_qt5.cpp")
    if(moc_writes_depfiles)
      list(APPEND autogen_files "${CMAKE_BINARY_DIR}/exe_autogen/include${config_suffix}/moc_qt5.cpp.d")
    endif()
  else()
    foreach(c IN LISTS CMAKE_CONFIGURATION_TYPES)
      list(APPEND autogen_files "${CMAKE_BINARY_DIR}/exe_autogen/mocs_compilation_${c}.cpp")
      list(APPEND autogen_files "${CMAKE_BINARY_DIR}/exe_autogen/include_${c}/moc_qt5.cpp")
      if(moc_writes_depfiles)
        list(APPEND autogen_files "${CMAKE_BINARY_DIR}/exe_autogen/include_${c}/moc_qt5.cpp.d")
      endif()
    endforeach()
  endif()

  file(APPEND "${CMAKE_BINARY_DIR}/target_files.cmake" "set(AUTOGEN_FILES${config_suffix} [==[${autogen_files}]==])\n")
  unset(autogen_files)
endforeach()
