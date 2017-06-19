set(${PROJECT_NAME}_SOURCES)
# Bring in the **auto-generated** list of headers from ../../boost/system/*
# It extends the ${PROJECT_NAME}_SOURCES variable
include("build/headers.cmake")
# Bring in the **auto-generated** list of sources from src/*
# It extends the ${PROJECT_NAME}_SOURCES variable
include("build/sources.cmake")

# Note for the above two you can have cmake enumerate the directories for you
# and build exactly the same lists. But it is slow, slow, slow. So the above
# is much less impact on development.

add_library(boost_system-sl STATIC ${${PROJECT_NAME}_SOURCES})
# This path must be searched for header files during build and by anyone who links/consumes me
target_include_directories(boost_system-sl PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/../..")
# This macro must be defined both during build and by anyone who links/consumes
# this library
target_compile_definitions(boost_system-sl PUBLIC BOOST_SYSTEM_STATIC_LINK=1)
# This target requires C++ 98 during build and in anyone who links/consumes
# this library
target_compile_features(boost_system-sl PUBLIC cxx_std_98)
set_target_properties(boost_system-sl PROPERTIES
  # Place the library into a "lib" or "bin" directory at the root of the build depending on its kind
  ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
  LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
  RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
  # If you want DLLs consuming this static library to be linkable
  POSITION_INDEPENDENT_CODE ON
  # Name similarly to how Boost.Build names them
  OUTPUT_NAME "${PROJECT_NAME}-${CMAKE_CXX_COMPILER_ID}-mt-$<CONFIG>-${BOOST_VERSION}-sl"
)
add_library(boost::system::sl ALIAS boost_system-sl)

# Create a shared library named similarly to how Boost.Build names them
add_library(boost_system-dl SHARED ${${PROJECT_NAME}_SOURCES})
# This path must be searched for header files during build and by anyone who links/consumes me
target_include_directories(boost_system-dl PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/../..")
# This macro must be defined both during build and by anyone who links/consumes
# this library
target_compile_definitions(boost_system-dl PUBLIC BOOST_SYSTEM_DYN_LINK=1)
# This target requires C++ 98 during build and in anyone who links/consumes
# this library
target_compile_features(boost_system-dl PUBLIC cxx_std_98)
set_target_properties(boost_system-dl PROPERTIES
  # Place the library into a "lib" or "bin" directory at the root of the build depending on its kind
  ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
  LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
  RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
  # Name similarly to how Boost.Build names them
  OUTPUT_NAME "${PROJECT_NAME}-${CMAKE_CXX_COMPILER_ID}-mt-$<CONFIG>-${BOOST_VERSION}-dl"
)
# Alias this to a more programmer friendly name
add_library(boost::system::dl ALIAS boost_system-dl)

# Install these targets as follows
install(TARGETS boost_system-sl boost_system-dl EXPORT boost COMPONENT system
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
)
