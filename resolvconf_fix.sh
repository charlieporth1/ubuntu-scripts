#!/bin/bash
source /etc/environment
source $PROG/all-scripts-exports.sh --no-log
CONCURRENT
RES_SYS_FILE=/etc/systemd/resolved.conf
RUN_FILE=/run/resolvconf/resolv.conf
RESCONF_FILE=/etc/resolv.conf
RESCONF_DIR=/etc/resolvconf/resolv.conf.d/
RESCONF_FILES=/etc/resolvconf/resolv.conf.d/*
RESCONF_HEAD=/etc/resolvconf/resolv.conf.d/head
DNS_FILE=$RESCONF_FILE


domain_to_replace_flat="google.internal c.galvanic-pulsar-284521.internal us-central1-a.c.galvanic-pulsar-284521.internal"
domain_to_replace="""us-central1-a.c.galvanic-pulsar-284521.internal
                      c.galvanic-pulsar-284521.internal
                      google.internal
"""
domains="ts local ctp internal intranet"

perl -0777 -i -pe "s/$domain_to_replace/$domains/g" $RES_SYS_FILE
perl -0777 -i -pe "s/$domain_to_replace/$domains/g" $RES_SYS_FILE

perl -0777 -i -pe "s/$domain_to_replace_flat/$domains/g" $RESCONF_FILE
perl -0777 -i -pe "s/$domain_to_replace_flat/$domains/g" $RESCONF_FILE


if ! [[ -L $DNS_FILE ]]; then
	echo NOT LINK 
fi
declare -a name_servers=(
	169.254.169.254
	192.168.44.1
	192.168.44.243
	192.168.12.1
	192.168.42.1
	8.8.8.8
	8.8.4.4
	1.1.1.1
	1.0.0.1
	100.100.100.100
	9.9.9.9
	75.75.75.75
	75.75.76.76
	208.67.220.220
	208.67.220.222
	127.0.0.53
	2001:4860:4860::8844
	2001:4860:4860::8888
	2606:4700:4700::1111
	2606:4700:4700::1001
	2001:558:feed::1
	2001:558:feed::2
	2620:119:53::53
	2620:119:35::35
)
if ! [[ -f $DNS_FILE ]]; then
	sudo rm -rf $DNS_FILE
	sudo touch $DNS_FILE
fi

DNS_SERVER=169.254.169.254
FIRST_NAME_SERVER=`grep nameserver $DNS_FILE | sed -n '1p'`
if [[ `ip_exists $DNS_SERVER` == 'true' ]]; then
	if [[ "$FIRST_NAME_SERVER" != "$DNS_SEVER" ]]; then
		sed -i "s/$FIRST_NAME_SERVER/nameserver $DNS_SERVER/g" $DNS_FILE
	fi
	[[ -z `grep -o "$DNS_SERVER" $DNS_FILE` ]] && echo "nameserver $DNS_SERVER" | sudo tee -a $DNS_FILE
elif [[ `ip_exists 192.168.44.1` == 'true' ]] && [[ `ip_exists 192.168.12.1` == 'true' ]]  ; then
	DNS_SERVER=192.168.44.1

	if [[ "$FIRST_NAME_SERVER" != "$DNS_SEVER" ]]; then
		sed -i "s/$FIRST_NAME_SERVER/nameserver $DNS_SERVER\nnameserver 192.168.12.1\nnameserver 192.168.44.243/g" $DNS_FILE
	fi
	[[ -z `grep -o "$DNS_SERVER" $DNS_FILE` ]] && echo "nameserver $DNS_SERVER" | sudo tee -a $DNS_FILE
elif [[ `ip_exists 192.168.44.1` == 'true' ]]; then
	DNS_SERVER=192.168.44.1

	if [[ "$FIRST_NAME_SERVER" != "$DNS_SEVER" ]]; then
		sed -i "s/$FIRST_NAME_SERVER/nameserver $DNS_SERVER\nnameserver 192.168.44.243/g" $DNS_FILE
	fi
	[[ -z `grep -o "$DNS_SERVER" $DNS_FILE` ]] && echo "nameserver $DNS_SERVER" | sudo tee -a $DNS_FILE
elif [[ `ip_exists 192.168.12.1` == 'true' ]]; then
	DNS_SERVER=192.168.12.1

	if [[ "$FIRST_NAME_SERVER" != "$DNS_SEVER" ]]; then
		sed -i "s/$FIRST_NAME_SERVER/nameserver $DNS_SERVER/g" $DNS_FILE
	fi
	[[ -z `grep -o "$DNS_SERVER" $DNS_FILE` ]] && echo "nameserver $DNS_SERVER" | sudo tee -a $DNS_FILE
fi

DNS_SERVER=8.8.8.8
[[ -z `grep -o "$DNS_SERVER" $DNS_FILE` ]] && echo "nameserver $DNS_SERVER" | sudo tee -a $DNS_FILE
DNS_SERVER=8.8.4.4
[[ -z `grep -o "$DNS_SERVER" $DNS_FILE` ]] && echo "nameserver $DNS_SERVER" | sudo tee -a $DNS_FILE

for nameserver in ${name_servers[@]}
do
	DNS_SERVER=$nameserver
	if [[ `ip_exist $DNS_SERVER` == 'true' ]]; then
		if [[ -z `grep -o "$DNS_SERVER" $DNS_FILE` ]]; then
			echo "nameserver $DNS_SERVER" | sudo tee -a $DNS_FILE
		fi
	fi
done

cat $DNS_FILE | sort | sort -u > $DNS_FILE.tmp
if [[ -n `cat $DNS_FILE.tmp` ]]; then
	sudo mv $DNS_FILE.tmp $DNS_FILE
fi

