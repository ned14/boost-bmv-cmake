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

# Indicate my dependencies
if(NOT TARGET boost::assert::hl)
  add_subdirectory("../assert" "boost_assert" EXCLUDE_FROM_ALL)
endif()
target_link_libraries(boost_system-hl INTERFACE boost::assert::hl)
target_link_libraries(boost_system-sl PUBLIC boost::assert::hl)
target_link_libraries(boost_system-dl PUBLIC boost::assert::hl)
if(NOT TARGET boost::config::hl)
  add_subdirectory("../config" "boost_config" EXCLUDE_FROM_ALL)
endif()
target_link_libraries(boost_system-hl INTERFACE boost::config::hl)
target_link_libraries(boost_system-sl PUBLIC boost::config::hl)
target_link_libraries(boost_system-dl PUBLIC boost::config::hl)
if(NOT TARGET boost::core::hl)
  add_subdirectory("../core" "boost_core" EXCLUDE_FROM_ALL)
endif()
target_link_libraries(boost_system-hl INTERFACE boost::core::hl)
target_link_libraries(boost_system-sl PUBLIC boost::core::hl)
target_link_libraries(boost_system-dl PUBLIC boost::core::hl)
if(NOT TARGET boost::predef::hl)
  add_subdirectory("../predef" "boost_predef" EXCLUDE_FROM_ALL)
endif()
target_link_libraries(boost_system-hl INTERFACE boost::predef::hl)
target_link_libraries(boost_system-sl PUBLIC boost::predef::hl)
target_link_libraries(boost_system-dl PUBLIC boost::predef::hl)
if(NOT TARGET boost::winapi::hl)
  add_subdirectory("../winapi" "boost_winapi" EXCLUDE_FROM_ALL)
endif()
target_link_libraries(boost_system-hl INTERFACE boost::winapi::hl)
target_link_libraries(boost_system-sl PUBLIC boost::winapi::hl)
target_link_libraries(boost_system-dl PUBLIC boost::winapi::hl)
