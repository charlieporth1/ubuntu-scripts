#!/bin/bash
SCRIPT=`basename $0 | rev | cut -d '/' -f 1 | rev`
R_PROGRAM="${1:-$SCRIPT}"
FILE_NAME=`echo "$R_PROGRAM" | rev | cut -d '.' -f 2 | rev`

INPUT_PID=`echo "$@" | grep -E '[0-9]'`
LOCAL_PID="$$"

function TO_EXCLUDE() {
	local VAR="$1"
	if [[ -n "$VAR" ]] && [[ -n "$EXCLUDE_PIDS" ]]; then
	 	declare -g EXCLUDE_PIDS="$EXCLUDE_PIDS\|$VAR"
	elif [[ -n "$VAR" ]]; then
	 	declare -g EXCLUDE_PIDS="$VAR"
	fi
}

if [[ -n "$THIS_PID" ]]; then
	POSSIABLE_ROOT_OR_START_PID=$(($THIS_PID - 10))
	START_PID=`ps -aux | grep "$R_PROGRAM" | awk '{print $2}' | grep -Fx -o -e"$(seq $POSSIABLE_ROOT_OR_START_PID $THIS_PID)"`
	CHILD_PIDS=`pgrep -P $THIS_PID | xargs`
	G_CHILD_PIDS=${CHILD_PIDS/\ //\\|}
fi

OTHER_EXCLUDED_PIDS=`ps -aux | grep "$R_PROGRAM\|$FILE_NAME" | grep -E "(grep|nano|vi|vim|tail|$0)" | awk '{print $2}' | xargs`
OE_PIDS="${OTHER_EXCLUDED_PIDS//\ /\\|}"

TO_EXCLUDE $INPUT_PID
TO_EXCLUDE $LOCAL_PID
TO_EXCLUDE $BASHPID
TO_EXCLUDE $G_CHILD_PIDS
TO_EXCLUDE $OE_PIDS
TO_EXCLUDE $START_PID
TO_EXCLUDE $0

PROGS=`ps -aux | grep "$R_PROGRAM" | grep -v "$EXCLUDE_PIDS"`
PROG_PIDS=`printf '%s\n' "$PROGS" | awk '{print $2}' | grep -v "$EXCLUDE_PIDS" | sort | uniq -c | sort -nr | awk '{print $2}'`
PID_COUNT=`printf '%s\n'  "$PROG_PIDS" | grep -c '[0-9]'`
PROGS_PIDS_PG=`pgrep --newest --full $R_PROGRAM`
PROGS_PIDS_PG_COUNT=`pgrep --newest --full --count $R_PROGRAM`
PROG_COUNT_WITHOUT_MAIN=`printf '%s\n' "$PROGS_PIDS_PG" | grep -v "$EXCLUDE_PIDS" | grep -c '[0-9]'`
PROG_COUNT=$(( $PROG_COUNT_WITHOUT_MAIN ))

{ [[ $PROG_COUNT == 0 ]] && [[ $PID_COUNT > 0 ]]; } && PROG_COUNT=$PID_COUNT
if [[ -z $R_PROGRAM ]]; then
	echo "You need to speify a program"
fi
if [[ -n "`echo $@ | grep -o '\-v'`" ]]; then
	echo "This file $0"
	echo "Looking around pid $THIS_PID and looking for program $R_PROGRAM"
	echo "And excluding pids $EXCLUDE_PIDS"
	echo "Child PIDS $CHILD_PIDS"
	echo "G_CHILD_PIDS $G_CHILD_PIDS"
	echo "PROGS_PIDS_PG $PROGS_PIDS_PG"
	echo "PROGS $PROGS"
fi
if [[ -n "`echo $@ | grep -o 'show-prog\|show-program'`" ]]; then
	echo "PROGs: $PROGS"	#TODO
fi
if [[ -n "`echo $@ | grep -o 'show-pid\|pid'`" ]]; then
	echo "Process count: $PROG_COUNT"
	echo "PIDs: "`echo $PROG_PIDS | xargs`""
else
	echo $PROG_COUNT
fi
