#!/bin/bash
ifa=lo_cache
nm=192.168.40.255
rip_loop=192.168.123
broadcast=0.0.0.0
for i in {0..8}
do
        IP="$rip_loop.$((i+1))"
        DEV=$ifa$i
        sudo ip link add name $DEV type dummy
        sudo ifconfig $DEV $IP netmask $nm broadcast $broadcast up
        sudo ifconfig $DEV mtu 65535
        sudo ifconfig $DEV txqueuelen 9000
        sudo sysctl -w net.ipv6.conf.$DEV.disable_ipv6=1
        sudo sysctl -w net.ipv4.conf.$DEV.rp_filter = 0
        sudo sysctl -w net.ipv4.conf.$DEV.send_redirects=0
	HOST_TO_WRITE="$IP $ifa$i.local internal-dns$i.local pihole$i.local"
	[[ -z `grep -o $HOST_TO_WRITE /etc/hosts` ]] && echo "$HOST_TO_WRITE" | sudo tee -a /etc/hosts
        echo "Added device $DEV with IP $IP"
done

broadcast=0.0.0.0
CACHE_DEV=lo_cache
IP=192.168.127.10
sudo ifconfig lo:0 127.0.0.9 netmask $nm broadcast 255.0.0.0 up
sudo ip link add name $CACHE_DEV type dummy
sudo ifconfig $CACHE_DEV 192.168.127.10 netmask 255.0.0.0 broadcast 192.168.127.10 up
sudo ifconfig $CACHE_DEV mtu 65535
sudo ifconfig $CACHE_DEV txqueuelen 90000000

HOST_TO_WRITE="$IP cache.local cache0.local $CACHE_DEV.local"
[[ -z `grep -o "$HOST_TO_WRITE" /etc/hosts` ]] && echo "$HOST_TO_WRITE" | sudo tee -a /etc/hosts
