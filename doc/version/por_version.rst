..
   ****************************************************************************
    pgORpy Manual
    Copyright(c) pgORpy Contributors

    This documentation is licensed under a Creative Commons Attribution-Share
    Alike 3.0 License: https://creativecommons.org/licenses/by-sa/3.0/
   ****************************************************************************

.. index::
   single: version

|

``por_version``
===============================================================================

``por_version`` - Get pgORpy version.

.. rubric:: Availability

.. rubric:: Version 0.0.0

* Official function

Description
-------------------------------------------------------------------------------

Gets the pgORpy version information.

Signatures
-------------------------------------------------------------------------------

.. admonition:: \ \
   :class: signatures

   | por_version()
   | RETURNS ``TEXT``

:Example: The version for this documentation.

.. literalinclude:: version.queries
   :start-after: -- q1
   :end-before: -- q2

Result Columns
-------------------------------------------------------------------------------

=========== ===============================
 Type       Description
=========== ===============================
``TEXT``    pgORpy version
=========== ===============================

.. rubric:: See Also

* :doc:`por_full_version`

.. rubric:: Indices and tables

* :ref:`genindex`
* :ref:`search`
