#!/bin/bash
sysctl -w net.ipv6.conf.all.forwarding=1
sysctl -w net.ipv4.ip_forward=1
count=3
timeout=12
sudo ip route change default via 192.168.44.1 dev eth0
ip_iface_1=192.168.44.250
#sudo ip route del 192.168.44.0/24 dev eth0 proto kernel scope link src 192.168.44.250
sudo ifconfig eth0 192.168.44.250 up
sudo ifconfig eth1 192.168.12.250 up
#sudo rm -rf /etc/resolv.conf
#sudo ln -nsf ../run/resolvconf/resolv.conf /etc/resolv.conf

services='networking.service dhcpcd.service'
function iface_restart() {
	local iface="$1"
	sudo bash $PROG/resolvconf_fix.sh
	sudo ip route change default via 192.168.44.1 dev eth0
	sudo ifconfig eth0 192.168.44.250 up
        sudo ip link set $iface up
        sudo ip link set $iface down
        sudo ip addr flush $iface
	sudo ip addr replace 192.168.44.250 dev eth0
        sudo ip link set $iface up
#	(
#		sudo dhclient -r
#		sudo dhclient -s 192.168.44.1
#	)&
	sudo systemctl restart systemd-networkd dhcpcd.service
	sudo netplan generate
	sudo netplan apply

	sudo ip tunnel del he-ipv6
	sudo ip tunnel del is0
	sudo modprobe -r sit

}



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
should_add=192.168.12.250
sudo ip add del `sudo ip add show dev $iface | grepip -4 | awk '{print $2}' | grep -v $should_add | sed -n '1p'` dev $iface

iface=eth0
if ! ping -c $count -w $timeout 192.168.44.1 -I $iface > /dev/null
then
	iface_restart $iface
#	sudo systemctl restart networking
	sudo ifconfig eth0 192.168.44.250 up
#	sudo ifconfig eth0:0 192.168.44.250 up
#	sudo ifconfig eth0:1 192.168.44.252 up
#	sudo ifconfig eth0:2 192.168.44.253 up
#	sudo ifconfig eth0:3 192.168.44.254 up
#	sudo ifconfig eth0:4 192.168.44.243 up
	sudo ifconfig eth0 192.168.44.250 up

elif ! ping -c $count -w $timeout 1.1.1.1 -I $iface > /dev/null
then
	iface_restart $iface
elif ! ping -c $count -w $timeout 192.168.44.249 -I $iface > /dev/null
then
	iface_restart $iface
elif ! ping -c $count -w $timeout 192.168.44.250 -I $iface > /dev/null
then
	sudo ifconfig eth0 192.168.44.250 up
	iface_restart $iface
fi
elif ! dig www.google.com +short > /dev/null
then
	sudo ifconfig eth0 192.168.44.250 up
	iface_restart $iface
fi

sudo ifconfig eth0 192.168.44.250 up

sudo ip tunnel del he-ipv6
sudo ip tunnel del is0
sudo modprobe -r sit

