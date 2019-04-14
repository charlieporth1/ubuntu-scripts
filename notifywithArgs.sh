#!/bin/bash
. /usr/bin/cred.sh
export arg1=$1
export arg2=$2
export arg3=$3
export arg4=$4
export arg5=$5
export arg6=$6
export arg7=$7
export arg8=$8
export arg9=$9
sendemail -f $USER@otih-oith.us.to -t $phonee  -m "Your $arg1 $arg2 $arg3 $arg4 $arg5 $arg6 $arg7 $arg8 $arg9"   -s smtp.gmail.com:587 -o tls=yes -xu $usr -xp  $passwd

