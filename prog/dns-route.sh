#!/bin/bash
source /etc/environment
shopt -s expand_aliases
source $PROG/generate_ctp-dns-envs.sh
system_information

SCRIPT_DIR=`realpath .`
mkdir -p /etc/letsencrypt/live/vpn.ctptech.dev

#/snap/bin/go get -v github.com/folbricht/eroutedns/cmd/routedns

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


IS_SOLID_HOST="checkIsNotInstalled $ROUTE/$HOSTNAME-resolvers.toml"

# MASTER
if [[ "$IS_MASTER" == 'true' ]] && [[ "`$IS_SOLID_HOST`" == 'true' ]]; then

echo """
[resolvers.$LOCAL_RESOLVER_NAME-tcp]
address = \"$REPLACE_IP:53\"
protocol = \"tcp\"
[resolvers.$LOCAL_RESOLVER_NAME-udp]
address = \"$REPLACE_IP:53\"
protocol = \"udp\"
edns0-udp-size = 1460

[groups.$LOCAL_RESOLVER_NAME-truncate-retry]
type = \"truncate-retry\"
resolvers = [ \"$LOCAL_RESOLVER_NAME-udp\" ]
retry-resolver = \"$LOCAL_RESOLVER_NAME-tcp\"

""" | sudo tee $ROUTE/$HOSTNAME-resolvers.toml


echo "" | sudo tee $ROUTE/slave-listeners{,-udp-retry-resolvers}.toml

elif [[ "`$IS_SOLID_HOST`" == 'true' ]]; then
	echo "" | sudo tee $ROUTE/$HOSTNAME-resolvers.toml
fi

current_ip=`sudo ip addr show tailscale0 | grepip -4o`
if [[ "`$IS_SOLID_HOST`" == 'true' ]]; then
	declare -a ip_list
#		'100.86.69.129'
#		'100.71.239.28'
#		'100.120.180.109'
	ip_list=(
		'192.168.99.9'
		'10.128.0.9'
	)
	for ip in "${ip_list[@]}"
	do

		local_ip_exists=`ip_exists $ip`
		if [[ "$local_ip_exists" == 'true' ]] && [[ "`$IS_SOLID_HOST`" == 'true' ]] && [[ "$current_ip" != "$ip" ]] ; then
			ip_title="${ip//\./-}"
			DOMAIN='dns.ctptech.dev'
			TUNNEL_STR='gcp-or-vpn-tunnel'
			IP="$ip"
			service_name_str="$TUNNEL_STR-$ip_title"

			echo "Using IP $IP Tunnel $TUNNEL_STR domain $DOMAIN service_name_str $service_name_str"

echo """
# DNS
[resolvers.$LOCAL_RESOLVER_NAME-$service_name_str-tcp]
address = \"$IP:53\"
protocol = \"tcp\"
[resolvers.$LOCAL_RESOLVER_NAME-$service_name_str-udp]
address = \"$IP:53\"
protocol = \"udp\"
edns0-udp-size = 1460

[resolvers.$service_name_str-tcp]
address = \"$IP:53\"
protocol = \"tcp\"
[resolvers.$service_name_str-udp]
address = \"$IP:53\"
protocol = \"udp\"
edns0-udp-size = 1460

# DoT
[resolvers.$service_name_str-dot]
address = \"$DOMAIN:853\"
protocol = \"dot\"
bootstrap-address = \"$IP\"

# DTLS
[resolvers.$service_name_str-dtls]
address = \"$DOMAIN:853\"
protocol = \"dtls\"
bootstrap-address = \"$IP\"
edns0-udp-size = 1460


# GROUPS
[groups.$service_name_str-truncate-retry-raw]
type = \"truncate-retry\"
resolvers = [ \"$service_name_str-udp\" ]
retry-resolver = \"$service_name_str-tcp\"

[groups.$LOCAL_RESOLVER_NAME-$service_name_str-truncate-retry-raw]
type = \"truncate-retry\"
resolvers = [ \"$service_name_str-udp\" ]
retry-resolver = \"$service_name_str-tcp\"

[groups.$service_name_str-truncate-retry-encrypted]
type = \"truncate-retry\"
resolvers = [ \"$service_name_str-dtls\" ]
retry-resolver = \"$service_name_str-dot\"


""" | sudo tee -a $ROUTE/$HOSTNAME-resolvers.toml
		fi
	done
fi

LOCAL_RESOLVERS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(grep -E "^.resolvers\.$LOCAL_RESOLVER_NAME.*" $ROUTE/$HOSTNAME-resolvers.toml | awk -F'.' '{print $2}' | awk -F']' '{print $1}') \
	 --quotes --space))

leftover_fail_rotate_str=""
NGINX_fail_back_group=",\n\"$RESOLVER_START_GROUP-fail-back\",\n"
replace_str_front="\[groups.ctp-dns-fail-rotate\]\nresolvers = \[\n"
replace_str_back="\n$LOCAL_RESOLVERS$NGINX_fail_back_group\"ctp-dns_group-fail-rotate-raw\",\n\]\n$leftover_fail_rotate_str"


if [[ "$HOSTNAME" = "ip-172-31-12-154" ]]; then
	replace_str="$replace_str_front\"ctp-dns_group-fastest-gcp-external\",\n\"ctp-dns_group-fastest-home-external\",\n\"ctp-dns_group-fail-rotate-gcp\",\n\"ctp-dns_group-fail-rotate-home\",\n\"ctp-dns_group-fail-back-gcp\",\n\"ctp-dns_group-fail-back-home\",$replace_str_back"
elif [[ "$HOSTNAME" = "ubuntu-server" ]]; then
	replace_str="$replace_str_front\"ctp-dns_group-fastest-gcp-external\",\n\"ctp-dns_group-fastest-aws-external\",\n\"ctp-dns_group-fail-rotate-gcp\",\n\"ctp-dns_group-fail-rotate-aws\",\n\"ctp-dns_group-fail-back-gcp\",\n\"ctp-dns_group-fail-back-aws\",$replace_str_back"
else
	replace_str="$replace_str_front\"ctp-dns_group-fastest-masters\",\n\"ctp-dns_group-rotate-masters\"\n\"ctp-dns_group-fail-back-masters,$replace_str_back"
fi

############### Replace failover
if [[ `isNotInstalled $ROUTE/route-dns.toml` == 'true' ]]; then
	FILE=route-dns.toml
	grep_around_str='^\[groups.ctp-dns-fail-rotate\](.|\n)*\n^\]'
	fail_over_str=`pcregrep -M "$grep_around_str" $ROUTE/$FILE`

	fail_over_str="${fail_over_str//[/\\[}"
	fail_over_str="${fail_over_str//]/\\]}"

	perl -0777 -i -pe "s/$fail_over_str/$replace_str/g" $ROUTE/$FILE
	perl -0777 -i -pe 's/^"ctp/\t"ctp/gm' $ROUTE/$FILE


fi

# MASTER
if [[ "$IS_MASTER" == 'true' ]] ; then

	[[ "$IS_AWS" == 'true' ]] && BOOLEAN_LOGIC_RESOLVERS="$GCP_RESOLVERS,$HOME_RESOLVERS" || BOOLEAN_LOGIC_RESOLVERS="$GCP_RESOLVERS"

	echo "" | sudo tee $ROUTE/slave-listeners.toml

	if [[ "`$IS_SOLID_HOST`" == 'true' ]]; then

echo """
[groups.ctp-dns-group]
resolvers = [
	$LOCAL_RESOLVERS,
	$GCP_RESOLVERS,
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

	if [[ "`$IS_SOLID_HOST`" == 'true' ]]; then

echo """
[groups.ctp-dns-group]
resolvers = [
	$ALL_RESOLVERS,
	\"ctp-dns_nginx-back-up-group-fastest\",
	$RAW_RESOLVERS,
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

	if [[ $CPU_CORE_COUNT -lt 2 ]] || [[ $MEM_COUNT -lt 750 ]] ; then
		FILE=dns-lists.toml

		replace_str="resolvers = [ \"ctp-dns-fail-back\" ]"
		str_to_replace=`pcregrep -M '^resolvers.*' $ROUTE/$FILE`
		str_to_replace=${str_to_replace//]/\\]}
		str_to_replace=${str_to_replace//[/\\[}
		replace_str=${replace_str//]/\\]}
		replace_str=${replace_str//[/\\[}
		sed -i "s/$str_to_replace/$replace_str/g" $ROUTE/$FILE

		echo "" | sudo tee -a $ROUTE/dns-lists-local.toml
		unset FILE
	fi
fi

replace_str="resolvers = [\n$GCP_RESOLVERS\n]"
FILE=ctp-yt-dns-router.toml
if [[ `isNotInstalled $ROUTE/$FILE` == 'true' ]]; then
#	pcregrep -M '^resolvers.*(.|\n)*]' $ROUTE/$FILE > $ROUTE/$FILE.tmp
#	echo -e "$replace_str" | sudo tee -a $ROUTE/$FILE.tmp
	str_to_replace=`pcregrep -M '^resolvers.*' $ROUTE/$FILE`
	str_to_replace=${str_to_replace//]/\\]}
	str_to_replace=${str_to_replace//[/\\[}
	replace_str=${replace_str//]/\\]}
	replace_str=${replace_str//[/\\[}

	perl -0777 -i -pe "s/$str_to_replace/$replace_str/g" $ROUTE/$FILE
	perl -0777 -i -pe 's/^"ctp/\t"ctp/gm' $ROUTE/$FILE

#	mv $ROUTE/$FILE.tmp $ROUTE/$FILE
fi

FILE=ctp-yt-googlevideo-ttl-modifier.toml
#replace_str="resolvers = [ \"ctp-dns-time-router-yt-ttl-gcp\" ]"
#if [[ `isNotInstalled $ROUTE/$FILE` == 'true' ]]; then
#	pcregrep -v -M '^resolvers.*' $ROUTE/$FILE > $ROUTE/$FILE.tmp
#	mv $ROUTE/$FILE.tmp $ROUTE/$FILE
#	echo -e "$replace_str" | sudo tee -a $ROUTE/$FILE
#fi

#FILE=dns-lists.toml
#if [[ `isNotInstalled $ROUTE/$FILE` == 'true' ]]; then
#	pcregrep -v -M '^resolvers.*' $ROUTE/$FILE > $ROUTE/$FILE.tmp
#	mv $ROUTE/$FILE.tmp $ROUTE/$FILE
#	echo -e "$replace_str" | sudo tee -a $ROUTE/$FILE
#fi

replace_str="resolvers = [ \"ctp-dns-time-router-general-gcp\" ]"
# SOLID
if [[ `isNotInstalled $ROUTE/$HOSTNAME-resolvers.toml` == 'true' ]]; then
	perl -0777 -i -pe 's/^"ctp/\t"ctp/gm' $ROUTE/$HOSTNAME-resolvers.toml
	echo "# NO CHANGES" | sudo tee -a $ROUTE/$HOSTNAME-resolvers.toml
fi

cp -rf $ROUTE/{standard-group-resolvers,$HOSTNAME-resolvers,standard-resolvers,raw-resolvers}.toml $ALT_ROUTE/

sudo chmod 777 /usr/local/bin/ctp-dns{,.sh}
ctp-dns --config-test-human

format_file $ROUTE/*.toml
