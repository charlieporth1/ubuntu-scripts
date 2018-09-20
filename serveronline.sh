#!/bin/bash
. /usr/bin/cred.sh
sendemail -f $USER@otih-oith.us.to -t $phonee  -m "Your server $HOSTNAME is back online at $(date)"  -s smtp.gmail.com:587 -o tls=yes -xu $usr -xp  $passwd



