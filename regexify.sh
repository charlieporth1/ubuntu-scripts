#!/bin/bash
if [ "$#" -eq 0 ]; then
  ARUGMENT_ARRAY=(  )
else
  ARUGMENT_ARRAY=( "$@" )
fi
REGEX_EXCLUDE="${ARUGMENT_ARRAY[@]/%/|}"      # result: key1\| key2\| key3\|
unset ARUGMENT_ARRAY
REGEX_EXCLUDE="${REGEX_EXCLUDE// }"
REGEX_EXCLUDE="($(echo ${REGEX_EXCLUDE} | rev | cut -d '|' -f 2- | rev ))"
echo "$REGEX_EXCLUDE"
unset REGEX_EXCLUDE
