..
   ****************************************************************************
    pgORpy Manual
    Copyright(c) pgORpy Contributors

    This documentation is licensed under a Creative Commons Attribution-Share
    Alike 3.0 License: https://creativecommons.org/licenses/by-sa/3.0/
   ****************************************************************************

Support
===============================================================================

Support is available through the
`pgRouting website <https://pgrouting.org/support.html>`_,
`documentation <https://pgorpy.pgrouting.org>`_, tutorials, mailing lists and others.

If you’re looking for `commercial support`_, find below
a list of companies providing pgORpy development and consulting services.


Reporting Problems
-------------------------------------------------------------------------------

Bugs are reported and managed in an
`issue tracker <https://github.com/pgRouting/pgorpy/issues>`_. Please follow
these steps:

1. Search the tickets to see if your problem has already been reported.
   If so, add any extra context you might have found, or at least indicate that
   you too are having the problem. This will help us prioritize common issues.
2. If your problem is unreported, create a
   `new issue <https://github.com/pgRouting/pgorpy/issues/new>`__ for it.
3. In your report include explicit instructions to replicate your issue.
   The best tickets include the exact SQL necessary to replicate a problem.
4. For the versions where you can replicate the problem, note the operating
   system and version of pgORpy and PostgreSQL.
5. It is recommended to use the following wrapper on the problem to pin point
   the step that is causing the problem.

.. code-block:: sql

    SET client_min_messages TO debug;
      <your code>
    SET client_min_messages TO notice;



Discurse and GIS StackExchange
-------------------------------------------------------------------------------

There are two discourse categories for pgRouting products hosted on OSGeo discourse.
which are of pgRouting:

For general questions and topics about how to use pgorpy:

* pgRouting-users discourse category: https://discourse.osgeo.org/c/pgrouting/pgrouting-users

For questions about development of pgorpy:

* pgRouting-dev discourse category: https://discourse.osgeo.org/c/pgrouting/pgrouting-dev

  * Subscribe: https://discourse.osgeo.org/g/pgrouting-dev

Commercial Support
-------------------------------------------------------------------------------

For users who require professional support, development and consulting services,
consider contacting any of the following organizations, which have significantly
contributed to the development of pgORpy:

.. list-table::
   :widths: 100 160 200

   * - **Company**
     - **Offices in**
     - **Website**
   * - Erosion developers
     - Mexico
     - https://erosion.dev
   * - Paragon Corporation
     - United States
     - https://www.paragoncorporation.com
