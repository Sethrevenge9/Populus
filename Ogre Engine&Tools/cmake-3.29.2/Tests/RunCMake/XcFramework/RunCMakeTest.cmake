include(RunCMake)

function(create_library type platform system_name archs sysroot)
  set(RunCMake_TEST_BINARY_DIR ${RunCMake_BINARY_DIR}/create-${type}-${platform}-build)
  run_cmake_with_options(create-${type}-${platform} -DCMAKE_SYSTEM_NAME=${system_name} -DCMAKE_OSX_ARCHITECTURES=${archs} -DCMAKE_OSX_SYSROOT=${sysroot} -DCMAKE_INSTALL_PREFIX=${RunCMake_TEST_BINARY_DIR}/install)

  set(RunCMake_TEST_NO_CLEAN 1)
  run_cmake_command(create-${type}-${platform}-build ${CMAKE_COMMAND} --build . --config Release)
  run_cmake_command(create-${type}-${platform}-install ${CMAKE_COMMAND} --install . --config Release)
endfunction()

function(create_libraries type)
  create_library(${type} macos Darwin "${macos_archs_2}" macosx)
  create_library(${type} ios iOS "arm64" iphoneos)
  create_library(${type} tvos tvOS "arm64" appletvos)
  create_library(${type} watchos watchOS "armv7k\\\\;arm64_32" watchos)
  if(CMake_TEST_XCODE_VERSION VERSION_GREATER_EQUAL 15.2)
    create_library(${type} visionos visionOS "arm64" xros)
  endif()
  create_library(${type} ios-simulator iOS "${macos_archs_2}" iphonesimulator)
  create_library(${type} tvos-simulator tvOS "${macos_archs_2}" appletvsimulator)
  create_library(${type} watchos-simulator watchOS "${watch_sim_archs_2}" watchsimulator)
  if(CMake_TEST_XCODE_VERSION VERSION_GREATER_EQUAL 15.2)
    create_library(${type} visionos-simulator visionOS "${macos_archs_2}" xrsimulator)
  endif()
endfunction()

function(create_xcframework name type platforms)
  set(RunCMake_TEST_BINARY_DIR ${RunCMake_BINARY_DIR}/create-xcframework-${name}-build)
  if(CMake_TEST_XCODE_VERSION VERSION_GREATER_EQUAL 15)
    # 'xcodebuild -create-xcframework' fails on symlinked paths.
    file(REAL_PATH "${RunCMake_SOURCE_DIR}" src_dir)
    file(REAL_PATH "${RunCMake_BINARY_DIR}" bld_dir)
  else()
    set(src_dir "${RunCMake_SOURCE_DIR}")
    set(bld_dir "${RunCMake_BINARY_DIR}")
  endif()
  set(args)
  foreach(platform IN LISTS platforms)
    set(lib_dir "${bld_dir}/create-${type}-${platform}-build/install/lib")
    if(type STREQUAL "framework")
      list(APPEND args -framework ${lib_dir}/mylib.framework)
    else()
      list(APPEND args -library ${lib_dir}/libmylib.a -headers ${src_dir}/mylib/include)
    endif()
  endforeach()
  run_cmake_command(create-xcframework-${name} xcodebuild -create-xcframework ${args} -output ${RunCMake_TEST_BINARY_DIR}/mylib.xcframework)
endfunction()

function(create_executable name xcfname system_name archs sysroot)
  set(RunCMake_TEST_BINARY_DIR ${RunCMake_BINARY_DIR}/create-executable-${name}-build)
  run_cmake_with_options(create-executable-${name} -DCMAKE_SYSTEM_NAME=${system_name} -DCMAKE_OSX_ARCHITECTURES=${archs} -DCMAKE_OSX_SYSROOT=${sysroot} -DMYLIB_LIBRARY=${RunCMake_BINARY_DIR}/create-xcframework-${xcfname}-build/mylib.xcframework)

  set(RunCMake_TEST_NO_CLEAN 1)
  run_cmake_command(create-executable-${name}-build ${CMAKE_COMMAND} --build . --config Release)
endfunction()

function(create_executables name type)
  create_executable(${name}-macos ${type} Darwin "${macos_archs_2}" macosx)
  create_executable(${name}-ios ${type} iOS "arm64" iphoneos)
  create_executable(${name}-tvos ${type} tvOS "arm64" appletvos)
  create_executable(${name}-watchos ${type} watchOS "armv7k\\\\;arm64_32" watchos)
  if(CMake_TEST_XCODE_VERSION VERSION_GREATER_EQUAL 15.2)
    create_executable(${name}-visionos ${type} visionOS "arm64" xros)
  endif()
  create_executable(${name}-ios-simulator ${type} iOS "${macos_archs_2}" iphonesimulator)
  create_executable(${name}-tvos-simulator ${type} tvOS "${macos_archs_2}" appletvsimulator)
  create_executable(${name}-watchos-simulator ${type} watchOS "${watch_sim_archs_2}" watchsimulator)
  if(CMake_TEST_XCODE_VERSION VERSION_GREATER_EQUAL 15.2)
    create_executable(${name}-visionos-simulator ${type} visionOS "${macos_archs_2}" xrsimulator)
  endif()
endfunction()

set(xcframework_platforms macos ios tvos watchos ios-simulator tvos-simulator watchos-simulator)
if(CMake_TEST_XCODE_VERSION VERSION_GREATER_EQUAL 15.2)
  list(APPEND xcframework_platforms visionos visionos-simulator)
endif()
if(CMake_TEST_XCODE_VERSION VERSION_GREATER_EQUAL 12)
  set(macos_archs_1 "x86_64\\;arm64")
  set(macos_archs_2 "x86_64\\\\;arm64")
  set(watch_sim_archs_2 "x86_64")
else()
  set(macos_archs_1 "x86_64")
  set(macos_archs_2 "x86_64")
  set(watch_sim_archs_2 "i386")
endif()

create_libraries(library)
create_libraries(framework)
create_xcframework(library library "${xcframework_platforms}")
create_xcframework(framework framework "${xcframework_platforms}")
create_xcframework(incomplete framework "tvos;watchos")
create_executables(library library)
create_executables(framework framework)
run_cmake_with_options(create-executable-incomplete -DCMAKE_SYSTEM_NAME=Darwin "-DCMAKE_OSX_ARCHITECTURES=${macos_archs_1}" -DMYLIB_LIBRARY=${RunCMake_BINARY_DIR}/create-xcframework-incomplete-build/mylib.xcframework)
create_executables(target-library library)
create_executables(target-framework framework)
run_cmake_with_options(create-executable-target-incomplete -DCMAKE_SYSTEM_NAME=Darwin "-DCMAKE_OSX_ARCHITECTURES=${macos_archs_1}" -DMYLIB_LIBRARY=${RunCMake_BINARY_DIR}/create-xcframework-incomplete-build/mylib.xcframework)
if(RunCMake_GENERATOR STREQUAL "Xcode" AND CMake_TEST_XCODE_VERSION VERSION_GREATER_EQUAL 12)
  create_executables(library-link-phase library)
  create_executables(framework-link-phase framework)
  run_cmake_with_options(create-executable-incomplete-link-phase -DCMAKE_SYSTEM_NAME=Darwin "-DCMAKE_OSX_ARCHITECTURES=${macos_archs_1}" -DMYLIB_LIBRARY=${RunCMake_BINARY_DIR}/create-xcframework-incomplete-build/mylib.xcframework)
  create_executables(target-library-link-phase library)
  create_executables(target-framework-link-phase framework)
  run_cmake_with_options(create-executable-target-incomplete-link-phase -DCMAKE_SYSTEM_NAME=Darwin "-DCMAKE_OSX_ARCHITECTURES=${macos_archs_1}" -DMYLIB_LIBRARY=${RunCMake_BINARY_DIR}/create-xcframework-incomplete-build/mylib.xcframework)
endif()

# Ensure that .xcframework is found before .framework
set(RunCMake_TEST_BINARY_DIR ${RunCMake_BINARY_DIR}/create-xcframework-framework-build)
set(RunCMake_TEST_NO_CLEAN 1)
run_cmake_command(copy-framework ${CMAKE_COMMAND} -E copy_directory ${RunCMake_BINARY_DIR}/create-framework-macos-build/install/lib/mylib.framework ${RunCMake_TEST_BINARY_DIR}/mylib.framework)
unset(RunCMake_TEST_NO_CLEAN)
unset(RunCMake_TEST_BINARY_DIR)

run_cmake(find-library)
run_cmake_command(find-library-script ${CMAKE_COMMAND} -P ${RunCMake_SOURCE_DIR}/find-library.cmake)

file(REMOVE_RECURSE ${RunCMake_BINARY_DIR}/export-install)

set(RunCMake_TEST_BINARY_DIR ${RunCMake_BINARY_DIR}/export-macos-build)
run_cmake_with_options(export-macos -DCMAKE_SYSTEM_NAME=Darwin -DCMAKE_INSTALL_PREFIX=${RunCMake_BINARY_DIR}/export-install)
set(RunCMake_TEST_NO_CLEAN 1)
set(_config_arg)
if(RunCMake_GENERATOR_IS_MULTI_CONFIG)
  set(_config_arg --config Release)
endif()
run_cmake_command(export-macos-build ${CMAKE_COMMAND} --build . ${_config_arg})
run_cmake_command(export-macos-install ${CMAKE_COMMAND} --install . ${_config_arg})
unset(RunCMake_TEST_NO_CLEAN)
unset(RunCMake_TEST_BINARY_DIR)

set(RunCMake_TEST_BINARY_DIR ${RunCMake_BINARY_DIR}/export-ios-build)
run_cmake_with_options(export-ios -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_SYSROOT=iphoneos "-DCMAKE_OSX_ARCHITECTURES=arm64" -DCMAKE_INSTALL_PREFIX=${RunCMake_BINARY_DIR}/export-install)
set(RunCMake_TEST_NO_CLEAN 1)
set(_config_arg)
if(RunCMake_GENERATOR_IS_MULTI_CONFIG)
  set(_config_arg --config Release)
endif()
run_cmake_command(export-ios-build ${CMAKE_COMMAND} --build . ${_config_arg})
run_cmake_command(export-ios-install ${CMAKE_COMMAND} --install . ${_config_arg})
unset(RunCMake_TEST_NO_CLEAN)
unset(RunCMake_TEST_BINARY_DIR)

set(RunCMake_TEST_BINARY_DIR ${RunCMake_BINARY_DIR}/export-ios-simulator-build)
run_cmake_with_options(export-ios-simulator -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_SYSROOT=iphonesimulator "-DCMAKE_OSX_ARCHITECTURES=${macos_archs_1}" -DCMAKE_INSTALL_PREFIX=${RunCMake_BINARY_DIR}/export-install)
set(RunCMake_TEST_NO_CLEAN 1)
set(_config_arg)
if(RunCMake_GENERATOR_IS_MULTI_CONFIG)
  set(_config_arg --config Release)
endif()
run_cmake_command(export-ios-simulator-build ${CMAKE_COMMAND} --build . ${_config_arg})
run_cmake_command(export-ios-simulator-install ${CMAKE_COMMAND} --install . ${_config_arg})
unset(RunCMake_TEST_NO_CLEAN)
unset(RunCMake_TEST_BINARY_DIR)

set(RunCMake_TEST_BINARY_DIR ${RunCMake_BINARY_DIR}/import-macos-install-specific-no-xcframework-build)
run_cmake_with_options(import-macos-install-specific-no-xcframework -DCMAKE_SYSTEM_NAME=Darwin -Dmylib_DIR=${RunCMake_BINARY_DIR}/export-install/lib/macos/cmake/mylib)
set(RunCMake_TEST_NO_CLEAN 1)
set(_config_arg)
set(_config_dir)
if(RunCMake_GENERATOR_IS_MULTI_CONFIG)
  set(_config_arg --config Release)
  set(_config_dir /Release)
endif()
run_cmake_command(import-macos-install-specific-no-xcframework-build ${CMAKE_COMMAND} --build . ${_config_arg})
unset(RunCMake_TEST_NO_CLEAN)
unset(RunCMake_TEST_BINARY_DIR)

set(RunCMake_TEST_NO_CLEAN 1)
if(CMake_TEST_XCODE_VERSION VERSION_GREATER_EQUAL 15)
  # 'xcodebuild -create-xcframework' fails on symlinked paths.
  file(REAL_PATH "${RunCMake_SOURCE_DIR}" src_dir)
  file(REAL_PATH "${RunCMake_BINARY_DIR}" bld_dir)
else()
  set(src_dir "${RunCMake_SOURCE_DIR}")
  set(bld_dir "${RunCMake_BINARY_DIR}")
endif()
set(RunCMake_TEST_BINARY_DIR ${RunCMake_BINARY_DIR}/export-install)
run_cmake_command(export-install-xcframework xcodebuild -create-xcframework
  -output ${bld_dir}/export-install/lib/mylib.xcframework
  -library ${bld_dir}/export-install/lib/macos/libmylib.a
  -headers ${src_dir}/mylib/include
  -library ${bld_dir}/export-install/lib/ios/libmylib.a
  -headers ${src_dir}/mylib/include
  -library ${bld_dir}/export-install/lib/ios-simulator/libmylib.a
  -headers ${src_dir}/mylib/include
  )
run_cmake_command(export-install-xcframework-genex xcodebuild -create-xcframework
  -output ${bld_dir}/export-install/lib2/mylib-genex.xcframework
  -library ${bld_dir}/export-install/lib/macos/libmylib-genex.a
  -headers ${src_dir}/mylib/include
  -library ${bld_dir}/export-install/lib/ios/libmylib-genex.a
  -headers ${src_dir}/mylib/include
  -library ${bld_dir}/export-install/lib/ios-simulator/libmylib-genex.a
  -headers ${src_dir}/mylib/include
  )
set(RunCMake_TEST_BINARY_DIR ${RunCMake_BINARY_DIR}/export-macos-build)
run_cmake_command(export-build-macos-xcframework xcodebuild -create-xcframework
  -output ${bld_dir}/export-macos-build/lib/mylib.xcframework
  -library ${bld_dir}/export-macos-build/lib/macos${_config_dir}/libmylib.a
  -headers ${src_dir}/mylib/include
  )
run_cmake_command(export-build-macos-xcframework-genex xcodebuild -create-xcframework
  -output ${bld_dir}/export-macos-build/lib/mylib-genex.xcframework
  -library ${bld_dir}/export-macos-build/lib/macos${_config_dir}/libmylib-genex.a
  -headers ${src_dir}/mylib/include
  )
unset(RunCMake_TEST_NO_CLEAN)
unset(RunCMake_TEST_BINARY_DIR)

set(RunCMake_TEST_BINARY_DIR ${RunCMake_BINARY_DIR}/import-macos-install-specific-build)
run_cmake_with_options(import-macos-install-specific -DCMAKE_SYSTEM_NAME=Darwin -Dmylib_DIR=${RunCMake_BINARY_DIR}/export-install/lib/macos/cmake/mylib)
set(RunCMake_TEST_NO_CLEAN 1)
set(_config_arg)
if(RunCMake_GENERATOR_IS_MULTI_CONFIG)
  set(_config_arg --config Release)
endif()
run_cmake_command(import-macos-install-specific-build ${CMAKE_COMMAND} --build . ${_config_arg})
unset(RunCMake_TEST_NO_CLEAN)
unset(RunCMake_TEST_BINARY_DIR)

set(RunCMake_TEST_BINARY_DIR ${RunCMake_BINARY_DIR}/import-macos-build-specific-build)
run_cmake_with_options(import-macos-build-specific -DCMAKE_SYSTEM_NAME=Darwin -Dmylib_DIR=${RunCMake_BINARY_DIR}/export-macos-build/lib/macos/cmake/mylib)
set(RunCMake_TEST_NO_CLEAN 1)
set(_config_arg)
if(RunCMake_GENERATOR_IS_MULTI_CONFIG)
  set(_config_arg --config Release)
endif()
run_cmake_command(import-macos-build-specific-build ${CMAKE_COMMAND} --build . ${_config_arg})
unset(RunCMake_TEST_NO_CLEAN)
unset(RunCMake_TEST_BINARY_DIR)

set(RunCMake_TEST_BINARY_DIR ${RunCMake_BINARY_DIR}/import-macos-install-specific-genex-build)
run_cmake_with_options(import-macos-install-specific-genex -DCMAKE_SYSTEM_NAME=Darwin -Dmylib_DIR=${RunCMake_BINARY_DIR}/export-install/lib/macos/cmake/mylib)
set(RunCMake_TEST_NO_CLEAN 1)
set(_config_arg)
if(RunCMake_GENERATOR_IS_MULTI_CONFIG)
  set(_config_arg --config Release)
endif()
run_cmake_command(import-macos-install-specific-genex-build ${CMAKE_COMMAND} --build . ${_config_arg})
unset(RunCMake_TEST_NO_CLEAN)
unset(RunCMake_TEST_BINARY_DIR)

set(RunCMake_TEST_BINARY_DIR ${RunCMake_BINARY_DIR}/import-macos-build-specific-genex-build)
run_cmake_with_options(import-macos-build-specific-genex -DCMAKE_SYSTEM_NAME=Darwin -Dmylib_DIR=${RunCMake_BINARY_DIR}/export-macos-build/lib/macos/cmake/mylib)
set(RunCMake_TEST_NO_CLEAN 1)
set(_config_arg)
if(RunCMake_GENERATOR_IS_MULTI_CONFIG)
  set(_config_arg --config Release)
endif()
run_cmake_command(import-macos-build-specific-genex-build ${CMAKE_COMMAND} --build . ${_config_arg})
unset(RunCMake_TEST_NO_CLEAN)
unset(RunCMake_TEST_BINARY_DIR)

set(RunCMake_TEST_BINARY_DIR ${RunCMake_BINARY_DIR}/import-macos-install-general-build)
run_cmake_with_options(import-macos-install-general -DCMAKE_SYSTEM_NAME=Darwin -Dmylib_DIR=${RunCMake_BINARY_DIR}/export-install/lib/cmake/mylib)
set(RunCMake_TEST_NO_CLEAN 1)
set(_config_arg)
if(RunCMake_GENERATOR_IS_MULTI_CONFIG)
  set(_config_arg --config Release)
endif()
run_cmake_command(import-macos-install-general-build ${CMAKE_COMMAND} --build . ${_config_arg})
unset(RunCMake_TEST_NO_CLEAN)
unset(RunCMake_TEST_BINARY_DIR)

set(RunCMake_TEST_BINARY_DIR ${RunCMake_BINARY_DIR}/import-macos-build-general-build)
run_cmake_with_options(import-macos-build-general -DCMAKE_SYSTEM_NAME=Darwin -Dmylib_DIR=${RunCMake_BINARY_DIR}/export-macos-build/lib/cmake/mylib)
set(RunCMake_TEST_NO_CLEAN 1)
set(_config_arg)
if(RunCMake_GENERATOR_IS_MULTI_CONFIG)
  set(_config_arg --config Release)
endif()
run_cmake_command(import-macos-build-general-build ${CMAKE_COMMAND} --build . ${_config_arg})
unset(RunCMake_TEST_NO_CLEAN)
unset(RunCMake_TEST_BINARY_DIR)

set(RunCMake_TEST_BINARY_DIR ${RunCMake_BINARY_DIR}/import-ios-install-general-build)
run_cmake_with_options(import-ios-install-general -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_SYSROOT=iphoneos -DCMAKE_OSX_ARCHITECTURES=arm64 -Dmylib_DIR=${RunCMake_BINARY_DIR}/export-install/lib/cmake/mylib)
set(RunCMake_TEST_NO_CLEAN 1)
set(_config_arg)
if(RunCMake_GENERATOR_IS_MULTI_CONFIG)
  set(_config_arg --config Release)
endif()
run_cmake_command(import-ios-install-general-build ${CMAKE_COMMAND} --build . ${_config_arg})
unset(RunCMake_TEST_NO_CLEAN)
unset(RunCMake_TEST_BINARY_DIR)
