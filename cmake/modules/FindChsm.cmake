include(FetchContent)

set(FETCHCONTENT_QUIET OFF)
set(FETCHCONTENT_UPDATES_DISCONNECTED ON)

### Library options ############################################################################

set(CHSM_SIGNAL_CLASSES_H ${SIGNAL_CLASSES_H} CACHE INTERNAL "Set CHSM_SIGNAL_CLASSES_H with local path.") 
set(CHSM_BUILD_TESTS      ${APP_BUILD_TESTS} CACHE INTERNAL "Promoted down build_tests setting to chsm.") 
set(DEBUG                 ${CMAKE_DEBUG_MSG} CACHE INTERNAL "Promoted down debug setting to chsm.")
###  

message(STATUS "-----> chsm source_dir: ---> ${CMAKE_CURRENT_SOURCE_DIR}")

FetchContent_Declare(
    Chsm
    GIT_REPOSITORY  https://github.com/xsession/chsm.git
    GIT_TAG         origin/feature/alternate
    SOURCE_DIR      ${CMAKE_CURRENT_SOURCE_DIR}/chsm
    )
    
FetchContent_GetProperties( chsm )     
FetchContent_MakeAvailable( chsm )

if(NOT chsm_POPULATED)
  FetchContent_Populate(chsm)
  add_subdirectory(${chsm_SOURCE_DIR} ${chsm_BINARY_DIR} EXCLUDE_FROM_ALL)
endif()