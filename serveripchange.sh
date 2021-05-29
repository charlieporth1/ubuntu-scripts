#!/bin/bash
if ! [[ -f  /opt/ipaddress.txt ]]; then
	touch  /opt/ipaddress.txt
fi
iphistory=$(cat /opt/ipaddress.txt)
extip=$(curl -s ipinfo.io/ip)
echo "iphistory $iphistory"
echo "extip $extip"

if [[ "$extip"  != "$iphistory" ]]; then
	echo "The IP address has changed to $extip from $iphistory"
	. /usr/bin/cred.sh
	sendemail -f $USER@otih-oith.us.to -t $phonee  -m "Your server IP address has changed to $extip; from $iphistory" -s smtp.gmail.com:587 -o tls=yes -xu $usr -xp $passwd 
	echo $extip > /opt/ipaddress.txt
else
	echo "No IP address change your IP is still $extip"
fi
