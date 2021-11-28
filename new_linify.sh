#!/bin/bash
file="$1"
if [ "$#" -eq 0 ]; then
  ARUGMENT_ARRAY=( $( cat  /dev/stdin ) )
else
	line_count=$(wc -l $file | awk '{print $1}')
	MAX_ARGS=$( getconf ARG_MAX )
        if [[ -f $file ]] && [ "$#" -eq 1 ]; then
		if [[ $line_count -lt $MAX_ARGS ]]; then
			ARUGMENT_ARRAY=( $( cat $file ) )
		else
			# TO DO
			ARUGMENT_ARRAY=( $( parallel -P +4 -j +8 --cat $file ) )
			ARUGMENT_ARRAY_1=( $( parallel -P +4 -j +8 --cat $file ) )
			ARUGMENT_ARRAY_2=( $( parallel -P +4 -j +8 --cat $file ) )
			ARUGMENT_ARRAY_3=( $( parallel -P +4 -j +8 --cat $file ) )
		fi
	else
		ARUGMENT_ARRAY=( "$@" )
	fi
fi
REGEX_EXCLUDE="${ARUGMENT_ARRAY[@]/%/\\n}"      # result: key1\| key2\| key3\|
unset ARUGMENT_ARRAY
REGEX_EXCLUDE="${REGEX_EXCLUDE// }"
REGEX_EXCLUDE="$(echo ${REGEX_EXCLUDE} | rev | cut -c 3- | rev)"
echo -e "$REGEX_EXCLUDE"
unset REGEX_EXCLUDE

