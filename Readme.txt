This is a mock up of a **bare minimum viable** cmakeification of the Boost
C++ libraries for the community to study and evaluate. It only cmakeifies
Boost.System alone, its dependencies are stubbed/faked. A demo program which
links against Boost.System is in this directory (example_client_program) and
it demos linking against boost::system as a header only library, as a static
library and as a shared library.

# Specific design goals of this mock up:
- Modern, **highly reusable** cmake 3 only throughout
- Minimum possible cmake complexity, no cmake innovating.
- No custom macros, functions, nor custom build logic. Only vanilla cmake 3.
- **Strict** separation of variable configuration and build. Child CMakeLists must only
EVER define build and *fixed* configuration like "I need C++ 11 minimum".
*Variable* configuration like naming, directory layout for outputs, optimisation
flags etc is ALWAYS defined in the **rootmost** CMakeLists. NEVER in child
CMakeLists.
- All custom build logic should always be placed in rootlevel cmake scripts
(command line programs written in cmake, runnable using `cmake -V`, these
can take args etc) or rootlevel CMakeLists, or combinations thereof.
