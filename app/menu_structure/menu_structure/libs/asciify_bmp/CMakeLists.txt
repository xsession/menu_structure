cmake_minimum_required(VERSION 3.19)

project(asciify_bmp
        LANGUAGES C)

include(GNUInstallDirs)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/${CMAKE_INSTALL_BINDIR})

# list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/../../../cmake/utils")

add_executable(asciify_bmp
                src/asciify_bmp.c)

