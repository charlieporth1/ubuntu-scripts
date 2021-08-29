#!/bin/bash
ARGS="$@"
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(ad[-]?list)'` ]] && ADLIST_REGEX='' || ADLIST_REGEX='|(http[s]?|ftp)'
file="$1"
grep -Ev --line-buffer "^(#|//|\!!$ADLIST_REGEX)" $file
