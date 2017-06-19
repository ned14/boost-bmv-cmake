# WARNING: This is a stub CMakeLists.txt to make the example
#          libs/system/CMakeLists.txt work to demonstrate cmake.
#          STUDY libs/system/CMakeLists.txt NOT THIS FILE!!!

cmake_minimum_required(VERSION 3.5 FATAL_ERROR)
if(NOT DEFINED BOOST_VERSION)
  include("${CMAKE_CURRENT_SOURCE_DIR}/../../cmake/BoostVersion.cmake")
endif()
project(boost_config VERSION ${BOOST_VERSION} LANGUAGES CXX)
list(APPEND BOOST_LIBRARY_PROJECTS ${PROJECT_NAME})
add_library(boost_config-hl INTERFACE)
target_include_directories(boost_config-hl INTERFACE "include")
add_library(boost::config::hl ALIAS boost_config-hl)
