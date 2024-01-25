#!/usr/bin/env bash

TMPDIR="$(uuidgen)"
INSTDIR="$HOME/.local/programs/vscode"
mkdir "$TMPDIR"
curl -o vscode.tar.gz -L "https://code.visualstudio.com/sha/download?build=stable&os=linux-x64"
tar -x -f vscode.tar.gz -C "$TMPDIR"
if [ -d "$INSTDIR" ]
then
    for P in `pgrep code`; do kill $P; done
    rm -rf "$INSTDIR"
    for D in `ls "$TMPDIR"`; do mv "$TMPDIR/$D" "$INSTDIR/../vscode"; done
else
    for D in `ls "$TMPDIR"`; do mv "$TMPDIR/$D" "VSCode"; done
fi
