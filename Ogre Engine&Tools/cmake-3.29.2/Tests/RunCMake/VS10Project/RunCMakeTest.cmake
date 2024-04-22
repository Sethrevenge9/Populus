cmake_policy(SET CMP0057 NEW)

include(RunCMake)
cmake_policy(SET CMP0054 NEW)

if(CMAKE_C_COMPILER_ID STREQUAL "MSVC" AND CMAKE_C_COMPILER_VERSION VERSION_GREATER_EQUAL 19.27)
  run_cmake(LanguageStandard)
endif()

run_cmake(CustomCommandGenex)
if(NOT RunCMake_GENERATOR MATCHES "^Visual Studio 1[1-5] ")
  run_cmake(CustomCommandParallel)
endif()
run_cmake_with_options(VsCharacterSet -DSET_CHARSET=MultiByte)
run_cmake_with_options(VsCharacterSet -DSET_CHARSET=Unicode)
run_cmake_with_options(VsCharacterSet -DSET_CHARSET=NotSet)
run_cmake(VsCsharpSourceGroup)
run_cmake(VsCSharpCompilerOpts)
run_cmake(ExplicitCMakeLists)
run_cmake(InterfaceLibSources)
run_cmake(NoImpLib)
run_cmake(RuntimeLibrary)
run_cmake(SourceGroupCMakeLists)
run_cmake(SourceGroupTreeCMakeLists)
run_cmake(SourceGroupFileSet)
run_cmake(VsConfigurationType)
run_cmake(VsTargetsFileReferences)
run_cmake(VsCustomProps)
run_cmake(VsDebuggerWorkingDir)
run_cmake(VsDebuggerCommand)
run_cmake(VsDebuggerCommandArguments)
run_cmake(VsDebuggerEnvironment)
run_cmake(VsCSharpCustomTags)
run_cmake(VsCSharpDocumentationFile)
run_cmake(VsCSharpReferenceProps)
run_cmake(VsCSharpWithoutSources)
run_cmake(VsCSharpDeployFiles)
run_cmake(VSCSharpDefines)
run_cmake(VsSdkDirectories)
run_cmake(VsGlobals)
run_cmake(VsProjectImport)
run_cmake(VsPackageReferences)
run_cmake(VsDpiAware)
run_cmake(VsDpiAwareBadParam)
run_cmake(VsForceInclude)
run_cmake(VsPrecompileHeaders)
run_cmake(VsPrecompileHeadersReuseFromCompilePDBName)
run_cmake(VsDeployEnabled)
run_cmake(VsSettings)
run_cmake(VsSourceSettingsTool)
run_cmake(VsPlatformToolset)
run_cmake(VsControlFlowGuardLinkSetting)

run_cmake(VsWinRTByDefault)

set(RunCMake_GENERATOR_TOOLSET "VCTargetsPath=$(VCTargetsPath)")
run_cmake(VsVCTargetsPath)
unset(RunCMake_GENERATOR_TOOLSET)

if(CMAKE_C_COMPILER_ID STREQUAL "MSVC" AND CMAKE_C_COMPILER_VERSION VERSION_GREATER_EQUAL 19.05)
  run_cmake(VsJustMyCode)
endif()

if(CMAKE_C_COMPILER_ID STREQUAL "MSVC" AND CMAKE_C_COMPILER_VERSION VERSION_GREATER_EQUAL 19.20)
  run_cmake(VsSpectreMitigation)
endif()

# Visual Studio 2017 has toolset version 141
string(REPLACE "v" "" generator_toolset "${RunCMake_GENERATOR_TOOLSET}")
if (RunCMake_GENERATOR MATCHES "Visual Studio 1[0-4] 201[0-5]" OR
   (RunCMake_GENERATOR_TOOLSET AND generator_toolset VERSION_LESS "141"))
  run_cmake(UnityBuildPre2017)
else()
  run_cmake(UnityBuildNative)
  run_cmake(UnityBuildNativeGrouped)

  function(run_UnityBuildPCH)
    set(RunCMake_TEST_BINARY_DIR ${RunCMake_BINARY_DIR}/UnityBuildPCH-build)
    run_cmake(UnityBuildPCH)
    set(RunCMake_TEST_NO_CLEAN 1)
    set(vcxproj "${RunCMake_TEST_BINARY_DIR}/UnityBuildPCH.vcxproj")
    if(EXISTS "${vcxproj}")
      file(STRINGS ${vcxproj} vcxproj_strings REGEX "ClCompile[^\n]*UnityBuildPCH\\.c")
    endif()
    if(vcxproj_strings MATCHES "Include=\"([^\"]+)\"")
      set(src "${CMAKE_MATCH_1}")
      run_cmake_command(UnityBuildPCH-build ${CMAKE_COMMAND} --build . --config Debug --target UnityBuildPCH -- -t:ClCompile -p:SelectedFiles=${src})
    endif()
  endfunction()
  run_UnityBuildPCH()
endif()

run_cmake(VsDotnetStartupObject)
run_cmake(VsDotnetTargetFramework)
run_cmake(VsDotnetTargetFrameworkVersion)
run_cmake(VsNoCompileBatching)
run_cmake(DebugInformationFormat)
run_cmake(VsCLREmpty)
run_cmake(VsCLRPure)
run_cmake(VsCLRSafe)

if(CMAKE_C_COMPILER_VERSION VERSION_GREATER_EQUAL 19.20)
  run_cmake(VsCLRNetcore)
endif()
