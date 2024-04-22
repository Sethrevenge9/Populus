enable_language(C)

if(CMAKE_SYSTEM_NAME STREQUAL "iOS")
  set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGNING_ALLOWED "NO")
  set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGNING_REQUIRED "NO")
  set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "")
  set(CMAKE_XCODE_ATTRIBUTE_ENABLE_BITCODE "NO")
endif()

if(CMAKE_SYSTEM_NAME STREQUAL "tvOS" OR CMAKE_SYSTEM_NAME STREQUAL "watchOS" OR CMAKE_SYSTEM_NAME STREQUAL "visionOS")
  set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGNING_ALLOWED "NO")
  set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGNING_REQUIRED "NO")
  set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "")
  set(CMAKE_XCODE_ATTRIBUTE_ENABLE_BITCODE "YES")
endif()

add_library(mylib IMPORTED STATIC)
set_property(TARGET mylib PROPERTY IMPORTED_LOCATION ${MYLIB_LIBRARY})

add_executable(myexe myexe/myexe.c)
target_link_libraries(myexe PRIVATE mylib)

add_library(myconsuminglib STATIC myconsuminglib/myconsuminglib.c)
target_link_libraries(myconsuminglib PRIVATE mylib)
