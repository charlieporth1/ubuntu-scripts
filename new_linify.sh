#!/bin/bash
if [ "$#" -eq 0 ]; then
  ARUGMENT_ARRAY=( $( cat  /dev/stdin ) )
else
  ARUGMENT_ARRAY=( "$@" )
fi
REGEX_EXCLUDE="${ARUGMENT_ARRAY[@]/%/\\n}"      # result: key1\| key2\| key3\|
unset ARUGMENT_ARRAY
REGEX_EXCLUDE="${REGEX_EXCLUDE// }"
REGEX_EXCLUDE="$(echo ${REGEX_EXCLUDE} | rev | cut -c 3- | rev)"
echo -e "$REGEX_EXCLUDE"
unset REGEX_EXCLUDE

