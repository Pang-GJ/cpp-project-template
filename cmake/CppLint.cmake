file(
  GLOB_RECURSE
  LINT_FILES
  "${PROJECT_SOURCE_DIR}/src/*.h"
  "${PROJECT_SOURCE_DIR}/src/*.cpp"
  "${PROJECT_SOURCE_DIR}/example/*.h"
  "${PROJECT_SOURCE_DIR}/example/*.cpp")

# cpplint
find_program(
  CPPLINT_BIN
  NAMES cpplint cpplint.py
  HINTS "${PROJECT_SOURCE_DIR}/cmake")

if("${CPPLINT_BIN}" STREQUAL "CPPLINT_BIN-NOTFOUND")
  message(WARNING "project/main couldn't find cpplint.")
else()
  message(STATUS "project/main found cpplint at ${CPPLINT_BIN}")
endif()

# Balancing act: cpplint.py takes a non-trivial time to launch, so process 12
# files per invocation, while still ensuring parallelism
add_custom_target(
  check-lint
  echo
  '${LINT_FILES}'
  |
  xargs
  -n12
  -P8
  ${CPPLINT_BIN}
  --verbose=2
  --quiet
  --linelength=120
  --filter=-legal/copyright,-build/header_guard,-runtime/references, -build/c++11 # https://github.com/cpplint/cpplint/issues/148
)
