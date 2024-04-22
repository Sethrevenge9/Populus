set(CYGWIN 0)
set(WIN32 0)
set(APPLE 0)
set(OPENGL_INCLUDE_DIR GL/include)
set(OPENGL_GLU_INCLUDE_DIR GLU/include)
set(OPENGL_GLX_INCLUDE_DIR GLX/include)
set(OPENGL_gl_LIBRARY GL)
set(OPENGL_opengl_LIBRARY OpenGL)
set(OPENGL_glx_LIBRARY GLX)
set(OPENGL_glu_LIBRARY GLU)
find_package(OpenGL)
message(STATUS "OpenGL_GL_PREFERENCE='${OpenGL_GL_PREFERENCE}'")
message(STATUS "OPENGL_gl_LIBRARY='${OPENGL_gl_LIBRARY}'")
message(STATUS "OPENGL_LIBRARIES='${OPENGL_LIBRARIES}'")
