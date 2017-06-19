# cmake 3.5 minimum so add_dependencies on header only libraries works right
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# Bring in all of boostorg, but *lazily* so only the stuff I link to
add_subdirectory("boostorg" EXCLUDE_FROM_ALL)

# I'd like this binary to use header only boost::system and its internal dependencies please
add_executable(example_client_program-hl "example_client_program.cpp")
target_link_libraries(example_client_program-hl PRIVATE boost::system::hl)

# I'd like this binary to use static library boost::system and its internal dependencies please
add_executable(example_client_program-sl "example_client_program.cpp")
target_link_libraries(example_client_program-sl PRIVATE boost::system::sl)

# I'd like this binary to use DLL boost::system and its internal dependencies please
add_executable(example_client_program-dl "example_client_program.cpp")
target_link_libraries(example_client_program-dl PRIVATE boost::system::dl)
