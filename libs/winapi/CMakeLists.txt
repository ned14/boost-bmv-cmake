# WARNING: This is a stub CMakeLists.txt to make the example
#          libs/system/CMakeLists.txt work to demonstrate cmake.
#          STUDY libs/system/CMakeLists.txt NOT THIS FILE!!!

cmake_minimum_required(VERSION 3.5 FATAL_ERROR)
if(NOT DEFINED BOOST_VERSION)
  include("${CMAKE_CURRENT_SOURCE_DIR}/../../cmake/BoostVersion.cmake")
endif()
project(boost_winapi VERSION ${BOOST_VERSION} LANGUAGES CXX)
add_library(boost_winapi-hl INTERFACE)
target_include_directories(boost_winapi-hl INTERFACE "include")
add_library(boost::winapi::hl ALIAS boost_winapi-hl)
