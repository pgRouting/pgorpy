
SET(LOCAL_FILES
  functions.rst
  index.rst
  introduction.rst
  installation.rst
  release_notes.rst
  support.rst
  sampledata.rst
)

foreach (f ${LOCAL_FILES})
  configure_file(${f} "${PGR_DOCUMENTATION_SOURCE_DIR}/${f}")
  list(APPEND LOCAL_DOC_FILES  ${PGR_DOCUMENTATION_SOURCE_DIR}/${f})
endforeach()

file(READ ${PGR_DOCUMENTATION_SOURCE_DIR}/release_notes.rst FILE_CONTENTS)
string(REGEX REPLACE ":issue:`([0-9]+)`" "`#\\1 <https://github.com/pgRouting/pgorpy/issues/\\1>`__" FILE_CONTENTS "${FILE_CONTENTS}")
file(WRITE ${PGR_DOCUMENTATION_SOURCE_DIR}/release_notes.rst "${FILE_CONTENTS}")

set(PROJECT_DOC_FILES ${PROJECT_DOC_FILES} ${LOCAL_DOC_FILES} PARENT_SCOPE)
