#!/bin/bash
source /etc/environment
shopt -s expand_aliases
SCRIPT_DIR=`realpath .`
mkdir -p /etc/letsencrypt/live/vpn.ctptech.dev

git clone https://github.com/folbricht/routedns.git
cd routedns/cmd/routedns && go install

source $SCRIPT_DIR/.project_env.sh
ROUTE=$PROG/route-dns

ln -s $SCRIPT_DIR/../prog/route-dns $PROG/
ln -s $SCRIPT_DIR/dns-route.sh $PROG/

chmod 777 $ROUTE/ctp-dns.sh
ln -s $ROUTE/ctp-dns.sh /usr/local/bin

REPLACE_IP=`$PROG/get_network_devices_ip_address.sh`
DEFAULT_IP='0.0.0.0'

LIST_DIR=/var/{cache,tmp}/ctp-dns
mkdir -p $LIST_DIR
ln -s $ROUTE/lists/ $LIST_DIR

if [[ "$IS_MASTER" == 'true' ]]; then
	LOCAL_RESOLVER_NAME='ctp-dns-local-master'
	echo "" | sudo tee $ROUTE/slave-listeners.toml
	if [[ `isNotInstalled $ROUTE/slave-resolvers.toml` == true ]]; then
		LAST_PART_OF_GROUP_END_REPLACE="\"$LOCAL_RESOLVER_NAME-tcp\", \"$LOCAL_RESOLVER_NAME-udp\""

		grep -vE '^resolvers' $ROUTE/slave-resolvers.toml > $ROUTE/slave-resolvers.toml.tmp
		mv $ROUTE/slave-resolvers.toml.tmp $ROUTE/slave-resolvers.toml

		GCP_RESOLVERS=$(bash $PROG/csvify.sh `grep -E "^.resolvers\..*gcp.*" $ROUTE/slave-resolvers.toml | awk -F'.' '{print $2}' | awk -F']' '{print $1}'` --quotes)
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
	sed -i "s/$DEFAULT_IP/$REPLACE_IP/g" $ROUTE/slave-listeners.toml
fi



