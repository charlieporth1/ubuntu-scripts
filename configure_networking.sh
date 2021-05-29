#!/bin/bash
ifconfig enp2s0 up
sudo ifconfig wlan0 down
sudo ifconfig wlan0 up
sudo wpa_supplicant -B -D wext -i wlan0 -c /etc/wpa_supplicant.conf
#sudo ifconfig wlan0 192.168.44.44/32 up
sudo ifconfig wlan0 up
sudo ifdown wlan0 && sudo ifup -v wlan0
ping -c3 www.ubuntu.com
sudo dhclient wlan0
iw wlan0 link
