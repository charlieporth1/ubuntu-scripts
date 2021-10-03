#!/bin/bash
port_and_or_ip="$1"

if [[ -n "$port_and_or_ip" ]]; then
	sudo netstat -tulpn | grep "$port_and_or_ip" | awk -F/ '{print $1}' | awk '{print $7}' | sort -u | grep "\S"
else
	echo "NULL"
	exit 1
fi
