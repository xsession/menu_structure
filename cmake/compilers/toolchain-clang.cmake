cmake_minimum_required(VERSION 3.18 FATAL_ERROR)

# set target system
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_VERSION  1)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(WIN_SDK_PATH "C:/Program Files (x86)/Windows Kits/10")

if(MINGW OR CYGWIN OR WIN32)
    set(UTIL_SEARCH_CMD where)
elseif(UNIX OR APPLE)
    set(UTIL_SEARCH_CMD which)
endif()

set(toolchain_name "clang")
set(CMAKE_C_COMPILER_ID ${toolchain_name})

if(autodetect_toolchain)
  find_program(toolchain ${toolchain_name})
  if(toolchain)
    execute_process(
      COMMAND ${UTIL_SEARCH_CMD} ${toolchain_name}
      OUTPUT_VARIABLE BINUTILS_PATH
    OUTPUT_STRIP_TRAILING_WHITESPACE)
    execute_process(COMMAND ${CMAKE_COMMAND} -E cmake_echo_color --blue --bold "Find tolchain as ${BINUTILS_PATH}")
    get_filename_component(TOOLCHAIN_DIR ${BINUTILS_PATH} DIRECTORY)
    message(STATUS "TOOLCHAIN_DIR: -> ${TOOLCHAIN_DIR}")
    get_filename_component(PARENT_TOOLCHAIN_DIR ${TOOLCHAIN_DIR} DIRECTORY)
    message(STATUS "PARENT_TOOLCHAIN_DIR: -> ${PARENT_TOOLCHAIN_DIR}")
  else()
    execute_process(COMMAND ${CMAKE_COMMAND} -E cmake_echo_color --red --bold "    Didn't find toolchain!
    It's possible you forget to add it to the system PATH variable.")
    message(FATAL_ERROR "")
  endif()
else()
  set(TOOLCHAIN_DIR "C:/Program Files/LLVM/bin")
  find_program(toolchain NAMES ${toolchain_name} PATHS ${TOOLCHAIN_DIR} NO_DEFAULT_PATH)
  if(toolchain)
    execute_process(COMMAND ${CMAKE_COMMAND} -E cmake_echo_color --blue --bold "Find tolchain as ${TOOLCHAIN_DIR}")
    message(STATUS "TOOLCHAIN_DIR: -> ${TOOLCHAIN_DIR}")
    get_filename_component(PARENT_TOOLCHAIN_DIR ${TOOLCHAIN_DIR} DIRECTORY)
    message(STATUS "PARENT_TOOLCHAIN_DIR: -> ${PARENT_TOOLCHAIN_DIR}")
  else()
    execute_process(COMMAND ${CMAKE_COMMAND} -E cmake_echo_color --red --bold "    Didn't find toolchain!
    It's possible you forget to add it to the system PATH variable.")
    message(FATAL_ERROR "")
  endif()
endif()

set(CMAKE_FIND_ROOT_PATH "${TOOLCHAIN_DIR}")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM BOTH)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# toolchain paths
find_program(CLANG_GCC             NAMES   clang    PATHS  ${TOOLCHAIN_DIR}    NO_DEFAULT_PATH)
find_program(CLANG_CXX             NAMES   clang++    PATHS  ${TOOLCHAIN_DIR}    NO_DEFAULT_PATH)
find_program(CLANG_AS              NAMES   clang    PATHS  ${TOOLCHAIN_DIR}    NO_DEFAULT_PATH)
find_program(CLANG_AR              NAMES   llvm-ar    PATHS  ${TOOLCHAIN_DIR}    NO_DEFAULT_PATH)
# find_program(CLANG_OBJCOPY         NAMES   armofd   PATHS  ${TOOLCHAIN_DIR}    NO_DEFAULT_PATH)
find_program(CLANG_OBJDUMP         NAMES   llvm-objdump   PATHS  ${TOOLCHAIN_DIR}    NO_DEFAULT_PATH)
# find_program(CLANG_SIZE            NAMES   armsize  PATHS  ${TOOLCHAIN_DIR}    NO_DEFAULT_PATH)
find_program(CLANG_LD              NAMES   lld-link    PATHS  ${TOOLCHAIN_DIR}    NO_DEFAULT_PATH)

# set executables settings
set(CMAKE_C_COMPILER    ${CLANG_GCC})
set(CMAKE_CXX_COMPILER  ${CLANG_CXX})
set(AS                  ${CLANG_AS})
set(AR                  ${CLANG_AR})
# set(OBJCOPY             ${CLANG_OBJCOPY})
set(OBJDUMP             ${CLANG_OBJDUMP})
# set(SIZE                ${CLANG_SIZE})
set(LD                  ${CLANG_LD})

include_directories("${WIN_SDK_PATH}/Include/**/shared"
                    "${WIN_SDK_PATH}/Include/**/ucrt"
                    "${WIN_SDK_PATH}/Include/**/um")
                    
link_directories( "${WIN_SDK_PATH}/Lib/**/ucrt/x64"
                  "${WIN_SDK_PATH}/Lib/**/um/x64")

link_libraries( libucrt.lib 
                libvcruntime.lib 
                libcmt.lib 
                libcpmt.lib 
                legacy_stdio_definitions.lib 
                oldnames.lib
                legacy_stdio_wide_specifiers.lib
                kernel32.lib User32.lib)

add_link_options( -machine:x64
                  -nodefaultlib) 