macro(find_toolchain toolchain_name)
  if(MINGW OR CYGWIN OR WIN32)
      set(UTIL_SEARCH_CMD where)
  elseif(UNIX OR APPLE)
      set(UTIL_SEARCH_CMD which)
  endif()

  execute_process(
    COMMAND ${UTIL_SEARCH_CMD} ${toolchain_name}
    OUTPUT_VARIABLE BINUTILS_PATH
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )

  get_filename_component(TOOLCHAIN_DIR ${BINUTILS_PATH} DIRECTORY)

  set(CMAKE_FIND_ROOT_PATH "${BINUTILS_PATH}")
  set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM BOTH)
  set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
  set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
  set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
endmacro()
