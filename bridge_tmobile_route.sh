#!/bin/bash

ip route add 192.168.12.0/24 via 192.168.44.250

echo 1 > /proc/sys/net/ipv4/ip_forward
