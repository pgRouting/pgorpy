..
   ****************************************************************************
    pgORpy Manual
    Copyright(c) pgORpy Contributors
    This documentation is licensed under a Creative Commons Attribution-Share
    Alike 3.0 License: https://creativecommons.org/licenses/by-sa/3.0/
   ****************************************************************************

.. index::
   single: Knapsack problems ; por_multiple_knapsack
   single: multiple_knapsack

|

``por_multiple_knapsack``
===============================================================================

.. rubric:: Availability

.. rubric:: Version 0.0.1

* New function
* Support for or-tools v9.10.4067

Description
-------------------------------------------------------------------------------

The multiple knapsack problem is a problem in combinatorial optimization:
it is a more general verison of the classic knapsack problem where instead of a
single knapsack, you will be given multiple knapsacks and your goal is maximise the total
value of packed items in all knapsacks.

Signatures
-------------------------------------------------------------------------------

.. admonition:: \ \
   :class: signatures

   | por_multiple_knapsack(`Weight Costs SQL`_, capacities, [,``max_rows``])
   | RETURNS SET OF (knapsack, id)
   | OR EMPTY SET

Parameters
-------------------------------------------------------------------------------

.. list-table::
   :width: 81
   :widths: 14 14 44
   :header-rows: 1

   * - Column
     - Type
     - Description
   * - `Weight Costs SQL`_
     - ``TEXT``
     - `Weight Costs SQL`_ as described below
   * - capacities
     - ``ARRAY[`` **ANY-INTEGER** ``]``
     - An array describing the capacity of each knapsack.

Optional Parameters
...............................................................................

.. list-table::
   :width: 81
   :widths: auto
   :header-rows: 1

   * - Column
     - Type
     - Default
     - Description
   * - ``max_rows``
     - **ANY-INTEGER**
     - :math:`100000`
     - Maximum items(rows) to fetch from bin_packing table.

Inner Queries
-------------------------------------------------------------------------------

Weight Costs SQL
...............................................................................

.. include:: concepts.rst
   :start-after: weight_costs_start
   :end-before: weight_costs_end

Result Columns
-------------------------------------------------------------------------------

.. list-table::
   :width: 81
   :widths: auto
   :header-rows: 1

   * - Column
     - Type
     - Description
   * - ``knapsak``
     - ``INTEGER``
     - Indentifier of the knapsack.
   * - ``id``
     - ``INTEGER``
     - Indentifier of an item in the ``knapsack``.

Example
-------------------------------------------------------------------------------

.. literalinclude:: multiple_knapsack.queries
   :start-after: -- example_start
   :end-before: -- example_end

See Also
-------------------------------------------------------------------------------

.. include:: concepts.rst
   :start-after: see_also_start
   :end-before: see_also_end

.. rubric:: Indices and tables

* :ref:`genindex`
* :ref:`search`
