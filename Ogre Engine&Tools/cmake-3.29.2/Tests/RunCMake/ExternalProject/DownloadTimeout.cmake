include(ExternalProject)
set(source_dir "${CMAKE_CURRENT_BINARY_DIR}/DownloadTimeout")
file(REMOVE_RECURSE "${source_dir}")
file(MAKE_DIRECTORY "${source_dir}")
ExternalProject_Add(MyProj URL "http://cmake.org/invalid_file.tar.gz")
