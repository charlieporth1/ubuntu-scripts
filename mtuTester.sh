#!/bin/bash 
export found=$( true )
export mtuNum=100 
export inc=50
export incminus=100
export net="printf y"
echo "Network devices: $(ifconfig | awk '{print $1}' | grep -v 'docker\|inet\|lo\|inetxf6\|UP\|RX\|TX\|collisions:*\|virbr0\|ether'| cut -d ':' -f 1)"
read -p "Enter networking device: " net
export mtuNumStart=$(sudo ifconfig $net | grep mtu | awk '{print $4}')
export excStr='SIOCSIFMTU: Invalid argument'
while $found
do
if [[ "$mtuNum-$inc" != "$(sudo ifconfig $net | grep mtu | awk '{print $4}')" ]];then
let "mtuNum+=$inc"
sudo ifconfig $net  mtu $mtuNum
echo "mtu is at: " $mtuNum "; for device: " $net
else 
echo "mtu stopped at: " $mtuNum "; for device: " $net
export found=$( false )
break
fi

done
