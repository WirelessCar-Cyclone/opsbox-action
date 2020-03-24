#!/bin/sh

FILE=/github/workspace/Makefile
if [[ -f "$FILE" ]]; then
    sh -c "/usr/bin/make $*"
else
    sh -c "/usr/bin/make -C /github/workspace/ -f /usr/local/bin/application $*"
fi
