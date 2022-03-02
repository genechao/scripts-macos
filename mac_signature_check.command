#!/bin/bash
# macOS Digital Signature Check
# Usage: mac_signature_check.command [path]
# By: Gene Chao - Last updated: 10/15/2019

echo
echo Digital Signature Check
echo

while true; do
	if [ -z "$1" ]; then
		echo -n "Filename: "
		read
		if [ -z "$REPLY" ]; then break; fi
		REPLY=${REPLY# }
		REPLY=${REPLY% }
		REPLY=${REPLY#\"}
		REPLY=${REPLY%\"}
		if [ ! -e "$REPLY" ]; then echo "\"$REPLY\" doesn't exist"; continue; fi
		echo
	else
		REPLY=$1
		if [ ! -e "$REPLY" ]; then echo "\"$REPLY\" doesn't exist"; break; fi
	fi
	codesign -dvv "$REPLY"
	echo
	pkgutil --check-signature "$REPLY"
	echo
	if [ ! -z "$1" ]; then break; fi
done
