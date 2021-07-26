#!/bin/bash
source /etc/environment
shopt -s expand_aliases

SCRIPT_DIR=`realpath .`
mkdir -p /etc/letsencrypt/live/vpn.ctptech.dev
round() {
    printf "%.${2:-0}f" "$1"
}
CPU_CORE_COUNT=`cat /proc/stat | grep cpu | grep -E 'cpu[0-9]+' | wc -l`
MEM_COUNT=$(round `grep MemTotal /proc/meminfo | awk '{print $2 / 1024}'` 0)

#/snap/bin/go get -v github.com/folbricht/routedns/cmd/routedns

#git clone https://github.com/folbricht/routedns.git
#cd routedns
#git stash
#git pull -ff
#git switch master
#git pull -ff
#cd cmd/routedns
#sudo /snap/bin/go install
#cd -

source $SCRIPT_DIR/.project_env.sh
ROUTE=$PROG/route-dns
ROOT_ROUTE=$CONF_PROG_DIR/route-dns
sudo ln -s $ROOT_ROUTE $ROUTE
        if [ -d $ROOT_ROUTE ]; then
          for i in $ROOT_ROUTE/*.toml; do
            if [ -r $i ]; then
              ln -s $i $ROUTE/
            fi
          done
          unset i
        fi

REPLACE_IP=`bash $PROG/get_network_devices_ip_address.sh`
DEFAULT_IP='0.0.0.0'


GCP_RESOLVERS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(grep -E "^.resolvers\..*gcp.*" $ROUTE/standard-resolvers.toml | awk -F. '{print $2}' | awk -F] '{print $1}') --quotes --space))
GCP_HOME_RESOLVERS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(grep -E "^.resolvers\..*(gcp|home).*" $ROUTE/standard-resolvers.toml | awk -F. '{print $2}' | awk -F] '{print $1}') --quotes --space))
RAW_RESOLVERS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(grep -E "^.resolvers\..*(gcp|home|aws).*" $ROUTE/raw-resolvers.toml | awk -F. '{print $2}' | awk -F] '{print $1}') --quotes --space))

LOCAL_RESOLVER_NAME='ctp-dns-local-master'

grep_around_str='^\[groups.ctp-dns-fail-rotate\](.|\n)*\n^\]'

#leftover_fail_rotate_str='type = \"fail-rotate\"'
leftover_fail_rotate_str=""
replace_str_front="\[groups.ctp-dns-fail-rotate\]\nresolvers = \[\n"
replace_str_back=",\n$RAW_RESOLVERS\n\]\n$leftover_fail_rotate_str"

IS_SOLID_HOST=`checkIsNotInstalled $ROUTE/$HOSTNAME-resolvers.toml`
# MASTER
if [[ "$IS_MASTER" == 'true' ]] && [[ $IS_SOLID_HOST == 'true' ]]; then

echo """
[resolvers.$LOCAL_RESOLVER_NAME-tcp]
address = \"$REPLACE_IP:53\"
protocol = \"tcp\"
[resolvers.$LOCAL_RESOLVER_NAME-udp]
address = \"$REPLACE_IP:53\"
protocol = \"udp\"
""" | sudo tee $ROUTE/$HOSTNAME-resolvers.toml

elif [[ $IS_SOLID_HOST == 'true' ]]; then
	echo "" | sudo tee $ROUTE/$HOSTNAME-resolvers.toml
fi

# AWS
second_subnet_master_ip=`ip_exists 192.168.99.9`
default_subnet_master_ip=`ip_exists 10.128.0.9`
if { [[ "$second_subnet_master_ip" = 'true' ]] || [[ "$default_subnet_master_ip" = 'true' ]]; } && [[ $IS_SOLID_HOST == 'true' ]];  then
	DOMAIN='gcp.ctptech.dev'
	TUNNEL_STR='gcp-tunnel'
	if [[ "$second_subnet_master_ip" = 'true' ]]; then
		IP='192.168.99.9'
	elif [[ "$default_subnet_master_ip" = 'true' ]]; then
		IP='10.128.0.9'
	else
		IP='10.128.0.9'
	fi

	echo "Using IP $IP Tunnel $TUNNEL_STR domain $DOMAIN"

echo """
[resolvers.$LOCAL_RESOLVER_NAME-$TUNNEL_STR-tcp]
address = \"$IP:53\"
protocol = \"tcp\"
[resolvers.$LOCAL_RESOLVER_NAME-$TUNNEL_STR-udp]
address = \"$IP:53\"
protocol = \"udp\"
[resolvers.$LOCAL_RESOLVER_NAME-$TUNNEL_STR-dot]
address = \"$DOMAIN:853\"
protocol = \"dot\"
bootstrap-address = \"$IP\"
[resolvers.$LOCAL_RESOLVER_NAME-$TUNNEL_STR-dtls]
address = \"$DOMAIN:853\"
protocol = \"dtls\"
bootstrap-address = \"$IP\"
[resolvers.$LOCAL_RESOLVER_NAME-$TUNNEL_STR-doq]
address = \"$DOMAIN:784\"
protocol = \"doq\"
bootstrap-address = \"$IP\"
[resolvers.$LOCAL_RESOLVER_NAME-$TUNNEL_STR-doh-doq]
address = \"$DOMAIN:1443\"
protocol = \"doh\"
transport = \"quic\"
bootstrap-address = \"$IP\"
""" | sudo tee -a $ROUTE/$HOSTNAME-resolvers.toml

fi

LOCAL_RESOLVERS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(grep -E "^.resolvers\.$LOCAL_RESOLVER_NAME.*" $ROUTE/$HOSTNAME-resolvers.toml | awk -F'.' '{print $2}' | awk -F']' '{print $1}') --quotes --space))

if [[ "$IS_AWS" == 'true' ]] || [[ "$IS_MASTER" == 'false' ]]; then
	replace_str="$replace_str_front$LOCAL_RESOLVERS,\n$GCP_HOME_RESOLVERS$replace_str_back"
else
	replace_str="$replace_str_front$LOCAL_RESOLVERS,\n$GCP_RESOLVERS$replace_str_back"
fi

############### Replace failover
if [[ `isNotInstalled $ROUTE/route-dns.toml` == 'true' ]]; then
	FILE=route-dns.toml
	fail_over_str=`pcregrep -M "$grep_around_str" $ROUTE/$FILE` #> $ROUTE/$FILE.tmp

	fail_over_str="${fail_over_str//[/\\[}"
	fail_over_str="${fail_over_str//]/\\]}"

	perl -0777 -i -pe "s/$fail_over_str/$replace_str/g" $ROUTE/$FILE
	perl -0777 -i -pe 's/^"ctp/\t"ctp/gm' $ROUTE/$FILE

#	perl -0777 -i -pe "s/$fail_over_str/$replace_str/g" $ROUTE/$FILE.tmp
#	perl -0777 -i -pe "s/$leftover_fail_rotate_str/$replace_str/g" $ROUTE/$FILE.tmp
#	perl -0777 -i -pe 's/^"ctp/\t"ctp/gm' $ROUTE/$FILE.tmp
#	mv $ROUTE/$FILE.tmp $ROUTE/$FILE.toml

fi

# MASTER
if [[ "$IS_MASTER" == 'true' ]] ; then

	[[ "$IS_AWS" == 'true' ]] && BOOLEAN_LOGIC_RESOLVERS="$GCP_HOME_RESOLVERS" || BOOLEAN_LOGIC_RESOLVERS="$GCP_RESOLVERS"

	echo "" | sudo tee $ROUTE/slave-listeners.toml
	if [[ $IS_SOLID_HOST == 'true' ]]; then

echo """
[groups.ctp-dns-group]
resolvers = [
	$BOOLEAN_LOGIC_RESOLVERS,
	$LOCAL_RESOLVERS,
]
type = \"fastest\"

[groups.ctp-dns-group-local]
resolvers = [
	$LOCAL_RESOLVERS,
]
type = \"fastest\"
""" | sudo tee -a $ROUTE/$HOSTNAME-resolvers.toml
	fi
# ELSE . SLAVE
else
	if [[ $IS_SOLID_HOST == 'true' ]]; then

echo """
[groups.ctp-dns-group]
resolvers = [
	$GCP_HOME_RESOLVERS,
]
type = \"fastest\"

[groups.ctp-dns-group-local]
resolvers = [
	\"ctp-dns-group\",
]
type = \"fastest\"
""" | sudo tee -a $ROUTE/$HOSTNAME-resolvers.toml
	fi
	sed -i "s/$DEFAULT_IP/$REPLACE_IP/g" $ROUTE/slave-listeners.toml

	if [[ $CPU_CORE_COUNT -le 2 ]] || [[ $MEM_COUNT -le 750 ]] ; then
		replace_str="resolvers = [ \"ctp-dns-failover\" ]"
		FILE=dns-lists.toml
		pcregrep -v -M '^resolvers.*(.|\n)*]' $ROUTE/$FILE > $ROUTE/$FILE.tmp
		echo -e "$replace_str" | sudo tee -a $ROUTE/$FILE.tmp
		mv $ROUTE/$FILE.tmp $ROUTE/$FILE
	fi
fi

replace_str="resolvers = [\n$GCP_RESOLVERS\n]"
FILE=ctp-yt-dns-router.toml
if [[ `isNotInstalled $ROUTE/$FILE` == 'true' ]]; then
	pcregrep -v -M '^resolvers.*(.|\n)*]' $ROUTE/$FILE > $ROUTE/$FILE.tmp

	echo -e "$replace_str" | sudo tee -a $ROUTE/$FILE.tmp
	perl -0777 -i -pe 's/^"ctp/\t"ctp/gm' $ROUTE/$FILE.tmp
	mv $ROUTE/$FILE.tmp $ROUTE/$FILE
fi

FILE=ctp-yt-googlevideo-ttl-modifier.toml
#replace_str="resolvers = [ \"ctp-dns-time-router-yt-ttl-gcp\" ]"
#if [[ `isNotInstalled $ROUTE/$FILE` == 'true' ]]; then
#	pcregrep -v -M '^resolvers.*' $ROUTE/$FILE > $ROUTE/$FILE.tmp
#	mv $ROUTE/$FILE.tmp $ROUTE/$FILE
#	echo -e "$replace_str" | sudo tee -a $ROUTE/$FILE
#fi

replace_str="resolvers = [ \"ctp-dns-time-router-general-gcp\" ]"
FILE=dns-lists.toml
if [[ `isNotInstalled $ROUTE/$FILE` == 'true' ]]; then
	pcregrep -v -M '^resolvers.*' $ROUTE/$FILE > $ROUTE/$FILE.tmp
	mv $ROUTE/$FILE.tmp $ROUTE/$FILE
	echo -e "$replace_str" | sudo tee -a $ROUTE/$FILE
fi

# SOLID
if [[ `isNotInstalled $ROUTE/$HOSTNAME-resolvers.toml` == 'true' ]]; then
	perl -0777 -i -pe 's/^"ctp/\t"ctp/gm' $ROUTE/$HOSTNAME-resolvers.toml
	echo "# NO CHANGES" | sudo tee -a $ROUTE/$HOSTNAME-resolvers.toml
fi
perl -0777 -i -pe 's/^"ctp/\t"ctp/gm' $ROUTE/$HOSTNAME-resolvers.toml
