#!/bin/bash
sysctl -w net.ipv6.conf.all.forwarding=1
sysctl -w net.ipv4.ip_forward=1
count=3
timeout=9
sudo ip route del 192.168.44.0/24 dev eth0 proto kernel scope link src 192.168.44.250
sudo ifconfig eth0 192.168.44.250 up
sudo ip add del 192.168.44.244/24 dev eth1

function iface_restart() {
	local iface="$1"
	sudo ifconfig eth0 192.168.44.250 up
        sudo ip link set $iface up
        sudo ip link set $iface down
        sudo ip addr flush $iface
	sudo ip addr replace 192.168.44.250 dev eth0
        sudo ip link set $iface up
	(
		sudo dhclient -r
		sudo dhclient -s 192.168.44.1
	)&
	sudo netplan apply
}
services='networking.service dhcp.service dhcpcd.service'



iface=eth1
if ! ifconfig | grep -o $iface > /dev/null
then
	iface_restart $iface
fi

iface=eth0
if ! ifconfig | grep -o $iface > /dev/null
then
	iface_restart $iface
fi

iface=eth0
should_add=192.168.44.250
sudo ip add del `sudo ip add show dev $iface | grepip -4 | awk '{print $2}' | grep -v $should_add | sed -n '1p'` dev $iface

iface=eth1
should_add=192.168.12.244
sudo ip add del `sudo ip add show dev $iface | grepip -4 | awk '{print $2}' | grep -v $should_add | sed -n '1p'` dev $iface

iface=eth0
if ! ping -c $count -w $timeout 192.168.44.1 -I $iface > /dev/null
then
	iface_restart eth0
#	sudo systemctl restart networking
	sudo ifconfig eth0 192.168.44.250 up
#	sudo ifconfig eth0:0 192.168.44.250 up
#	sudo ifconfig eth0:1 192.168.44.252 up
#	sudo ifconfig eth0:2 192.168.44.253 up
#	sudo ifconfig eth0:3 192.168.44.254 up
#	sudo ifconfig eth0:4 192.168.44.243 up
	sudo ifconfig eth0 192.168.44.250 up

	sudo systemctl restart $services
elif ! ping -c $count -w $timeout 1.1.1.1 -I $iface > /dev/null
then
	iface_restart $iface

elif ! ping -c $count -w $timeout 192.168.44.249 -I $iface > /dev/null
then
	iface_restart $iface
	sudo systemctl restart $services
fi

sudo ifconfig eth0 192.168.44.250 up
