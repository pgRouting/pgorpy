#!/bin/bash
# /*PGR-GNU*****************************************************************
#
# License: GNU General Public License v2.0
# Copyright (c) 2025 pgORpy developers
# Mail: project@pgrouting.org
#
# ********************************************************************PGR-GNU*/

set -e

if [  "$1" = "--help" ] ; then
    echo "Usage: getSignatures.sh [DB_ARGS]"
    echo "  DB_ARGS optional"
    echo "example"
    echo "get_signatures.sql -U postgres -h localhost -p 5432 "
    echo "Exeute from the root of the repository"
    exit 0
fi

VERSION=$(grep -Po '(?<=project\(pgORpy VERSION )[^;]+' CMakeLists.txt)
MINOR=${VERSION%.*}

DB_NAME="___por__signatures___"
DIR="sql/sigs"

# DB_ARGS are the remaining of the arguments
read -ra DB_ARGS <<< "$*"

FILE="$DIR/pgorpy--$MINOR.sig"

dropdb --if-exists "${DB_ARGS[@]}" "$DB_NAME"
createdb "${DB_ARGS[@]}" "$DB_NAME"

psql  "${DB_ARGS[@]}"  "$DB_NAME" <<EOF
SET client_min_messages = WARNING;
CREATE EXTENSION pgorpy WITH VERSION '$VERSION' CASCADE;
EOF

psql "${DB_ARGS[@]}" "$DB_NAME" -c '\dx+ pgorpy' -A | grep '^function' | cut -d ' ' -f2- | sort -d > "$FILE"
