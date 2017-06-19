This is a mock up of a **bare minimum viable** cmakeification of the Boost
C++ libraries for the community to study and evaluate. It only cmakeifies
Boost.System alone, its upstream dependencies are stubbed/faked. A demo program which
shows how one would link against Boost.System is in this directory (`example_client_program`)
and it demos linking against boost::system as a header only library, as a static
library and as a shared library.

# Specific design goals of this mock up:
- Modern, **highly reusable by unknown third party cmake** cmake3 only throughout.
- Minimum possible cmake complexity, no cmake innovating, even at the cost of
extra boilerplate.
- No custom macros, functions, nor custom build logic. Only vanilla cmake3.
Keep the learning curve for the build system as gentle as is possible.
- **Strict** separation of non-fixed configuration and build. Child CMakeLists must only
EVER define build and *fixed* configuration like "I need C++ 11 minimum".
*Variable* configuration like naming, directory layout for outputs, optimisation
flags etc is ALWAYS defined in the **rootmost** CMakeLists. NEVER in child
CMakeLists.
- All custom build logic should always be placed in rootlevel cmake scripts
(command line programs written in cmake, runnable using `cmake -V`, these
can take args etc) or rootlevel CMakeLists, or combinations thereof.

# Stuff in there we might yet remove:
- This cmake mockup explicitly documents dependencies between Boost libraries
in cmake, and so when I link against say Boost.System, cmake will also link in
the things Boost.System depends against. Moreover this is minimal, so ONLY
the stuff minimally necessary to fulfil the need for Boost.System is built.
- We allow those Boost libraries support it to present header only, static
and dynamic linkage editions of themselves. This does complicate the CMakeLists
however.

# What we don't do:
- Test the boundaries of cmake or push any limits of what's possible.
- Bespoke libraries of common functions dragged in wherever.
- Complex custom build logic which needs to be documented and learned off
by library developers.
- Do anything which gets in the way of CMakeLists reuse by any arbitrary
third party cmake written by any Boost user.
