/*PGR-GNU*****************************************************************

License: GNU General Public License v2.0
Copyright (c) 2025 pgORpy developers
Mail: project@pgrouting.org

 ********************************************************************PGR-GNU*/

-- checks the minimum version version for C++ code
CREATE OR REPLACE FUNCTION min_lib_version(min_version TEXT)
RETURNS BOOLEAN AS
$BODY$
DECLARE val BOOLEAN;
BEGIN
WITH
  current_version AS (SELECT string_to_array(regexp_replace((SELECT library FROM por_full_version()), '.*-', '', 'g'),'.')::int[] AS version),
  asked_version AS (SELECT string_to_array(min_version, '.')::int[] AS version)
  SELECT (current_version.version >= asked_version.version) FROM current_version, asked_version INTO val;
  RETURN val;
END;
$BODY$
LANGUAGE plpgsql;

-- checks the minimum version version for SQL code
CREATE OR REPLACE FUNCTION min_version(min_version TEXT)
RETURNS BOOLEAN AS
$BODY$
DECLARE val BOOLEAN;
BEGIN
WITH
  current_version AS (SELECT string_to_array(regexp_replace(por_version(), '-.*', '', 'g'),'.')::int[] AS version),
  asked_version AS (SELECT string_to_array(min_version, '.')::int[] AS version)
  SELECT (current_version.version >= asked_version.version) FROM current_version, asked_version INTO val;
  RETURN val;
END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION function_types_eq(TEXT, TEXT)
RETURNS TEXT AS
$BODY$
    SELECT set_eq(format($$
      WITH
      a AS (
        SELECT oid, u.name, u.idx
        FROM pg_catalog.pg_proc p CROSS JOIN unnest(coalesce(p.proallargtypes, p.proargtypes))
        WITH ordinality as u(name, idx)
        WHERE p.proname = '%1$s'),
      b AS (
        SELECT a.*, t.typname FROM a JOIN pg_catalog.pg_type As t on (t.oid = a.name))
      SELECT array_agg(typname ORDER BY idx)  FROM b GROUP BY oid
      $$, $1), $2, $1 || ': Function types');
$BODY$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION function_types_has(TEXT, TEXT)
RETURNS TEXT AS
$BODY$
    SELECT set_has(format($$
      WITH
      a AS (
        SELECT oid, u.name, u.idx
        FROM pg_proc p CROSS JOIN unnest(p.proallargtypes)
        WITH ordinality as u(name, idx)
        WHERE p.proname = '%1$s'),
      b AS (
        SELECT a.*, t.typname FROM a JOIN pg_type As t on (t.oid = a.name))
      SELECT array_agg(typname ORDER BY idx)  FROM b GROUP BY oid
      $$, $1), $2, $1 || ': Function types');
$BODY$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION function_args_eq(TEXT, TEXT)
RETURNS TEXT AS
$BODY$
    SELECT set_eq(format($$
      SELECT proargnames from pg_catalog.pg_proc where proname = '%1$s'
      $$, $1), $2, $1 || ': Function args names');
$BODY$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION function_args_has(TEXT, TEXT)
RETURNS TEXT AS
$BODY$
    SELECT set_has(format($$
      SELECT proargnames from pg_catalog.pg_proc where proname = '%1$s'
      $$, $1), $2, $1 || ': Function has args names');
$BODY$ LANGUAGE SQL;
