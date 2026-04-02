#!/usr/bin/env bash
# https://stackoverflow.com/questions/54437534/docker-open-a-url-in-the-host-browser/73750272#73750272
[ ! -p hostbrowserpipe ] && mkfifo hostbrowserpipe
while read -r URL < hostbrowserpipe; do xdg-open "$URL"; done
