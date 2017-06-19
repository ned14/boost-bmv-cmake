set(${PROJECT_NAME}_HEADERS)
set(${PROJECT_NAME}_SOURCES)
# Bring in the **auto-generated** list of headers from ../../boost/system/*
# It extends the ${PROJECT_NAME}_HEADERS variable
include("build/headers.cmake")
# Bring in the **auto-generated** list of sources from src/*
# It extends the ${PROJECT_NAME}_SOURCES variable
include("build/sources.cmake")

# Note for the above two you can have cmake enumerate the directories for you
# and build exactly the same lists. But it is slow, slow, slow. So the above
# is much less impact on development.

# Create a header only library target
add_library(boost_system-hl INTERFACE)
# For some reason cmake wants you to specify sources to be injected into consumers
# like this instead of placing them in add_library()
target_sources(boost_system-hl INTERFACE ${${PROJECT_NAME}_HEADERS})
# This path must be searched for header files during build and by anyone who links/consumes me
target_include_directories(boost_system-hl INTERFACE ${${PROJECT_NAME}_HEADERS_PATH})
# This macro must be defined both during build and by anyone who links/consumes
# this library
target_compile_definitions(boost_system-hl INTERFACE BOOST_ERROR_CODE_HEADER_ONLY=1)
# This target requires C++ 98 during build and in anyone who links/consumes
# this library
target_compile_features(boost_system-hl INTERFACE cxx_std_98)
add_library(boost::system::hl ALIAS boost_system-hl)

# Create a static library target
add_library(boost_system-sl STATIC ${${PROJECT_NAME}_HEADERS} ${${PROJECT_NAME}_SOURCES})
# This path must be searched for header files during build and by anyone who links/consumes me
target_include_directories(boost_system-sl PUBLIC ${${PROJECT_NAME}_HEADERS_PATH})
# This macro must be defined both during build and by anyone who links/consumes
# this library
target_compile_definitions(boost_system-sl PUBLIC BOOST_SYSTEM_STATIC_LINK=1)
# This target requires C++ 98 during build and in anyone who links/consumes
# this library
target_compile_features(boost_system-sl PUBLIC cxx_std_98)
add_library(boost::system::sl ALIAS boost_system-sl)

# Create a shared library target
add_library(boost_system-dl SHARED ${${PROJECT_NAME}_HEADERS} ${${PROJECT_NAME}_SOURCES})
# This path must be searched for header files during build and by anyone who links/consumes me
target_include_directories(boost_system-dl PUBLIC ${${PROJECT_NAME}_HEADERS_PATH})
# This macro must be defined both during build and by anyone who links/consumes
# this library
target_compile_definitions(boost_system-dl PUBLIC BOOST_SYSTEM_DYN_LINK=1)
# This target requires C++ 98 during build and in anyone who links/consumes
# this library
target_compile_features(boost_system-dl PUBLIC cxx_std_98)
# Alias this to a more programmer friendly name
add_library(boost::system::dl ALIAS boost_system-dl)

# These are the targets I create
set(${PROJECT_NAME}_TARGETS boost_system-hl boost_system-sl boost_system-dl PARENT_SCOPE)
# Install these targets as follows
install(TARGETS ${${PROJECT_NAME}_TARGETS} EXPORT boost COMPONENT system
        RUNTIME DESTINATION bin
        PUBLIC_HEADER DESTINATION include
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
)
