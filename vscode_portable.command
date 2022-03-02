#!/bin/bash -x
VSCODE_DATA_SUBDIR=code-portable-data
VSCODE_DIR=$1
if [ -z "$VSCODE_DIR" ]; then VSCODE_DIR="Visual Studio Code.app"; fi
VSCODE_DIR=${VSCODE_DIR%/}
if [ ! -d "$VSCODE_DIR" ]; then exit 1; fi
if [ ! -f "$VSCODE_DIR/Contents/Resources/app/bin/code" ]; then exit 1; fi
mkdir -p "$(dirname "$VSCODE_DIR")/$VSCODE_DATA_SUBDIR"/{"user-data","extensions","tmp"} || exit 1
xattr -dr com.apple.quarantine "$VSCODE_DIR"
exit 0
