# cmake 3.5 minimum so add_dependencies on header only libraries works right
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# Accumulate all projects into this variable
set(BOOST_LIBRARY_PROJECTS)
# Set my version
include("cmake/BoostVersion.cmake")

# Bring in all libraries (right now it's just boost::system)
add_subdirectory("libs/system")
# other add_subdirectory() go here ... I'd actually do an include() here from
# an automatically generated list personally.


# What is SUPER important about this cmake approach is that the rootmost CMakeLists.txt
# is ALWAYS the one responsible for CONFIGURATION. You never, ever define non-mandatory
# configuration in the child CMakeLists. It's anti-social, it prevent reuse by other cmake.
#
# Here is a classic example of non-mandatory configuration being set from rootmost
# CMakeLists: library naming and directory layout. 
#
# Configure these to be named similarly to how Boost.Build generates staging
foreach(project ${BOOST_LIBRARY_PROJECTS})
  foreach(target ${${project}_TARGETS})
    # Disable auto-linking as I don't use identical naming below, and cmake takes care of auto linking anyway
    target_compile_definitions(${target} INTERFACE BOOST_ALL_NO_LIB)
    # If not a header only library ...
    if(NOT target MATCHES ".*-hl")
      set_target_properties(${target} PROPERTIES
        # Place the library into a "lib" or "bin" directory at the root of the build depending on its kind
        ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
        LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
        RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
        # If you want DLLs consuming this static library to be linkable
        POSITION_INDEPENDENT_CODE ON
        # Name similarly to how Boost.Build names them
        OUTPUT_NAME "${target}-${CMAKE_CXX_COMPILER_ID}-mt-$<CONFIG>-${BOOST_VERSION}"
      )
    endif()
  endforeach()
endforeach()

# Lots of other config could be done here too. For example, special optimisation flags.
