# pgORpy - making accessible or-tools on the database

[![Join the chat at
https://gitter.im/pgRouting/pgrouting](https://badges.gitter.im/Join%20Chat.svg)](https://app.gitter.im/#/room/#pgrouting:osgeo.org)
[Join discourse](https://discourse.osgeo.org/c/pgrouting/15)

## STATUS

### Branches

* The *master* branch has the development of the next micro release
* The *develop* branch has the development of the next minor/major release

For the complete list of releases go to:
https://github.com/pgRouting/pgorpy/releases

## LINKS

* https://pgrouting.org/
* https://pgorpy.pgrouting.org/
* https://github.com/pgRouting/pgorpy

## STATUS

Status of the project can be found [here](https://github.com/pgRouting/pgorpy/wiki#status)


## INTRODUCTION

pgORpy extends the pgRouting/PostGIS/PostgreSQL geospatial database to provide OR-tools functionaily on the PostgreSQL
database.

This library is under development and currently contains the following functions:

* `por_knapsack`
* `por_bin_packing`
* `por_multiple_knapsack`

The detailed steps for installation can be found [here](https://pgorpy.pgrouting.org/latest/en/installation.html).

## REQUIREMENTS

Building requirements
--------------------
* Perl
* Postgresql not on EOL
* CMake >= 3.17
* Sphinx > 4.0.0
* OR-tools == 9.10.4067

## Building

For Linux

	mkdir build
	cd build
	cmake ..
	sudo make install

## Using

Create the extension

	createdb mydatabase
	psql mydatabase -c "CREATE EXTENSION pgorpy CASCADE"

## Documentation

See online documentation: https://pgorpy.pgrouting.org/latest/en/index.html

## LICENSE

* [GPLv2-or-later](https://github.com/pgrouting/pgorpy/blob/main/LICENSE.md)
