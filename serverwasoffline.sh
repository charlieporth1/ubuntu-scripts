#!/bin/bash

export isonline=$(ping 8.8.8.8 | awk '/icmp_seq=5/ {print $4}')
cat $( echo $isonline) > /mnt/HDD/isonline
if [$(cat /mnt/HDD/isonline) =!  ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+ ]; then
if [[ $isonline  =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
. /usr/bin/cred.sh
sendemail -f $USER@otih-oith.us.to -t $phonee  -m "Your server $HOSTNAME is back online via internet at $(date)"  -s smtp.gmail.com:587 -o tls=yes -xu $usr -xp  $passwd
rm -rf /mnt/HDD/isonline
echo "send email"
exit
fi
echo "not offline"
exit
echo "is offline but not back on yet"
fi
exit
