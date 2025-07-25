..
   ****************************************************************************
    pgORpy Manual
    Copyright(c) pgORpy Contributors

    This documentation is licensed under a Creative Commons Attribution-Share
    Alike 3.0 License: https://creativecommons.org/licenses/by-sa/3.0/
   ****************************************************************************

.. index::
   single: full_version

|

``por_full_version``
===============================================================================

``por_full_version`` - Get versions used for building pgORpy.

.. rubric:: Availability

.. rubric:: Version 0.0.0

* Official function

Description
-------------------------------------------------------------------------------

Returns pgORpy version information and or-tools version used.

Signatures
-------------------------------------------------------------------------------

.. admonition:: \ \
   :class: signatures

   | por_full_version()
   | RETURNS ``TEXT``

:Example: The versions for this documentation

.. literalinclude:: full_version.queries
   :start-after: -- q1
   :end-before: -- q2

Result Columns
-------------------------------------------------------------------------------

==========  =========== ===============================
 column      Type       Description
==========  =========== ===============================
 version     ``TEXT``    pgORpy version
 or-tools    ``TEXT``    OR-tools version
==========  =========== ===============================

.. rubric:: See Also

* :doc:`por_version`

.. rubric:: Indices and tables

* :ref:`genindex`
* :ref:`search`
