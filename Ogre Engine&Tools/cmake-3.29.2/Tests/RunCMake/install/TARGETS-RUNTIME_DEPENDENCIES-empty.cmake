enable_language(C)

add_library(lib STATIC obj1.c)

install(TARGETS lib RUNTIME_DEPENDENCIES
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION static
  FRAMEWORK DESTINATION fw
  )
