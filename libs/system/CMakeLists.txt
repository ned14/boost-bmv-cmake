# Note I've exactly duplicated Jamfile.v2 including its directory layout

# cmake 3.5 minimum so add_dependencies on header only libraries works right
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# Bring in the Boost version
if(NOT DEFINED BOOST_VERSION)
  include("${CMAKE_CURRENT_SOURCE_DIR}/../../cmake/BoostVersion.cmake")
endif()
# project() cannot be outsourced to any other file, it must be located here
project(boost_system VERSION ${BOOST_VERSION} LANGUAGES CXX)

# Include how to build the library
# add_subdirectory(), although common, is the wrong thing to use here
include("build/library.cmake")

