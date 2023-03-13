#!/bin/bash

#---------------------------------------------------------------------
# Options for common functions; can modify directly or use the
# appropriate set_*() helper.

OPT_COMMON_VERBOSE=${OPT_COMMON_VERBOSE:-false}
OPT_COMMON_DRY_RUN=${OPT_COMMON_DRY_RUN:-false}

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
function parse_bool()
{
	case "${1}" in
		true|yes|1)
			return 0
			;;

		false|no|0)
			return 1
			;;
	esac
	return 2
}

#---------------------------------------------------------------------
function to_bool()
{
	parse_bool "${1}" && echo "true" || echo "false"
}

#---------------------------------------------------------------------
function set_verbose()
{
	OPT_COMMON_VERBOSE="$(to_bool $1)"
}

#---------------------------------------------------------------------
function is_verbose()
{
	${OPT_COMMON_VERBOSE}
}

#---------------------------------------------------------------------
function set_dry_run()
{
	OPT_COMMON_DRY_RUN="$(to_bool $1)"
}

#---------------------------------------------------------------------
function is_dry_run()
{
	${OPT_COMMON_DRY_RUN}
}

#---------------------------------------------------------------------
function run()
{
	if ${OPT_COMMON_DRY_RUN}
	then
		info "SKIP: ${@}"
	else
		debug "Running '${@}'"
		"${@}"
	fi
}

#---------------------------------------------------------------------
function quietly()
{
	local command="${1}"
	shift

	if is_verbose
	then
		run "${command}" "${@}"
	else
		run "${command}" "${@}" >/dev/null
	fi
}

#---------------------------------------------------------------------
# Display an error, but do not exit; this is for use in cases
# where the caller wants to take some action (such as printing
# usage info) between the error message and exiting.
function error_msg()
{
	echo -e "- ${RED}ERROR${NC}: ${@}" 1>&2
}

# Display a fatal error, then exit immediately
function error()
{
	error_msg "${@}"
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
function banner()
{
	echo "+-----------------------------------------------------------------------"
	echo "+ ${@}"
	echo "+-----------------------------------------------------------------------"
}

#---------------------------------------------------------------------
function maybe_banner()
{
	if is_verbose
	then
		banner "${@}"
	else
		info "${@}"
	fi
}

#---------------------------------------------------------------------
# Add a prefix to every line piped via stdin;
# Example:
#    cat <somefile> | prefix "contents: "
function prefix()
{
	while IFS= read -r line; do echo -e "${1}${line}"; done
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

