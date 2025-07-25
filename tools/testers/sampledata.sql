-- CopyRight(c) pgORpy developers
-- Creative Commons Attribution-Share Alike 3.0
-- License : https://creativecommons.org/licenses/by-sa/3.0/

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
