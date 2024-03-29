#!/bin/bash
ARGS="$@"
source /etc/environment
for env in $( cat /etc/environment ); do export $(echo $env | sed -e 's/"//g') > /dev/null 2>&1; done

[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(a|automatic)'` ]] && export AUTOMATIC_INSTALL=true || export AUTOMATIC_INSTALL=false
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)?(nr|no[t]?(-)?restart)'` ]] && export NO_RESTART=true || export NO_RESTART=false
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(i|install)'` ]] && export INSTALL=true || export INSTALL=false
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)?(uq|qu|update(-)?quick|quick(-)?update)'` ]] && export UPDATE_QUICK=true || export UPDATE_QUICK=false

export IS_MASTER="$IS_MASTER"

if [[ -z "$IS_MASTER" ]]; then
	[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(m|master|main)'` ]] && export IS_MASTER=true || export IS_MASTER=false
fi

if [[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)?(oac|aoc|ac|((only)?)((-)?)apply((-)?)((config)?))'` ]]; then
	echo "Applying config only"
	export APPLY_CONFIG=true
	export NO_RESTART=true
else
	export APPLY_CONFIG=false
fi
