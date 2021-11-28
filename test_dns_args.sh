#!/bin/bash
ARGS="$@"
source ctp-dns.sh --source
export S_ONE="$1"
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(p|preload)'` ]] && export PRELOAD=true || export PRELOAD=false
[[ "$S_ONE" == "-a" ]] && export isAuto="+short"

if [[ "$PRELOAD" == 'false' ]]; then
source $PROG/all-scripts-exports.sh --no-log
CONCURRENT

export WAIT_TIME=5.5s # TO RESTART NEXT
export TIMEOUT=6 # DNS
export TRIES=3
export HOST=dns.ctptech.dev
export EDNS=174.53.130.17

export PORT=53
export A_PORT=5053
export E_PORT=853
export H_PORT=443
export Q_PORT=8853
export QH_PORT=1443

export DNS_IP=$(bash $PROG/grepify.sh $(bash $PROG/get_ext_ip.sh))
export EXTENRAL_IP=`bash $PROG/get_ext_ip.sh  --current-ip`
if [[ -z $EXTENRAL_IP ]]; then
	export EXTENRAL_IP=`bash $PROG/get_ext_ip.sh  --current-ip`
	if [[ -z $EXTENRAL_IP ]]; then
		export EXTENRAL_IP=`bash $PROG/get_ext_ip.sh  --current-ip`
		if [[ -z $EXTENRAL_IP ]]; then
			export EXTENRAL_IP=`bash $PROG/get_ext_ip.sh  --current-ip`
		fi
	fi

fi

#export ROOT_NETWORK=`bash $PROG/get_network_devices_ip_address.sh --grepify`
#export EXCLUDE_IP="$DNS_IP\|0.0.0.0\|$ROOT_NETWORK"


export local_interface="ctp-vpn.local"
export server_input="${2}"
export server="${server_input:=$local_interface}"
export qname="${3:-www.google.com}"
export qtype="${4:-A}"
export QUERY="$qname"

export DEFAULT_DNS_ARGS="+tries=$TRIES +dnssec +ttl +edns +timeout=$TIMEOUT -t $qtype -4 +retry=$TRIES +ttlunits"

if ! command -v grepip &> /dev/null
then
    echo "COMMAND grepip could not be found installing"
    curl -Ls 'https://raw.githubusercontent.com/ipinfo/cli/master/grepip/deb.sh' | bash
    exit 1
fi

if ! command -v dig &> /dev/null
then
    echo "COMMAND digcould not be found installing"
    sudo apt install -y dnsutils bind9-dnsutils
    exit 1
fi

if [[ -z $EXTENRAL_IP ]]; then
        echo "EXTENRAL_IP :$EXTENRAL_IP: null and exiting"
        exit 1
fi


dns_logger() {
	local argments="$@"
	if [[ "$server" == "$local_interface" ]] && [[ '-a' != "$S_ONE" ]]; then
 	       echo "$argments"
	fi
}

function run_fail_automation_action() {
	if [[ "$server" == "$local_interface" ]] && [[ '-a' = "$S_ONE" ]]; then
		echo 'false'
	else
		echo 'true'
	fi
}

function if_plain_dns_fail() {
	dns_local=`dig $QUERY @ctp-vpn.local +tries=$TRIES +dnssec +short +timeout=$TIMEOUT +retry=$TRIES -t A`
	dns_local_test=`echo "$dns_local" | grepip --ipv4 -o | xargs`

	if [[ -z "$dns_local_test" ]] && [[ -n "$isAuto" ]]; then
		dns_logger "DNS FAILED NOT DOH dns_local_test :$dns_local_test:"
		exit 1
	fi
}
fi
function ctp_dns_lock_file_fix_check() {
	echo "LOCK FILE $CTP_DNS_LOCK_FILE"
        echo "Creating logging and starting nginx incase nginx failed and blocklist failed to load due to webserver down and list unable to load...."
        bash $PROG/create_logging.sh
	bash $PROG/resolvconf_fix.sh
	systemctl daemon-reload
        echo "Starting NGINX now..."
        sudo systemctl start nginx.service
        echo "Starting NGINX is done"
        echo "NGINX is: $(sudo systemctl is-active nginx.service)"
        echo "Starting CTP-DNS"
        sudo systemctl start ctp-dns.service
        echo "CTP-DNS is: $(sudo systemctl is-active ctp-dns.service)"
        echo "CTP-DNS --config-test-human is"
        sudo ctp-dns --config-test-human
}
export -f ctp_dns_lock_file_fix_check

if [[ "$CONCURENT_OVERRIDE" == 'false' ]] && [[ -n "$isAuto" ]]; then
	if [[ -f $CTP_DNS_LOCK_FILE ]]; then
	        echo "LOCK FILE"
		ctp_dns_lock_file_fix_check
		exit 1
	fi
fi
