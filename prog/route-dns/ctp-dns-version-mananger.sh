#!/bin/bash
source /etc/environment
source ctp-dns.sh --source
source $PROG/all-scripts-exports.sh
if [[ -d $ALT_ROUTE/ ]]; then
	if [[ `config_test $ROUTE` ]] || ! [[ `config_test $ALT_ROUTE` ]]; then
		echo "Copying"
		cp -rf $ROUTE/{standard-group-resolvers,$HOSTNAME-resolvers,standard-resolvers,raw-resolvers}.toml $ALT_ROUTE/
	fi
fi
if [[ $HOSTNAME == "ctp-vpn" ]] && [[ -d $YT_ROUTE/ ]] && [[ `systemctl-exists ctp-YouTube-Ad-Blocker.service` == 'true' ]]; then
	if [[ `config_test $ROUTE` ]] || ! [[ `config_test $YT_ROUTE` ]]; then
		echo "Copying"
		cp -rf $ROUTE/{back-up-resolvers,root-forwarders-fast-dns-resolvers{-raw,}}.toml $YT_ROUTE/
	fi
fi
