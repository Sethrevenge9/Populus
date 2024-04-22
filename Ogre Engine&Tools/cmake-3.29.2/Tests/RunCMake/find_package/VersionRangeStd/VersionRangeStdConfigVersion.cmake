
if (NOT PACKAGE_FIND_VERSION VERSION_EQUAL "1.2.3.4")
  message (SEND_ERROR "Wrong value for PACKAGE_FIND_VERSION: ${PACKAGE_FIND_VERSION}")
endif()
if (NOT PACKAGE_FIND_VERSION_MAJOR VERSION_EQUAL "1")
  message (SEND_ERROR "Wrong value for PACKAGE_FIND_VERSION_MAJOR: ${PACKAGE_FIND_VERSION_MAJOR}")
endif()
if (NOT PACKAGE_FIND_VERSION_MINOR VERSION_EQUAL "2")
  message (SEND_ERROR "Wrong value for PACKAGE_FIND_VERSION_MINOR: ${PACKAGE_FIND_VERSION_MINOR}")
endif()
if (NOT PACKAGE_FIND_VERSION_PATCH VERSION_EQUAL "3")
  message (SEND_ERROR "Wrong value for PACKAGE_FIND_VERSION_PATCH: ${PACKAGE_FIND_VERSION_PATCH}")
endif()
if (NOT PACKAGE_FIND_VERSION_TWEAK VERSION_EQUAL "4")
  message (SEND_ERROR "Wrong value for PACKAGE_FIND_VERSION_TWEAK: ${PACKAGE_FIND_VERSION_TWEAK}")
endif()

set (PACKAGE_VERSION 2.3.4.5)

if (PACKAGE_FIND_VERSION VERSION_LESS_EQUAL PACKAGE_VERSION)
  set (PACKAGE_VERSION_COMPATIBLE TRUE)
else()
  set (PACKAGE_VERSION_UNSUITABLE TRUE)
endif()
