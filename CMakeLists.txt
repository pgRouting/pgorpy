cmake_minimum_required(VERSION 3.17 FATAL_ERROR)

if (${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_BINARY_DIR})
  message(FATAL_ERROR "In-source builds not allowed.
  Please make a new directory (called a build directory) and run CMake from there.
  You may need to remove CMakeCache.txt.")
endif()

if(POLICY CMP0144)
  cmake_policy(SET CMP0144 OLD)
endif()

if(POLICY CMP0167)
  cmake_policy(SET CMP0167 OLD)
endif()

if(POLICY CMP0148)
  cmake_policy(SET CMP0148 OLD)
endif()

#---------------------------------------------
# Setting kind of build
#---------------------------------------------

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

project(pgORpy VERSION 0.0.0
)
set(PROJECT_VERSION_DEV "")
string(TOLOWER "${PROJECT_NAME}" PROJECT_NAME_LOWER)

set(MINORS 0.0)
set(OLD_SIGNATURES
)


set(CMAKE_BUILD_TYPE "Release")
include(Version)

option(PROJECT_DEBUG "Set ON|OFF to get more output" OFF)

#=============================================
# Set the working directories
#=============================================
include(Configure)


#---------------------------------------------
# minimum versions
#---------------------------------------------
set(SPHINX_MINIMUM_VERSION "4.0.0")
set(POSTGRESQL_MINIMUM_VERSION "12.0")
set(PYTHON_VERSION "3.12")
set(ORTOOLS_VERSION "9.10.4067")
string(TIMESTAMP YEAR "%Y")

message(STATUS "ORTOOLS_VERSION=${ORTOOLS_VERSION}")
message(STATUS "DOXYGEN_MINIMUM_VERSION=${DOXYGEN_MINIMUM_VERSION}")
message(STATUS "SPHINX_MINIMUM_VERSION=${SPHINX_MINIMUM_VERSION}")
message(STATUS "POSTGRESQL_MINIMUM_VERSION=${POSTGRESQL_MINIMUM_VERSION}")

#-----------------------------------------------------------------------------
# Finding prerequisites
#-----------------------------------------------------------------------------
find_package(Perl REQUIRED)
find_package(Python ${PYTHON_VERSION} EXACT REQUIRED)

# set Python_ROOT_DIR to define the root directory of a Python installation.
message(STATUS "Python_FOUND=${Python_FOUND}")
message(STATUS "Python_EXECUTABLE=${Python_EXECUTABLE}")

execute_process(
  COMMAND ${Python_EXECUTABLE} -c "import ortools; print(ortools.__version__)"
  OUTPUT_VARIABLE ORTOOLS_VERSION_FOUND
  OUTPUT_STRIP_TRAILING_WHITESPACE
)

message(STATUS "ORTOOLS_VERSION_FOUND=${ORTOOLS_VERSION_FOUND}")

if (NOT "${ORTOOLS_VERSION}" EQUAL "${ORTOOLS_VERSION_FOUND}")
  message(WARNING "The python \"ortools\" package version ${ORTOOLS_VERSION} is not installed.")

endif()

#---------------------------------------------
# PostgreSQL
#---------------------------------------------
set(PostgreSQL_ADDITIONAL_VERSIONS "18" "17" "16")
find_package(PostgreSQL ${POSTGRESQL_MINIMUM_VERSION} REQUIRED)

if(POSTGRESQL_BIN)
  # Checking POSTGRESQL_PG_CONFIG
  find_program(POSTGRESQL_PG_CONFIG NAMES pg_config
    PATHS
    ${POSTGRESQL_BIN}
    NO_DEFAULT_PATH
  )
else()
  find_program(POSTGRESQL_PG_CONFIG NAMES pg_config)
endif()

#---------------------------------------------
# extension directory
#---------------------------------------------

execute_process(
  COMMAND ${POSTGRESQL_PG_CONFIG} --sharedir
  OUTPUT_STRIP_TRAILING_WHITESPACE
  OUTPUT_VARIABLE EXTENSION_DIR)

#-------
if(EXTENSION_DIR)
  set(EXTENSION_DIR "${EXTENSION_DIR}/extension")
else(EXTENSION_DIR)
  message(FATAL_ERROR "pg_config --sharedir failed to return a value.
  Please check your PostgreSQL installation!")
endif(EXTENSION_DIR)

#---------------------------------------------

message(STATUS "EXTENSION_DIR=${EXTENSION_DIR}")

#-----------------------------------------------------------------------------
# Build and install the extension
#-----------------------------------------------------------------------------
add_subdirectory(sql)

install(FILES
  ${PROJECT_FILES_TO_INSTALL}
  DESTINATION "${EXTENSION_DIR}"
)

#-----------------------------------------------------------------------------
# DOCUMENTATION
# Not installing
#-----------------------------------------------------------------------------
add_subdirectory(doc)
