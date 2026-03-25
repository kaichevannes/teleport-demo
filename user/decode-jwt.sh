#!/bin/sh
input="${1:-$(cat)}" # get argument or pipe value

printf "$input" | cut -d '.' -f 1 | basenc --base64url -d 2>/dev/null | jq .
printf "$input" | cut -d '.' -f 2 | basenc --base64url -d 2>/dev/null | jq .
printf "$input" | cut -d '.' -f 3 | basenc --base64url -d 2>/dev/null | tr -d "[:space:]"
printf '\n'
