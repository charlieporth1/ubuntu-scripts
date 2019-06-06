#!/bin/bash

Today=`date`
StrDay=${1:-${Today:0:10}}

N_Crash=`last -F  |grep crash  |  grep "$StrDay"  | sort -k 7 -u | wc -l`
N_Reboot=`last -F | grep reboot | grep "$StrDay"  | wc -l `

echo "# Today $Today  Report for crash and reboot on $StrDay  "
echo "# Crashes $N_Crash"
echo "# Reboot $N_Reboot"
