#!/bin/bash
#!/bin/bash
# macOS Resume Printers
# Usage: mac_printers_resume.command
# By: Gene Chao - Last updated: 10/9/2019

if [ ! -t 1 ]; then exit 1; fi

echo
echo Resume Printers
echo

_printers=()
while read -r _printer; do
	_printers+=($_printer)
done < <(lpstat -p | grep '^printer \w\+ disabled ' | awk '{print $2}')
if [ ! -z "$_printers" ]; then
	_canceljobs=n
	while true; do
		echo -n "Cancel all print jobs (y/n)? "
		read
		REPLY=${REPLY# }
		REPLY=${REPLY% }
		case "${REPLY:0:1}" in
			y|Y)
				_canceljobs=y
				break
			;;
			n|N)
				_canceljobs=n
				break
			;;
			*)
				continue
			;;
		esac
	done
	if [ "$_canceljobs" = "y" ]; then
		(set -x; cancel -ax ${_printers[*]})
	fi
	for _printer in ${_printers[*]}; do
		_cupsenable_params=
		if [ "$_canceljobs" = "y" ]; then _cupsenable_params=-c; fi
		(set -x; cupsenable $_cupsenable_params $_printer)
	done
else
	echo No disabled printers detected
fi
echo
