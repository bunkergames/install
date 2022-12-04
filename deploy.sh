#!/bin/bash

echo -e "\033[31m"
echo "__________              __                    ________                              "
echo "\______   \__ __  ____ |  | __ ___________   /  _____/_____    _____   ____   ______"
echo " |    |  _/  |  \/    \|  |/ // __ \_  __ \ /   \  ___\__  \  /     \_/ __ \ /  ___/"
echo " |    |   \  |  /   |  \    <\  ___/|  | \/ \    \_\  \/ __ \|  Y Y  \  ___/ \___ \ "
echo " |______  /____/|___|  /__|_ \\___  >__|     \______  (____  /__|_|  /\___  >____  >"
echo "        \/           \/     \/    \/                \/     \/      \/     \/     \/ "
echo ""
echo -e "\033[0m"

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
serverlist="data.csv"
serverlistmenu="data.csv"

# Check that curl is installed before doing anything
if [ ! "$(command -v curl 2>/dev/null)" ]; then
	echo -e "[ FAIL ] Curl is not installed"
	exit 1
fi

echo "rootdir: "$rootdir
echo "selfname: "$selfname
echo "sessionname: "$sessionname

list=("hello" "world")

# Installer menu.

fn_print_center() {
	columns=$(tput cols)
	line="$*"
	printf "%*s\n" $(((${#line} + columns) / 2)) "${line}"
}

fn_print_horizontal() {
	printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' "="
}

fn_install_menu_bash() {
	local resultvar=$1
	title=$2
	caption=$3
	options=$4
	fn_print_horizontal
	fn_print_center "${title}"
	fn_print_center "${caption}"
	fn_print_horizontal
	menu_options=()
	while read -r line || [[ -n "${line}" ]]; do
		var=$(echo -e "${line}" | awk -F "," '{print $2 " - " $3}')
		menu_options+=("${var}")
	done <"${options}"
	menu_options+=("Cancel")
	select option in "${menu_options[@]}"; do
		if [ "${option}" ] && [ "${option}" != "Cancel" ]; then
			eval "$resultvar=\"${option/%\ */}\""
		fi
		break
	done
}

echo $version

# fn_install_menu_bash selection "TITLE" "CAPTION" $serverlist
# echo $selection
