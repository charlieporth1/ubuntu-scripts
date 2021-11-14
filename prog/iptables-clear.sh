#!/bin/bash
wait=20
sudo systemctl stop fail2ban
sudo systemctl mask fail2ban
update-alternatives --remove iptables /usr/sbin/iptables-legacy
sudo update-alternatives --remove ip6tables /usr/sbin/ip6tables-legacy
for i in `seq 0 35`
do
	sudo ipset destroy
	sudo ipset flush
	sleep 4s
	ipset_tables=`sudo ipset list | grep 'Name' | awk -F: '{print $2}'`
	if [[ -z "$ipset_tables" ]]; then
		break
	fi
done
echo "Displaying ipset list"
sudo ipset list | head -25
printf '%s\n' "$ipset_tables" | head -25


sudo iptables-nft -P INPUT ACCEPT --wait $wait
sudo iptables-nft -P FORWARD ACCEPT --wait $wait
sudo iptables-nft -P OUTPUT ACCEPT --wait $wait
sudo iptables-nft -t nat -F --wait $wait
sudo iptables-nft -t mangle -F --wait $wait
sudo iptables-nft -F --wait $wait
sudo iptables-nft -X --wait $wait
sudo iptables-nft -F --wait $wait
sudo iptables-nft -X --wait $wait

sudo iptables-legacy -P INPUT ACCEPT --wait $wait
sudo iptables-legacy -P FORWARD ACCEPT --wait $wait
sudo iptables-legacy -P OUTPUT ACCEPT --wait $wait
sudo iptables-legacy -t nat -F --wait $wait
sudo iptables-legacy -t mangle -F --wait $wait
sudo iptables-legacy -F --wait $wait
sudo iptables-legacy -X --wait $wait
sudo iptables-legacy -F --wait $wait
sudo iptables-legacy -X --wait $wait

sudo iptables -P INPUT ACCEPT --wait $wait
sudo iptables -P FORWARD ACCEPT --wait $wait
sudo iptables -P OUTPUT ACCEPT --wait $wait
sudo iptables -t nat -F --wait $wait
sudo iptables -t mangle -F --wait $wait
sudo iptables -F --wait $wait
sudo iptables -X --wait $wait
sudo iptables -F --wait $wait
sudo iptables -X --wait $wait
echo "Displaying iptables-nft list"
echo "Displaying iptables-nft list"
chains=`sudo iptables-nft -S -w 4 | grep -oE 'f2b-.*(udp|tcp| )'  | sort -u | grep -v 'wg0\|tailscale0\|lo\|ts-forward'`
sudo iptables-nft -S | head -25
echo "Displaying iptables--leg list"

sudo iptables-legacy -S | head -25
echo "Displaying iptables list"
sudo iptables -S | head -25
printf '%s\n' "$chains" | head -25

sudo systemctl unmask fail2ban
sudo systemctl start fail2ban
