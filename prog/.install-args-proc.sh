#!/bin/bash
ARGS="$@"
source /etc/environment
for env in $( cat /etc/environment ); do export $(echo $env | sed -e 's/"//g') > /dev/null 1>2; done
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(a|automatic)'` ]] && export AUTOMATIC_INSTALL=true || export AUTOMATIC_INSTALL=false
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(nr|no[t]?(-|)restart)'` ]] && export NO_RESTART=true || export NO_RESTART=false
export IS_MASTER="$IS_MASTER"
if [[ -z $IS_MASTER ]]; then
	[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(m|master|main)'` ]] && export IS_MASTER=true || export IS_MASTER=false
fi

if [[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(oac|only-apply(-|)config)'` ]]; then
	export APPLY_CONFIG=true
	export NO_RESTART=true
fi
