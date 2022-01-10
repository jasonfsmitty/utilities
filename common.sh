#!/bin/bash

#---------------------------------------------------------------------
# https://unix.stackexchange.com/questions/9957/how-to-check-if-bash-can-print-colors
if test -t 1
then
	# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux

	# Reset
	NO_COLOR='\033[0m'       # Text Reset
	NC=${NO_COLOR}

	# Regular Colors
	BLACK='\033[0;30m'        # Black
	RED='\033[0;31m'          # Red
	GREEN='\033[0;32m'        # Green
	YELLOW='\033[0;33m'       # Yellow
	BLUE='\033[0;34m'         # Blue
	PURPLE='\033[0;35m'       # Purple
	CYAN='\033[0;36m'         # Cyan
	WHITE='\033[0;37m'        # White

	# Bold
	BBLACK='\033[1;30m'       # Black
	BRED='\033[1;31m'         # Red
	BGREEN='\033[1;32m'       # Green
	BYELLOW='\033[1;33m'      # Yellow
	BBLUE='\033[1;34m'        # Blue
	BPURPLE='\033[1;35m'      # Purple
	BCYAN='\033[1;36m'        # Cyan
	BWHITE='\033[1;37m'       # White
fi

#---------------------------------------------------------------------
# Display a fatal error, then exit immediately
function error()
{
	echo -e "- ${RED}ERROR${NC}: ${@}" 1>&2
	exit 1
}

#---------------------------------------------------------------------
# Display a warning, then continue on
function warn()
{
	echo -e "- ${YELLOW}WARN ${NC}: ${@}" 1>&2
}

#---------------------------------------------------------------------
function info()
{
	echo "+ ${@}"
}

#---------------------------------------------------------------------
function debug()
{
	echo "+ ${@}" 1>&2
}

#---------------------------------------------------------------------
# Add a prefix to every line piped via stdin;
# Example:
#    cat <somefile> | prefix "contents: "
function prefix()
{
	sed "s/^/${1}/"
}

#---------------------------------------------------------------------
# Convienence wrapper around prefix to indent every line 4 spaces
function indent()
{
	prefix "    "
}
#---------------------------------------------------------------------
# Spinning bar, use Ctrl-C to quit spinning and return to the calling code
function spinner()
{
	(
		trap 'exit 0' SIGINT

		i=1
		sp="/-\|"

		echo -n ' '
		while true
		do
			printf "\b${sp:i++%${#sp}:1}"
			sleep 0.5
		done
	)
	echo ""
	return 0
}

#---------------------------------------------------------------------
function banner()
{
	echo "+-----------------------------------------------------------------------"
	echo "+ ${@}"
	echo "+-----------------------------------------------------------------------"
}

#---------------------------------------------------------------------
function fileExists()
{
	[[ -f "${1}" ]]
}

#---------------------------------------------------------------------
function fileMissing()
{
	[[ ! -f "${1}" ]]
}

#---------------------------------------------------------------------
# Usage:
#   join '<delim>' <args>
# Example:
#   a=( 1 2 3 )
#   join , ${a[@]} => 1,2,3
function join()
{
	local IFS="${1}"
	shift
	echo "${*}"
}

#---------------------------------------------------------------------

