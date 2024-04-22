# These tests are performed using both the historic and the newer SOURCES
# signatures of try_compile. It is critical that they behave the same and
# produce comparable output for both signatures. Tests that cannot do this
# belong in RunCMakeTests.txt, not here.
#
# Tests here MUST include(${CMAKE_CURRENT_SOURCE_DIR}/${try_compile_DEFS}) and
# use the variables defined therein appropriately. Refer to existing tests for
# examples.

run_cmake(CopyFileErrorNoCopyFile)
run_cmake(NoCopyFile)
run_cmake(NoCopyFile2)
run_cmake(NoCopyFileError)
run_cmake(NoCStandard)
run_cmake(NoLogDescription)
run_cmake(NoOutputVariable)
run_cmake(NoOutputVariable2)
run_cmake(BadLinkLibraries)
run_cmake(BadSources1)
run_cmake(BadSources2)
run_cmake(EmptyValueArgs)
run_cmake(EmptyListArgs)
run_cmake(TryRunArgs)
run_cmake(BuildType)
run_cmake(BuildTypeAsFlag)
run_cmake(OutputDirAsFlag)
run_cmake(CopyFileConfig)

run_cmake(EnvConfig)

run_cmake(TargetTypeExe)
run_cmake(TargetTypeInvalid)
run_cmake(TargetTypeStatic)

if(CMAKE_C_STANDARD_DEFAULT)
  run_cmake(CStandard)
elseif(DEFINED CMAKE_C_STANDARD_DEFAULT)
  run_cmake(CStandardNoDefault)
endif()
if(CMAKE_OBJC_STANDARD_DEFAULT)
  run_cmake(ObjCStandard)
endif()
if(CMAKE_CXX_STANDARD_DEFAULT)
  run_cmake(CxxStandard)
elseif(DEFINED CMAKE_CXX_STANDARD_DEFAULT)
  run_cmake(CxxStandardNoDefault)
endif()
if(CMAKE_OBJCXX_STANDARD_DEFAULT)
  run_cmake(ObjCxxStandard)
endif()
if(CMake_TEST_CUDA)
  run_cmake(CudaStandard)
endif()
if(CMake_TEST_ISPC)
  run_cmake(ISPCTargets)
  run_cmake(ISPCInvalidTarget)
  set(ninja "")
  if(RunCMake_GENERATOR MATCHES "Ninja")
    set(ninja "Ninja")
  endif()
  run_cmake(ISPCDuplicateTarget${ninja})
endif()
if((CMAKE_C_COMPILER_ID MATCHES "GNU" AND NOT CMAKE_C_COMPILER_VERSION VERSION_LESS 4.4) OR CMAKE_C_COMPILER_ID MATCHES "LCC")
  run_cmake(CStandardGNU)
endif()
if((CMAKE_CXX_COMPILER_ID MATCHES "GNU" AND NOT CMAKE_CXX_COMPILER_VERSION VERSION_LESS 4.4) OR CMAKE_C_COMPILER_ID MATCHES "LCC")
  run_cmake(CxxStandardGNU)
endif()
