#!/bin/bash
source /etc/environment
shopt -s expand_aliases

SCRIPT_DIR=`realpath .`
mkdir -p /etc/letsencrypt/live/vpn.ctptech.dev

go get -v github.com/folbricht/routedns/cmd/routedns

git clone https://github.com/folbricht/routedns.git
cd routedns
git stash
git pull -ff
git switch master
git pull -ff
cd cmd/routedns
sudo /snap/bin/go install

source $SCRIPT_DIR/.project_env.sh
ROUTE=$PROG/route-dns

REPLACE_IP=`bash $PROG/get_network_devices_ip_address.sh`
DEFAULT_IP='0.0.0.0'


GCP_RESOLVERS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(grep -E "^.resolvers\..*gcp.*" $ROUTE/standard-resolvers.toml | awk -F. '{print $2}' | awk -F] '{print $1}') --quotes --space))
GCP_HOME_RESOLVERS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(grep -E "^.resolvers\..*(gcp|home).*" $ROUTE/standard-resolvers.toml | awk -F. '{print $2}' | awk -F] '{print $1}') --quotes --space))
RAW_RESOLVERS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(grep -E "^.resolvers\..*(gcp|home).*" $ROUTE/raw-resolvers.toml | awk -F. '{print $2}' | awk -F] '{print $1}') --quotes --space))

LOCAL_RESOLVER_NAME='ctp-dns-local-master'

grep_around_str='^\[groups.ctp-dns-fail-rotate\](.|\n)*\n^\]'

leftover_fail_rotate_str='type = \"fail-rotate\"'
replace_str_front="\[groups.ctp-dns-fail-rotate\]\nresolvers = \[\n"
replace_str_back="\n,$RAW_RESOLVERS\n\]\n$leftover_fail_rotate_str"
if [[ "$IS_MASTER" == 'true' ]]; then
	echo "" | sudo tee $ROUTE/slave-listeners.toml

printf '%s\n' """
[resolvers.$LOCAL_RESOLVER_NAME-tcp]
address = \"$REPLACE_IP:53\"
protocol = \"tcp\"
[resolvers.$LOCAL_RESOLVER_NAME-udp]
address = \"$REPLACE_IP:53\"
protocol = \"udp\"
""" | sudo tee $ROUTE/$HOSTNAME-resolvers.toml

	LOCAL_RESOLVERS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(grep -E '^.resolvers\..*' $ROUTE/$HOSTNAME-resolvers.toml | awk -F'.' '{print $2}' | awk -F']' '{print $1}') --quotes --space))
GROUP="""
[groups.ctp-dns-group]
resolvers = [
	$LOCAL_RESOLVERS,
	$GCP_RESOLVERS
]
type = \"fastest\"
"""
printf '%s\n' "$GROUP" | sudo tee -a $ROUTE/$HOSTNAME-resolvers.toml

	if [[ `isNotInstalled $ROUTE/route-dns.toml` == 'true' ]]; then
		replace_str="$replace_str_front$LOCAL_RESOLVERS,\n$GCP_RESOLVERS$replace_str_back"
		FILE=route-dns.toml
		pcregrep -v -M "$grep_around_str" $ROUTE/$FILE > $ROUTE/$FILE.tmp

		perl -0777 -i -pe "s/$leftover_fail_rotate_str/$replace_str/g" $ROUTE/$FILE.tmp
		perl -0777 -i -pe 's/^"ctp/\t"ctp/gm' $ROUTE/$FILE.tmp
		mv $ROUTE/$FILE.tmp $ROUTE/$FILE.toml
	fi

else
#########
# NON SLAVE
	export IS_AWS=$( [[ `timeout 5 curl -s http://169.254.169.254/latest/meta-data/hostname | grep -o 'ec2.internal'` ]] && echo true || echo false )

	if [[ "$IS_AWS" == 'true' ]]; then

		DOMAIN='gcp.ctptech.dev'
		IP='10.128.0.9'
echo """
[resolvers.$LOCAL_RESOLVER_NAME-gcp-tunnel-tcp]
address = \"$IP:53\"
protocol = \"tcp\"
[resolvers.$LOCAL_RESOLVER_NAME-gcp-tunnel-udp]
address = \"$IP:53\"
protocol = \"udp\"
[resolvers.$LOCAL_RESOLVER_NAME-gcp-tunnel-dot]
address = \"$DOMAIN:853\"
protocol = \"dot\"
bootstrap-address = \"$IP\"
[resolvers.$LOCAL_RESOLVER_NAME-gcp-tunnel-dtls]
address = \"gcp.ctptech.dev:853\"
protocol = \"dtls\"
bootstrap-address = \"$IP\"
[resolvers.$LOCAL_RESOLVER_NAME-gcp-tunnel-doq]
address = \"gcp.ctptech.dev:784\"
protocol = \"doq\"
bootstrap-address = \"$IP\"
[resolvers.$LOCAL_RESOLVER_NAME-gcp-tunnel-doh-doq]
address = \"gcp.ctptech.dev:1443\"
protocol = \"doh\"
transport = \"quic\"
bootstrap-address = \"$IP\"
""" | sudo tee $ROUTE/$HOSTNAME-resolvers.toml

	LOCAL_RESOLVERS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(grep -E '^.resolvers\..*' $ROUTE/$HOSTNAME-resolvers.toml | awk -F'.' '{print $2}' | awk -F']' '{print $1}') --quotes --space))

GROUP="""
[groups.ctp-dns-group]
resolvers = [
	$LOCAL_RESOLVERS,
	$GCP_HOME_RESOLVERS

]
type = \"fastest\"
"""
printf '%s\n' "$GROUP" | sudo tee -a $ROUTE/$HOSTNAME-resolvers.toml

	else
 	########### Non AWS
 	# TODO more of the end of this fi and below
GROUP="""
[groups.ctp-dns-group]
resolvers = [
	$GCP_HOME_RESOLVERS
]
type = \"fastest\"
"""
printf '%s\n' "$GROUP" sudo tee $ROUTE/$HOSTNAME-resolvers.toml

	fi

	LOCAL_RESOLVERS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(grep -E '^.resolvers\..*' $ROUTE/$HOSTNAME-resolvers.toml | awk -F'.' '{print $2}' | awk -F']' '{print $1}') --quotes --space))

	if [[ `isNotInstalled $ROUTE/route-dns.toml` == 'true' ]]; then
		replace_str="$replace_str_front$LOCAL_RESOLVERS\n,$GCP_HOME_RESOLVERS$replace_str_back"
		FILE=route-dns.toml
		pcregrep -v -M "$grep_around_str" $ROUTE/$FILE > $ROUTE/$FILE.tmp
		perl -0777 -i -pe "s/$leftover_fail_rotate_str/$replace_str/g" $ROUTE/$FILE.tmp
		perl -0777 -i -pe 's/^"ctp/\t"ctp/gm' $ROUTE/$FILE.tmp
		mv $ROUTE/$FILE.tmp $ROUTE/$FILE.toml
	fi

	sed -i "s/$DEFAULT_IP/$REPLACE_IP/g" $ROUTE/slave-listeners.toml
fi

replace_str="resolvers = [\n$GCP_RESOLVERS\n]"
if [[ `isNotInstalled $ROUTE/ctp-yt-dns-router.toml` == 'true' ]]; then
	FILE=ctp-yt-dns-router.toml
	pcregrep -v -M '^resolvers.*(.|\n)*]' $ROUTE/$FILE > $ROUTE/$FILE.tmp

	echo -e "$replace_str" | sudo tee -a $ROUTE/$FILE.tmp
	perl -0777 -i -pe 's/^"ctp/\t"ctp/gm' $ROUTE/$FILE.tmp
	mv $ROUTE/$FILE.tmp $ROUTE/$FILE
fi

if [[ `isNotInstalled $ROUTE/ctp-yt-googlevideo-router.toml` == 'true' ]]; then
	FILE=ctp-yt-googlevideo-tll-modifier.toml
	pcregrep -v -M '^resolvers.*(.|\n)*]' $ROUTE/$FILE > $ROUTE/$FILE.tmp
	mv $ROUTE/$FILE.tmp $ROUTE/$FILE
	echo -e "$replace_str" | sudo tee -a $ROUTE/$FILE
	perl -0777 -i -pe 's/^"ctp/\t"ctp/gm' $ROUTE/$FILE
fi



