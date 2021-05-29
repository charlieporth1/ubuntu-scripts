#!/bin/bash
NS_INSTALLED="# CTP NS INSTALL"
if [[ -z `grep -o "$NS_INSTALLED"` ]]; then
	echo "$NS_INSTALLED" | sudo tee -a /etc/resolv.conf
	echo 'nameserver 1.1.1.1' | sudo tee -a /etc/resolv.conf
	echo 'nameserver 1.0.0.1' | sudo tee -a /etc/resolv.conf
	echo 'nameserver 8.8.8.8' | sudo tee -a /etc/resolv.conf
	echo 'nameserver 8.8.4.4' | sudo tee -a /etc/resolv.conf
fi
