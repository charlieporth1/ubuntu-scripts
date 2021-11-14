#!/bin/bash
TSERVV4IP=174.53.130.17
TSERVV4IP=192.168.44.250
V6PTPNET=2001:470:a::
modprobe -r sit
modprobe ipv6 sit

ip tunnel add he-ipv6 mode sit remote 184.105.253.14 local 174.53.130.17 ttl 255
ip link set he-ipv6 up
ip addr add 2001:470:1f10:5ba::2/64 dev he-ipv6
ip route add ::/0 dev he-ipv6
ip -f inet6 addr

ip tunnel add he-ipv6 mode sit remote 184.105.253.14 local 192.168.44.250 ttl 255
sudo ip link set sit0 up
sudo ip tunnel 6rd dev he-ipv6 6rd-prefix $V6PTPNET/64 6rd-relay_prefix $TSERVV4IP/32
