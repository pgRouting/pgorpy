#!/bin/bash
# /*PGR-GNU*****************************************************************
#
# License: GNU General Public License v2.0
# Copyright (c) 2025 pgORpy developers
# Mail: project@pgrouting.org
#
#  ********************************************************************PGR-GNU*/

set -e

DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

PGPORT="$1"
PGDATABASE="$2"
PGUSER="$3"
VERSION="$4"

PGOPTIONS='-c client_min_messages=WARNING' psql -U "${PGUSER}" -p "${PGPORT}"  -d "${PGDATABASE}" -X -q --set ON_ERROR_STOP=1 --pset pager=off \
    -c "CREATE EXTENSION IF NOT EXISTS pgtap; CREATE EXTENSION IF NOT EXISTS pgorpy WITH VERSION '${VERSION}' CASCADE;"

PGOPTIONS='-c client_min_messages=WARNING' psql -U "${PGUSER}" -p "${PGPORT}" -d "${PGDATABASE}" -X -q --set ON_ERROR_STOP=1 --pset pager=off \
    -f "${DIR}/sampledata.sql" \
    -f "${DIR}/general_pgtap_tests.sql" \
    -f "${DIR}/no_crash_test.sql"
