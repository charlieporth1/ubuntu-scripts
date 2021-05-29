#!/bin/bash
ARGS="$@"
SPACE_ARG_REGEX='(\-\-)(space)'
QUOTES_ARGS_REGEX='\-\-quotes'
[[ -n `echo "$ARGS" | grep -Eio "$SPACE_ARG_REGEX"` ]] && SPACE=true || SPACE=false
[[ -n `echo "$ARGS" | grep -io "$QUOTES_ARGS_REGEX"` ]] && QUOTES=true || QUOTES=false
if [ "$#" -eq 0 ]; then
  ARUGMENT_ARRAY=(  )
else
  ARUGMENT_ARRAY=( "$ARGS" )
fi
#if [[ "$QUOTES" == 'true' ]] || [[ "$SPACE" == 'true' ]]; then
REGEX_EXCLUDE="${ARUGMENT_ARRAY[@]//%/\,\ }"
#REGEX_EXCLUDE="${REGEX_EXCLUDE//,/}"
unset ARUGMENT_ARRAY
if [[ "$QUOTES" == 'true' ]]; then
	REGEX_EXCLUDE=$( echo "$REGEX_EXCLUDE" | awk -v OFS=',' '

NR==1{
    for (i=1;i<=NF;i++)
        if ($i=="--quotes") {
            n=i-1
            m=NF-(i==NF)
        }
    }

{
    for(i=1;i<=NF;i+=1+(i==n)) {
	if ($i=="--quotes") {
		printf ""
        } else {
        	printf "%s%s",$i,i==m?ORS:OFS
	}
    }
}

'
)
else
	REGEX_EXCLUDE="$REGEX_EXCLUDE"
fi

[[ "$QUOTES" == 'true' ]] && REGEX_EXCLUDE="${REGEX_EXCLUDE//,/\", \"}"
[[ "$SPACE" == 'false' ]] && REGEX_EXCLUDE="${REGEX_EXCLUDE// }"

REGEX_EXCLUDE="$( echo "${REGEX_EXCLUDE}" | rev | cut -d ',' -f 2- | rev )"
[[ "$QUOTES" == 'true' ]] && REGEX_EXCLUDE="\"${REGEX_EXCLUDE}"
echo "$REGEX_EXCLUDE"
unset REGEX_EXCLUDE


