#-------------------
# get the subdirectories that have the SQL files
#-------------------

foreach (subdir ${PROJECT_SQL_DIRECTORIES})
  if (PROJECT_DEBUG)
    message (STATUS "Adding sql/${subdir}")
  endif()
  add_subdirectory(${subdir})
endforeach()

if (PROJECT_DEBUG)
  message (STATUS "PROJECT_SQL_FILES=${PROJECT_SQL_FILES}")
endif()

#-------------------
# subdirectory that has the build scrits of the final sql files
#-------------------
set(PROJECT_EXTENSION_FILE "${PROJECT_NAME_LOWER}--${PROJECT_VERSION}.sql")
add_subdirectory(scripts)

#-------------------
# subdirectory that has the signatures of old versions
#-------------------
add_subdirectory(sigs)

message(STATUS "PROJECT_CONTROL=${PROJECT_CONTROL}")


#-------------------
# TARGET: extension_file
#
# Builds:  ${PROJECT_NAME_LOWER}--${PROJECT_VERSION}.sql
#-------------------
add_custom_command(
  OUTPUT ${PROJECT_EXTENSION_FILE}
  COMMAND ${PERL_EXECUTABLE} ./scripts/build-extension-file.pl
  DEPENDS scripts/build-extension-file.pl
  ${PROJECT_SQL_FILES}
)

add_custom_target(extension_file ALL
  DEPENDS ${PROJECT_EXTENSION_FILE}
)

#-------------------
# TARGET: update_files
#-------------------
foreach (old_s ${OLD_SIGNATURES})
  string(REGEX REPLACE "^([0-9]+\\.[0-9]+).*" "\\1" minor_s ${old_s})
  SET (UPDATE_FILES ${UPDATE_FILES}
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME_LOWER}--${old_s}--${PROJECT_VERSION}.sql)

  add_custom_command(
    OUTPUT ${PROJECT_NAME_LOWER}--${old_s}--${PROJECT_VERSION}.sql

    COMMAND ${PERL_EXECUTABLE} ./scripts/build-extension-update-files.pl
      "${PROJECT_VERSION}" "${old_s}"
      "${CMAKE_CURRENT_BINARY_DIR}/sigs"
      "${CMAKE_CURRENT_BINARY_DIR}"
      "${PROJECT_DEBUG}"
    DEPENDS
    ./scripts/build-extension-update-files.pl
    ${PROJECT_EXTENSION_FILE}
    extension_file
    ./sigs/${PROJECT_NAME_LOWER}--${minor_s}.sig
  )
endforeach()

add_custom_target(update_files ALL
  DEPENDS
  ${UPDATE_FILES}
)

SET(PROJECT_FILES_TO_INSTALL
  ${UPDATE_FILES}
  ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_EXTENSION_FILE}
  ${PROJECT_CONTROL}
  PARENT_SCOPE
)
