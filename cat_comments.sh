#!/bin/bash
ARGS="$@"
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(ad[-]?list)'` ]] && ADLIST_REGEX='' || ADLIST_REGEX='|(http[s]?|ftp)'
file="$1"

shopt -s extglob
function ltrim ()
{
    sed -E 's/^[[:space:]]+//'
}
export -f ltrim

function rtrim ()
{
    sed -E 's/[[:space:]]+$//'
}
export -f rtrim
function trim ()
{
	awk '{$1=$1;print}'
}
export -f trim

cat $file | grep "\S" | grep -Ev --line-buffer "^(#|//|\!!$ADLIST_REGEX)" | trim
#parallel --lb -P 4 --jobs +1 echo '{}' :::: $file | grep "\S" | grep -Ev --line-buffer "^(#|//|\!!$ADLIST_REGEX)" | trim

