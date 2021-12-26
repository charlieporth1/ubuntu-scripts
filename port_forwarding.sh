#!/bin/bash

# decide which action to use
action="add"
if [[ "-r" == "$1" ]]; then
  action="remove"
  shift
fi

# break out components
dest_addr_lan="$1"
dest_port_wan="$2"
dest_port_lan="$3"

# figure out our WAN ip
wan_addr=${4:-`curl -4 -s icanhazip.com`}

# auto fill our dest lan port if we need to
if [ -z $dest_port_lan ]; then
  dest_port_lan="$dest_port_wan"
fi

# print info for review
echo "Destination LAN Address: $dest_addr_lan"
echo "Destination Port WAN: $dest_port_wan"
echo "Destination Port LAN: $dest_port_lan"
echo "WAN Address: $wan_addr"

# confirm with user
read -p "Does everything look correct? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]; then
  if [[ "remove" == "$action" ]]; then
    iptables -t nat -D PREROUTING  -p tcp -m tcp -d $wan_addr --dport     $dest_port_wan -j DNAT --to-destination $dest_addr_lan:$dest_port_lan
    iptables -D FORWARD -m state -p tcp -d $dest_addr_lan --dport     $dest_port_lan --state NEW,ESTABLISHED,RELATED -j ACCEPT
    iptables -t nat -D POSTROUTING -p tcp -m tcp -s $dest_addr_lan --sport     $dest_port_lan -j SNAT --to-source $wan_addr
    echo "Forwarding rule removed"
  else
    iptables -t nat -A PREROUTING  -p tcp -m tcp -d $wan_addr --dport     $dest_port_wan -j DNAT --to-destination $dest_addr_lan:$dest_port_lan
    iptables -A FORWARD -m state -p tcp -d $dest_addr_lan --dport     $dest_port_lan --state NEW,ESTABLISHED,RELATED -j ACCEPT
    iptables -t nat -A POSTROUTING -p tcp -m tcp -s $dest_addr_lan --sport $dest_port_lan -j SNAT --to-source $wan_addr
    echo "Forwarding rule added"
  fi
else
  echo "Info not confirmed, exiting..."
fi
