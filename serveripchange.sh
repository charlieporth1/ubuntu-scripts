#!/bin/bash
export iphistory=$(cat /opt/ipaddress.txt)
export extip=$(curl -s ipinfo.io/ip)
#if (( $(curl -s ipinfo.io/ip)  != $(cat /opt/ipaddress.txt) )); then
if [ "$extip"  != "$iphistory" ]; then
echo "The IP address has changed to $extip from $iphistory"
curl -s ipinfo.io/ip > /opt/ipaddress.txt
. /usr/bin/cred.sh
sendemail -f $USER@otih-oith.us.to -t $phonee  -m "Your server IP address has changed to $extip" -s smtp.gmail.com:587 -o tls=yes -xu $user $passwd 
else 
echo "No IP address change your IP is still $extip"
fi 
