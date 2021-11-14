#!/bin/bash

ip_addresses=`sudo tailscale status | awk '{print $1}'`

for ip_add in ${ip_addresses}
do
	scp $
done
