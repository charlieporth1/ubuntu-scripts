#!/bin/bash
#note this a test for clean reboots after a force reboot
if [ ! -f /opt/isForceTrue ]; then 
        export StrDay=${1:-${Today:0:10}}
        export N_Crash=`last -F  |grep crash  |  grep "$StrDay"  | sort -k 7 -u | wc -l`
        export N_Reboot=`last -F | grep reboot | grep "$StrDay"  | wc -l `
        rm -rf /opt/isForceTrue
	echo "reboot number: $N_Reboot"
        if [ "$N_Reboot" -le "10" ]; then 
#                sudo reboot -f
	echo "reboot" 
       fi
fi
