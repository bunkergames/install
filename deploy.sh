#!/bin/bash

version="v0.1.0"
rootdir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
selfname=$(basename "$(readlink -f "${BASH_SOURCE[0]}")")
sessionname=$(echo "${selfname}" | cut -f1 -d".")
gamesdir="${rootdir}/gameservers"
scriptsdir="${rootdir}/scripts"
helpersdir="${rootdir}/helpers"
dbdir="${rootdir}/db"
logdir="${rootdir}/log"
localdir="${rootdir}/.local"
tmpdir="${rootdir}/tmp"

# Check that curl is installed before doing anything
if [ ! "$(command -v curl 2>/dev/null)" ]; then
	echo -e "[ FAIL ] Curl is not installed"
	exit 1
fi

echo "rootdir: "$rootdir
echo "selfname: "$selfname
echo "sessionname: "$sessionname
