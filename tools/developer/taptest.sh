#!/bin/bash
# /*PGR-GNU*****************************************************************
#
# License: GNU General Public License v2.0
# Copyright (c) 2025 pgORpy developers
# Mail: project@pgrouting.org
#
# ********************************************************************PGR-GNU*/

set -e

if [[ -z  $1 ]]; then
    echo "Usage:"
    echo "taptest.sh <pgtap directory> [<postgresql options>]";
    echo "Examples:"
    echo "taptest.sh version -p 5432"
    exit 1;
fi

QUIET="-v"
QUIET="-q"

# run from root of repository
if ! DIR=$(git rev-parse --show-toplevel 2>/dev/null); then
    echo "Error: Must be run from within the git repository" >&2
    exit 1
fi
pushd "${DIR}" > /dev/null || exit 1

DIR="$1"
shift
PGFLAGS=$*
if ! VERSION=$(grep pgORpy CMakeLists.txt | awk '{print $3}'); then
    echo "Error: Failed to extract version from CMakeLists.txt" >&2
    exit 1
fi

echo "dir ${DIR}"
echo "pgflags ${PGFLAGS}"
echo "VERSION ${VERSION}"
PGPORT="${PGPORT:-5432}"
PGUSER=vicky

PGDATABASE="___por___test___"
PGRVERSION="0.0.0"

for v in ${PGRVERSION}
do
    pushd tools/testers/
    ls
    echo "--------------------------"
    echo " Running with version ${v}"
    echo " test ${DIR}"
    echo "--------------------------"
    # give time to developer to read message
    sleep 3

    dropdb --if-exists "${PGFLAGS}" "${PGDATABASE}"
    createdb "${PGFLAGS}" "${PGDATABASE}"

    if ! bash setup_db.sh "${PGPORT}" "${PGDATABASE}" "${PGUSER}" "${v}"; then
        echo "Error: Database setup failed" >&2
        exit 1
    fi

    echo "--------------------------"
    echo " Installed version"
    echo "--------------------------"
    psql "${PGFLAGS}" -d "$PGDATABASE" -c "SELECT * FROM por_full_version();"
    popd

    if [[ "${v}" != "${VERSION}" ]]
    then
        # run tests on old version
        PGOPTIONS='--client-min-messages=warning' pg_prove "$QUIET" --normalize --directives --recurse "${PGFLAGS}"  -d "${PGDATABASE}" "pgtap/${DIR}"

        sleep 5
        # update to this version
        echo "--------------------------"
        echo " update version"
        echo "--------------------------"
        if ! psql "${PGFLAGS}" -d "$PGDATABASE" -c "SET client_min_messages TO DEBUG3; ALTER EXTENSION pgORpy UPDATE TO '${VERSION}';"; then
            echo "Error: Failed to update pgORpy extension to version ${VERSION}" >&2
            exit 1
        fi

        psql "${PGFLAGS}" -q -t -d "$PGDATABASE" -c "SELECT extversion FROM pg_extension WHERE extname = 'pgORpy';"

        # Verify update success
        if ! psql "${PGFLAGS}" -q -t -d "$PGDATABASE" -c "SELECT extversion FROM pg_extension WHERE extname = 'pgORpy';" | grep -q "${VERSION}"; then
            echo "Error: Extension version mismatch after update" >&2
            exit 1
        fi
    fi

done

# run this version's test
psql "${PGFLAGS}" -d "$PGDATABASE" -c "SELECT * FROM por_full_version();"


pg_prove "$QUIET" --normalize --directives --recurse "${PGFLAGS}"  -d "${PGDATABASE}" "pgtap/${DIR}"
#dropdb --if-exists "${PGFLAGS}" "${PGDATABASE}"
