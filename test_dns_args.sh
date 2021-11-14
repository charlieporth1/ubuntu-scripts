#!/bin/bash
ARGS="$@"
source ctp-dns.sh --source
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(p|preload)'` ]] && export PRELOAD=true || export PRELOAD=false
[[ "$1" == "-a" ]] && export isAuto="+short"

if [[ "$PRELOAD" == 'false' ]]; then
source $PROG/all-scripts-exports.sh --no-log
CONCURRENT

export WAIT_TIME=5.5s # TO RESTART NEXT
export TIMEOUT=16 # DNS
export TRIES=4
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
#export ROOT_NETWORK=`bash $PROG/get_network_devices_ip_address.sh --grepify`
#export EXCLUDE_IP="$DNS_IP\|0.0.0.0\|$ROOT_NETWORK"


export local_interface=ctp-vpn.local
export server_input=${2}
export server=${server_input:=$local_interface}
export qname=${3:-www.google.com}
export qtype=${4:-A}
export QUERY=$qname

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
	if [[ "$server" == "$local_interface" ]] || [[ '-a' != "$1" ]]; then
 	       echo "$argments"
	fi
}

function run_fail_automation_action() {
	[[ "$server" == "$local_interface" ]] && [[ '-a' = "$1" ]] && echo "false"
}

function if_plain_dns_fail() {
	if [[ -z "$dns_local_test" ]] && [[ -n "$isAuto" ]]; then
		dns_logger "DNS FAILED NOT DOH dns_local_test :$dns_local_test:"
		set -e
		kill $THIS_PID
		exit 1
	fi
}
fi

dns_local=`dig $QUERY @ctp-vpn.local +tries=$TRIES +dnssec +short +timeout=$TIMEOUT +retry=$TRIES -t A`
dns_local_test=`echo "$dns_local" | grepip --ipv4 -o | xargs`

if [[ "$CONCURENT_OVERRIDE" == 'false' ]] && [[ -n "$isAuto" ]]; then
	if [[ -f $CTP_DNS_LOCK_FILE ]]; then
	        echo "LOCK FILE"
		kill -9 $$
	fi
fi
