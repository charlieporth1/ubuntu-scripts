#!/bin/bash
source $PROG/all-scripts-exports.sh

export IPV6_CONFIG=$PROG/ipv6_config

ping6_exit_code_status=`ping6 -q -c 2 2001:4860:4860::8888 > /dev/null; echo $?`
echo "exit code: $ping6_exit_code_status"

if [[ $ping6_exit_code_status -gt 0 ]]; then
	echo "No ipv6 removing ipv6 files"
	rm -rf $UNBCONF/04-forward-ipv6.conf
	rm -rf $DNSMASQ/10-servers-ipv6.conf
	rm -rf $ROUTE/well-known-resolvers-dns64.toml
else
	sudo cp -rf $IPV6_CONFIG/routedns/* $ROUTE
	sudo cp -rf $IPV6_CONFIG/dnsmasq.d/* $DNSMASQ
	sudo cp -rf $IPV6_CONFIG/unbound/* $UNBOUND
CTP_STR="# CTP Script Mode"
if [[ -z `grep -o "$CTP_STR" /etc/resolv.conf` ]] then
echo """$CTP_STR `date`
# Generated by $scriptName `date`
# IPv6 Conntivity was tested thats why this was added on `date`
nameserver 2001:4860:4860::8844
nameserver 2001:4860:4860::8888
nameserver 2606:4700:4700::1001
nameserver 2606:4700:4700::1111
nameserver 2001:558:feed::1
nameserver 2001:558:feed::2
nameserver 2620:119:53::53
nameserver 2620:119:35::35
""" | sudo tee -a /etc/resolv.conf
fi
	rm -rf $UNBCONF/04-forward-ipv6.conf
	echo "IPv6 connectivty found"
fi
