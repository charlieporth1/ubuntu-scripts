#!/bin/bash                                                                                                                                                   

# Date 1

function capture_stderr {
  [ $# -lt 2 ] && return 2
  local stderr="$1"
  shift
  {
    printf -v "$stderr" '%s' "$({ "$@" 1>&3; } 2>&1)"
  } 3>&1
}

#D1_IS_INVAILD=/tmp/D1_IS_INVAILD
#D2_IS_INVAILD=/tmp/D2_IS_INVAILD
dt1=`capture_stderr D1_IS_INVAILD date -d "$1"`
dt2=`capture_stderr D2_IS_INVAILD date -d "$2"`

d=$(date +%Y-%m-%d)
t=$(date +%H:%M:%S)
[[ -n $D1_IS_INVAILD ]] && dt1=`capture_stderr D1_IS_INVAILD date -d "$d $1"`
[[ -n $D1_IS_INVAILD ]] && dt1=`capture_stderr D1_IS_INVAILD date -d "$1 $t"`

[[ -n $D2_IS_INVAILD ]] && dt2=`capture_stderr D2_IS_INVAILD date -d "$d $2"`
[[ -n $D2_IS_INVAILD ]] && dt2=`capture_stderr D2_IS_INVAILD date -d "$2 $t"`

[[ -z "$2" ]] && dt2=$(date +%Y-%m-%d\ %H:%M:%S)

# Date 2 : Current date
# Compute the seconds since epoch for date 2
#echo "$dt2 $dt1"
t1=`date --date="$dt1" +"%s"`
t2=`date --date="$dt2" +"%s"`
# Compute the difference in dates in seconds
#let "tDiff=$t2-$t1"
let "tDiff=$t1-$t2"
#echo "$t1 $t2"
# Compute the approximate hour difference
#let "hDiff=$tDiff/3600"
#let "hDiff=$tDiff/"
echo "$tDiff"
#echo "Approx hour diff b/w $dt1 & $dt2 = $hDiff"
#echo "Approx hour diff b/w $dt1 & $dt2 = $hDiff"
