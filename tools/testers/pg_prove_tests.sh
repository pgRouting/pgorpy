#!/bin/bash
# PGR-GNU*****************************************************************
#
# License: GNU General Public License v2.0
# Copyright (c) 2025 pgORpy developers
# Mail: project@pgrouting.org
#
# ********************************************************************PGR-GNU*/

set -e

PGDATABASE="___pgorpy___pgtap___"
VERSION=$(grep pgORpy CMakeLists.txt | awk '{print $3}')

while [[ $# -gt 0 ]]; do
  case $1 in
    -U)
      PGUSER=(-U "$2")
      shift
      shift
      ;;
    -d)
      PGDATABASE="$2"
      shift
      shift
      ;;
    -c|--clean)
      CLEANDB=YES
      shift
      ;;
    -p)
      PGPORT=(-p "$2")
      shift
      shift
      ;;
    -*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
        POSITIONAL_ARGS+=("$1") # save positional arg
        shift # past argument
        ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

echo PGUSER= "${PGUSER[@]}"
echo PGPORT= "${PGPORT[@]}"
echo PGDATABASE= "${PGDATABASE}"
echo CLEANDB= "${CLEANDB}"


dropdb --if-exists "${PGUSER[@]}" "${PGPORT[@]}" "${PGDATABASE}"
createdb "${PGUSER[@]}" "${PGPORT[@]}" "${PGDATABASE}"

pushd ./tools/testers/ > /dev/null || exit 1
bash setup_db.sh "${PGPORT[1]}" "${PGDATABASE}" "${PGUSER[1]}" "${VERSION}"
popd > /dev/null || exit 1

echo "Starting pgtap tests"

PGOPTIONS="-c client_min_messages=WARNING" pg_prove --failures --quiet --recurse \
    -S on_error_rollback=off \
    -S on_error_stop=true \
    -P format=unaligned \
    -P tuples_only=true \
    -P pager=off \
    "${PGPORT[@]}" -d "${PGDATABASE}" "${PGUSER[@]}" pgtap

# database wont be removed unless script does not fails
if [ -n "$CLEANDB" ]; then
    dropdb --if-exists "${PGPORT[@]}" "${PGUSER[@]}" "${PGDATABASE}"
fi
