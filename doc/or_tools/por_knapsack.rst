..
   ****************************************************************************
    pgORpy Manual
    Copyright(c) pgORpy Contributors

    This documentation is licensed under a Creative Commons Attribution-Share
    Alike 3.0 License: https://creativecommons.org/licenses/by-sa/3.0/
   ****************************************************************************

.. index::
   single: Knapsack problems ; por_knapsack
   single: knapsack

|

``por_knapsack``
===============================================================================

.. rubric:: Availability

.. rubric:: Version 0.0.1

* New function
* Support for or-tools v9.10.4067

Description
-------------------------------------------------------------------------------

The knapsack problem is a problem in combinatorial optimization:
Given a set of items, each with a weight and a value,
Determine the number of each item to include in a collection
so that the total weight is less than or equal to a given limit and the total
value is as large as possible

Signatures
-------------------------------------------------------------------------------

.. admonition:: \ \
   :class: signatures

   | por_knapsack(`Weight Costs SQL`_, capacity, [``max_rows``])
   | RETURNS SET OF (item_id)
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
     - `Weight Costs SQL`_ as described below.
   * - capacity
     - **ANY-INTEGER**
     - Maximum Capacity of the knapsack.

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
     - Maximum items(rows) to fetch from knapsack table.

Where:

:ANY-INTEGER: ``SMALLINT``, ``INTEGER``, ``BIGINT``

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
   * - ``id``
     - ``INTEGER``
     - Indentifier of an item in the knapsack.

Where:

:ANY-INTEGER: ``SMALLINT``, ``INTEGER``, ``BIGINT``

Example
-------------------------------------------------------------------------------

.. literalinclude:: knapsack.queries
   :start-after: -- example_start
   :end-before: -- example_end

See Also
-------------------------------------------------------------------------------

* `OR-Tools: Google OR-Tools <https://developers.google.com/optimization>`__

.. rubric:: Indices and tables

* :ref:`genindex`
* :ref:`search`
