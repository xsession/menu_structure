cmake_minimum_required(VERSION 3.19 FATAL_ERROR)

project("Platform-project" C CXX ASM)

set(PLATFORM_PROJECT_LOCATION ${PROJECT_SOURCE_DIR})

# Generate compile_commands.json to make it easier to work with clang based tools
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/utils")
list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/modules")

set(SIGNAL_CLASSES_H \"${PROJECT_SOURCE_DIR}/app/menu_structure/menu_structure/inc/signal_classes.h\" )

include(graphviz)
include(FindExtPackages)

# include(Fetch_platform_dependencies)

# add_subdirectory(cmake/external)
add_subdirectory(app/menu_structure)
# add_subdirectory(chsm/crf)


message(STATUS "Using toolchain file: ${CMAKE_TOOLCHAIN_FILE}.")

# message("__STDC_VERSION__: -> ${__STDC_VERSION__}")

set(debug on)
set(autodetect off)
