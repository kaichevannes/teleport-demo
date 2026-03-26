#!/usr/bin/env bash
[ ! -p hostbrowserpipe ] && mkfifo hostbrowserpipe
while read -r URL < hostbrowserpipe; do xdg-open "$URL"; done
