add_executable(app MACOSX_BUNDLE main.m)

set(EMBED_RESOURCES_FOLDER ${CMAKE_BINARY_DIR}/runtime/shaders)

# ensure embed resources folder exists
if (NOT (IS_DIRECTORY ${EMBED_RESOURCES_FOLDER}))
    file(MAKE_DIRECTORY ${EMBED_RESOURCES_FOLDER})
endif()

set_target_properties(app PROPERTIES
    XCODE_EMBED_RESOURCES ${EMBED_RESOURCES_FOLDER}
)

set_target_properties(app PROPERTIES
  XCODE_ATTRIBUTE_CODE_SIGNING_ALLOWED "NO"
  XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY ""
  MACOSX_BUNDLE_GUI_IDENTIFIER "com.example.app"
)
