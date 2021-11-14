#!/bin/bash

ping6_exit_code_status=`ping6 -q -c 2 2001:4860:4860::8888 > /dev/null; echo $?`
echo "exit code: $ping6_exit_code_status"
if [[ $ping6_exit_code_status -gt 0 ]]; then
	echo "No ipv6 removing ipv6 files"
	rm -rf $UNBCONF/04-forward-ipv6.conf
	rm -rf $DNSMASQ/10-servers-ipv6.conf
	rm -rf $ROUTE/well-known-resolvers-dns64.toml
else
	echo "IPv6 connectivty found"
fi
