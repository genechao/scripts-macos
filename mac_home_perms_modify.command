#!/bin/bash
# macOS Modify Home Directory Permissions
# Usage: mac_home_perms_modify.command homedir user/group a/d
# By: Gene Chao - Last updated: 10/7/2019

function fn_error ()
{
	if [ ! -z "$1" ]; then echo $*; fi
	exit 1
}
function fn_usage ()
{
	_script=$1
	fn_error Usage: ${_script:=$0} homedir user/group a/d
}

if [ -z "$3" ]; then fn_usage "$0"; fi
if [ ! -d "$1" ]; then fn_error Directory does not exist; fi
_user_input=$(tr '[:upper:]' '[:lower:]' <<< "$2")
_user_input=${_user_input// /}
if [ -z "$_user_input" ]; then fn_usage "$0"; fi
_action_input=$3
_action_input=${_action_input:0:1}
case "$_action_input" in
	a|A)
		_action_input=a
		_action_param=+ai
	;;
	d|D)
		_action_input=d
		_action_param=-a
	;;
	*)
		fn_usage "$0"
esac

(set -x; chmod -R $_action_param "$_user_input allow list,add_file,search,add_subdirectory,delete_child,readattr,writeattr,readextattr,writeextattr,readsecurity,file_inherit,directory_inherit" "$1" && ls -led "$1")
