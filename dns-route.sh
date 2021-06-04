#!/bin/bash
source /etc/environment
shopt -s expand_aliases
SCRIPT_DIR=`realpath .`
mkdir -p /etc/letsencrypt/live/vpn.ctptech.dev

git clone https://github.com/folbricht/routedns.git
cd routedns
git stash
git pull -ff
git switch update-dtls
cd cmd/routedns
sudo /snap/bin/go install

go get -v github.com/folbricht/routedns/cmd/routedns
source $SCRIPT_DIR/.project_env.sh
ROUTE=$PROG/route-dns

REPLACE_IP=`bash $PROG/get_network_devices_ip_address.sh`
DEFAULT_IP='0.0.0.0'


GCP_RESOLVERS=$(bash $PROG/csvify.sh `grep -E "^.resolvers\..*gcp.*" $ROUTE/slave-resolvers.toml | awk -F'.' '{print $2}' | awk -F']' '{print $1}'` --quotes)
LOCAL_RESOLVER_NAME='ctp-dns-local-master'
if [[ "$IS_MASTER" == 'true' ]]; then
	echo "" | sudo tee $ROUTE/slave-listeners.toml
	if [[ `isNotInstalled $ROUTE/slave-resolvers.toml` == 'true' ]]; then
		LAST_PART_OF_GROUP_END_REPLACE="\"$LOCAL_RESOLVER_NAME-tcp\", \"$LOCAL_RESOLVER_NAME-udp\""

		grep -vE '^resolvers' $ROUTE/slave-resolvers.toml > $ROUTE/slave-resolvers.toml.tmp
		mv $ROUTE/slave-resolvers.toml.tmp $ROUTE/slave-resolvers.toml

		echo "resolvers = [ $LAST_PART_OF_GROUP_END_REPLACE, $GCP_RESOLVERS ]" | sudo tee -a $ROUTE/slave-resolvers.toml
#		LAST_PART_OF_GROUP_END='"ctp-dns-master-doh-get", "ctp-dns-master-doh-quic"'
#		sed -i "s/$LAST_PART_OF_GROUP_END/$LAST_PART_OF_GROUP_END_REPLACE/g" $ROUTE/slave-resolvers.toml

echo """
[resolvers.$LOCAL_RESOLVER_NAME-tcp]
address = \"$REPLACE_IP:53\"
protocol = \"tcp\"
[resolvers.$LOCAL_RESOLVER_NAME-udp]
address = \"$REPLACE_IP:53\"
protocol = \"udp\"
""" | sudo tee -a $ROUTE/slave-resolvers.toml


	fi
else
	export IS_AWS=$([[ `timeout 5 curl -s http://169.254.169.254/latest/meta-data/hostname | grep -o 'ec2.internal'` ]] && echo true || echo false)
	if [[ "$IS_AWS" == true ]]; then
		if [[ `isNotInstalled $ROUTE/slave-resolvers.toml` == 'true' ]]; then

			LAST_PART_OF_GROUP_END_REPLACE="\"$LOCAL_RESOLVER_NAME-tunnel-tcp\", \"$LOCAL_RESOLVER_NAME-tunnel-udp\", \"$LOCAL_RESOLVER_NAME-tunnel-dot\", \"$LOCAL_RESOLVER_NAME-tunnel-dtls\""

			grep -vE '^resolvers' $ROUTE/slave-resolvers.toml > $ROUTE/slave-resolvers.toml.tmp
			mv $ROUTE/slave-resolvers.toml.tmp $ROUTE/slave-resolvers.toml

			echo "resolvers = [ $LAST_PART_OF_GROUP_END_REPLACE, $GCP_RESOLVERS ]" | sudo tee -a $ROUTE/slave-resolvers.toml
			DOMAIN='gcp.ctptech.dev'
			IP='10.128.0.9'
echo """
[resolvers.$LOCAL_RESOLVER_NAME-tunnel-tcp]
address = \"$IP:53\"
protocol = \"tcp\"
[resolvers.$LOCAL_RESOLVER_NAME-tunnel-udp]
address = \"$IP:53\"
protocol = \"udp\"
[resolvers.$LOCAL_RESOLVER_NAME-tunnel-dot]
address = \"$DOMAIN:853\"
protocol = \"dot\"
bootstrap-address = \"$IP\"
[resolvers.$LOCAL_RESOLVER_NAME-tunnel-dtls]
address = \"gcp.ctptech.dev:853\"
protocol = \"dtls\"
bootstrap-address = \"$IP\"
""" | sudo tee -a $ROUTE/slave-resolvers.toml

		fi
	fi
	sed -i "s/$DEFAULT_IP/$REPLACE_IP/g" $ROUTE/slave-listeners.toml
fi

if [[ `isNotInstalled $ROUTE/ctp-yt-dns-router.toml` == 'true' ]]; then
	yt_resolvers='resolvers = [  "ctp-dns-gcp-dtls", "ctp-dns-gcp-dot", "ctp-dns-master-doh-gcp-quic", "ctp-dns-master-gcp-quic", "ctp-dns-master-doh-gcp-post", "ctp-dns-master-doh-gcp-get" ]'
	grep -vE '^resolvers' $ROUTE/ctp-yt-dns-router.toml > $ROUTE/ctp-yt-dns-router.toml.tmp
	mv $ROUTE/ctp-yt-dns-router.toml.tmp $ROUTE/ctp-yt-dns-router.toml
	echo "$yt_resolvers" | sudo tee -a $ROUTE/ctp-yt-dns-router.toml
fi

