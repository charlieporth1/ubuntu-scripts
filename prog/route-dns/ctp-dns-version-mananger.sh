#!/bin/bash
source /etc/environment
source ctp-dns.sh --source
source $PROG/all-scripts-exports.sh

if [[ -d $ALT_ROUTE/ ]]; then
	if [[ `config_test $ROUTE` == 'true' ]] || [[ `config_test $ALT_ROUTE` == 'false' ]] ; then
		echo "Copying $ALT_ROUTE"
		cp -rf $ROUTE/{standard-group-resolvers,$HOSTNAME-resolvers,standard-resolvers,raw-resolvers}.toml $ALT_ROUTE/
	fi
fi

if [[ "$HOSTNAME" == "ctp-vpn" ]] && [[ -d $YT_ROUTE/ ]] && [[ `systemctl-exists ctp-YouTube-Ad-Blocker.service` == 'true' ]]; then
	if [[ `config_test $ROUTE` == 'true' ]] || [[ `config_test $YT_ROUTE` == 'false' ]]; then
		echo "Copying $YT_ROUTE"
		cp -rf $ROUTE/{well-known-groups{,-raw},well-known-resolvers{,-raw,-retry-groups{,-raw}}}.toml $YT_ROUTE/
	fi
fi
