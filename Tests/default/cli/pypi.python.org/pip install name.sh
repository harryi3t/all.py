#!/usr/bin/env bash
{ set +x; } 2>/dev/null 

IFS=
[[ -n ${#BASH_SOURCE[@]} ]] && [[ $((${#BASH_SOURCE[@]}*$SHLVL)) == 1 ]] && {
	{ set -x; cd "${BASH_SOURCE[0]%/*/*/*/*/*}"; { set +x; } 2>/dev/null; }
}

! [ -e setup.py ] && echo "ERROR: setup.py NOT EXISTS" && exit 0

# folder name must be same as original repo name
# wercker.com set folder to /pipeline/source/
IFS=.;set -- ${PWD##*/};IFS=
name="$1"

url="https://pypi.python.org/pypi/$name/json"

json=$(curl -s "$url") || exit 0 # no connection?
[[ "$json" != "{"* ]] && { # html 404
	echo "SKIP: pypi.python.org/pypi/$name NOT EXISTS"
	exit 0
}
# ( set -x; pip install -U "$name" )
# setuptools upgrade produce errors if installed from binary
# pip <7: --no-use-wheel
# pip 7+: --no-binary
pip="$(pip --version)" || exit
IFS=' ';set $pip;IFS=
version=$2
IFS=.;set $version;IFS=
major=$1;minor=$2;patch=$3
echo major=$major
echo minor=$minor
echo patch=$patch
set -- pip install --no-use-wheel -U "$name"
[[ $major -ge 7 ]] set -- pip install --no-binary -U "$name"
echo args=$@
( set -x; "$@" )

