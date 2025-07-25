..
   ****************************************************************************
    pgORpy Manual
    Copyright(c) pgORpy Contributors

    This documentation is licensed under a Creative Commons Attribution-Share
    Alike 3.0 License: https://creativecommons.org/licenses/by-sa/3.0/
   ****************************************************************************

Installation
===============================================================================

.. contents::

Instructions for downloading and installing binaries for different Operative
systems instructions and additional notes and corrections not included in this
documentation can be found in `Installation wiki
<https://github.com/pgRouting/${PROJECT_NAME_LOWER}/wiki/Notes-on-Download%2C-Installation-and-building-pgORpy>`__

${PROJECT_NAME} is an extension for PostgreSQL.

There is no package for ${PROJECT_NAME_LOWER}.

Get the ${PROJECT_NAME} sources
-------------------------------------------------------------------------------

The ${PROJECT_NAME} latest release can be found in
https://github.com/pgRouting/${PROJECT_NAME_LOWER}/releases/latest

To get this release:

.. rubric:: Download the repository

.. code-block:: bash

   git clone git://github.com/pgRouting/${PROJECT_NAME_LOWER}.git
   cd ${PROJECT_NAME_LOWER}
   git checkout v${PROJECT_VERSION}


.. rubric:: Download this release

.. code-block:: bash

   wget -O ${PROJECT_NAME_LOWER}-${PROJECT_VERSION}.tar.gz /
      https://github.com/pgRouting/${PROJECT_NAME_LOWER}/archive/v${PROJECT_VERSION}.tar.gz

Extract the tarball.

.. code-block:: bash

   tar xvfz ${PROJECT_NAME_LOWER}-${PROJECT_VERSION}.tar.gz
   cd ${PROJECT_NAME_LOWER}-${PROJECT_VERSION}

Build the extension.
...............................................................................

.. code-block:: bash

   mkdir build
   cd build
   cmake ..
   sudo make install

Enabling and upgrading in the database
...............................................................................

Once ${PROJECT_NAME_LOWER} is installed, it needs to be enabled in each
individual database you want to use it in.

${PROJECT_NAME} is an extension and depends on `plpython3u
<https://www.postgresql.org/docs/current/plpython.html>`__
Enable `plpython3u` before enabling ${PROJECT_NAME} in the database.

.. code-block:: sql

  CREATE EXTENSION ${PROJECT_NAME_LOWER} CASCADE;

.. rubric:: Upgrading the database

When the database has an old version of ${PROJECT_NAME} then an upgrade is
needed.

.. code-block:: sql

   ALTER EXTENSION ${PROJECT_NAME_LOWER} UPDATE TO "${PROJECT_VERSION}";

.. rubric:: See also

* https://www.postgresql.org/docs/current/sql-createextension.html
* https://www.postgresql.org/docs/current/sql-alterextension.html


Dependencies
-------------------------------------------------------------------------------

Make sure that the following dependencies are met:

* Postgresql version >= ${POSTGRESQL_MINIMUM_VERSION}
* CMake >=  ${CMAKE_MINIMUM_REQUIRED_VERSION}
* OR-tools == ${ORTOOLS_VERSION}
* PostgreSQL extension `plpython3u`

This example is for PostgreSQL ${POSTGRESQL_MINIMUM_VERSION}

.. code-block:: none

   sudo apt-get install -y
      cmake \
      postgresql-${POSTGRESQL_MINIMUM_VERSION} \
      postgresql-server-dev-${POSTGRESQL_MINIMUM_VERSION} \
      postgresql-plpython3-${POSTGRESQL_MINIMUM_VERSION}

.. rubric:: optional dependencies

For user's documentation:

* Sphinx > ${SPHINX_MINIMUM_VERSION}
* sphinx-bootstrap-theme

.. code-block:: none

   sudo apt-get install -y \
      graphviz \
      python3-sphinx \
      python3-sphinx-bootstrap-theme \
      sphinx-intl

.. rubric:: Example: Installing dependencies on linux

For developers:

Tests are done on CI, and these are used on CI:

.. code-block:: none

  sudo apt-get install \
       shellcheck \
       licensecheck \
       libtap-parser-sourcehandler-pgtap-perl \
       postgresql-${POSTGRESQL_MINIMUM_VERSION}-pgtap

Configurable variables
...............................................................................

.. rubric:: To see the variables that can be configured

.. code-block:: bash

    $ cd build
    $ cmake -LH ..

Testing
-------------------------------------------------------------------------------

Currently there is no :code:`make test` and testing is done as follows

The following instructions start from *path/to/${PROJECT_NAME_LOWER}/*

.. rubric:: Compare the documentation results

This will create the database `___${PROJECT_NAME_LOWER}_generator___`

.. code-block:: bash

   tools/testers/doc_queries_generator.pl

.. rubric:: Compare the documentation results

This will create the database `___${PROJECT_NAME_LOWER}___pgtap___`

.. code-block:: bash

   bash ./tools/testers/pg_prove_tests.sh <user>

See Also
-------------------------------------------------------------------------------

.. rubric:: Indices and tables

* :ref:`genindex`
* :ref:`search`
