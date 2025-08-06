-- CopyRight(c) pgORpy developers
-- Creative Commons Attribution-Share Alike 3.0
-- License : https://creativecommons.org/licenses/by-sa/3.0/

DROP TABLE IF EXISTS bin_packing;
DROP TABLE IF EXISTS knapsack;
DROP TABLE IF EXISTS multiple_knapsack;

-- activate_python_start
CREATE OR REPLACE PROCEDURE activate_python_venv(venv text)
LANGUAGE plpython3u AS
$BODY$
    import os
    import sys

    if sys.platform in ('win32', 'win64', 'cygwin'):
        activate_this = os.path.join(venv, 'Scripts', 'activate_this.py')
    else:
        activate_this = os.path.join(venv, 'bin', 'activate_this.py')

    exec(open(activate_this).read(), dict(__file__=activate_this))
$BODY$;

-- activate_python_end

CREATE TABLE bin_packing(
  id SERIAL,
  weight INTEGER);

INSERT INTO bin_packing(weight)
VALUES
(48), (30), (19), (36), (36), (27), (42), (42), (36), (24), (30);


CREATE TABLE knapsack(
  id SERIAL,
  weight INTEGER,
  cost INTEGER);

INSERT INTO knapsack(weight, cost)
VALUES
(12, 4), (2, 2), (1, 1), (4, 10), (1, 2);

CREATE TABLE multiple_knapsack(
  id SERIAL,
  weight INTEGER,
  cost INTEGER);

INSERT INTO multiple_knapsack(weight, cost)
VALUES
(48, 10), (30, 30), (42, 25),
(36, 50), (36, 35), (48, 30),
(42, 15), (42, 40), (36, 30),
(24, 35), (30, 45), (30, 10),
(42, 20), (36, 30), (36, 25);
