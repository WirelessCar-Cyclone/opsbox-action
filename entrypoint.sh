#!/bin/sh

FILE=/Makefile
if [[ -f "$FILE" ]]; then
    sh -c "/usr/bin/make $*"
else
    sh -c "/usr/bin/make -C / -f /usr/local/bin/application $*"
fi
