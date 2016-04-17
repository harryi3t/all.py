#!/usr/bin/env bash
{ set +x; } 2>/dev/null

[[ ${#BASH_SOURCE[@]} != 1 ]] && exit 0 # skip if sourced

[[ ${BASH_SOURCE[0]} == /* ]] && {
	{ set -x; cd "${BASH_SOURCE[0]%/*/*}" || exit; { set +x; } 2>/dev/null; }
} || { 
	{ set -x; cd "$PWD"; { set +x; } 2>/dev/null; }
}

( set -x; test-scripts ./Tests )
# python3.2 coverage has syntax error
# '[[ $TRAVIS_PYTHON_VERSION != 3.2 ]] && coverage run --source=$(python setup.py --name) setup.py test;:'
#
:
