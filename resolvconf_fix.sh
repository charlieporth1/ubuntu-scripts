#!/bin/bash
source $PROG/all-scripts-exports.sh --no-log
CONCURRENT
DNS_FILE=/etc/resolv.conf
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
if [[ `ip_exist $DNS_SERVER` == 'true' ]]; then
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
