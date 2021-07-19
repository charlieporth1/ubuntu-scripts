#!/bin/bash
if [[ -f /tmp/health-checks.stop.lock ]]; then
        echo "LOCK FILE"
	trap 'LOCK_FILE' ERR
        set -e
        exit 1
        exit 1
fi
source $PROG/all-scripts-exports.sh
CONCURRENT
echo "Running DOH TEST"

[[ "$1" == "-a" ]] && isAuto="-o"
HOST=dns.ctptech.dev
QUERY=www.google.com
TIMEOUT=180
TRIES=5

DNS_IP=`$PROG/grepify.sh $(bash $PROG/get_ext_ip.sh)`
ROOT_NETWORK=`bash $PROG/get_network_devices_ip_address.sh --grepify`
EXCLUDE_IP="$DNS_IP\|0.0.0.0\|$ROOT_NETWORK\|127.0.0.1"

EXTENRAL_IP=`bash $PROG/get_ext_ip.sh --current-ip`

if [[ -z $EXTENRAL_IP ]]; then
	echo "EXTENRAL_IP :$EXTENRAL_IP: null and exiting"
	exit 1
fi

if ! command -v doh &> /dev/null
then
    echo "COMMAND doh could not be found"
    exit 1
fi

if ! command -v grepip &> /dev/null
then
    echo "COMMAND grepip could not be found installing"
    curl -Ls 'https://raw.githubusercontent.com/ipinfo/cli/master/grepip/deb.sh' | bash
fi

# CLI EXANMPLES
# curl -s -w '\n' "http://localhost:8053/dns-query?name=www.google.com&type=A"
# curl --resolve dns.ctptech.dev:443:$EXTENRAL_IP -w '\n' "https://dns.ctptech.dev/resolve?name=www.google.com&type=A"
# curl -s -w '\n' "https://dns.ctptech.dev/resolve?name=www.google.com&type=A"
# curl -s -w '\n' "https://dns.ctptech.dev/resolve?name=$QUERY&type=A"
# curl -s -H 'accept: application/dns-message' "https://dns.ctptech.dev/dns-query?dns=q80BAAABAAAAAAAAA3d3dwdleGFtcGxlA2NvbQAAAQAB" | hexdump -c
# curl --resolve dns.ctptech.dev:443:$EXTENRAL_IP https://dns.ctptech.dev:443/dns-query/dns-query?dns=AAABAAABAAAAAAABCmluaXQtcDAxbWQFYXBwbGUDY29tAABBAAEAACkQAAAAgAAACwAIAAcAARgArjWC --output -
# curl --resolve dns.ctptech.dev:443:$EXTENRAL_IP https://dns.ctptech.dev:443/dns-query/dns-query?dns=AAABAAABAAAAAAABCmluaXQtcDAxbWQFYXBwbGUDY29tAABBAAEAACkQAAAAgAAACwAIAAcAARgArjWC |hexdump -C
# curl https://gcp.ctptech.dev:4443/dns-query/dns-query?dns=AAABAAABAAAAAAABCmluaXQtcDAxbWQFYXBwbGUDY29tAABBAAEAACkQAAAAgAAACwAIAAcAARgArjWC |hexdump -C
# doh -v -rdns.ctptech.dev:443:$EXTENRAL_IP -tA www.theanonymousemail.com "https://dns.ctptech.dev/dns-query:4443
# doh -v -rdns.ctptech.dev:443:$EXTENRAL_IP -tA www.google.com "https://dns.ctptech.dev/resolve"
# doh -v -rdns.ctptech.dev:443:$EXTENRAL_IP -tA www.google.com "https://dns.ctptech.dev/dns-query:4443"
dns_local=`dig $QUERY @ctp-vpn.local +tries=$TRIES +dnssec +short +timeout=$TIMEOUT +retry=$TRIES`

doh_proxy_local=`timeout $TIMEOUT curl --insecure -H 'accept: application/dns-json' -sw '\n' "http://localhost:8053/resolve?name=$QUERY&type=A"`
doh_remote_json=`timeout $TIMEOUT curl --resolve $HOST:443:$EXTENRAL_IP -H 'accept: application/dns-json' -sw '\n' "https://$HOST/resolve?name=$QUERY&type=A"`
doh_remote_nginx=`timeout $TIMEOUT doh -4 -r$HOST:443:$EXTENRAL_IP -tA $QUERY "https://$HOST/dns-query"`
doh_remote_ctp=`timeout $TIMEOUT doh -4 -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST:4443/dns-query"`

WAIT_TIME=6

log_d "$PATH"
log_d "doh_remote_ctp :$doh_remote_ctp: doh_remote_nginx :$doh_remote_nginx:"
log_d "doh_remote_json :$doh_remote_json: doh_local :$doh_local:"
if [[ -n "$isAuto" ]]; then
	dns_local_test=`echo "$dns_local" | grepip --ipv4 -o | xargs`
	if [[ -z "$dns_local_test" ]]; then
	        echo "DNS FAILED NOT DOH dns_local_test :$dns_local_test:"
		exit 1
		kill $$
	fi

 	doh_proxy_local_test=`echo "$doh_proxy_local" | grep -o "$QUERY"`
 	doh_remote_json_test=`echo "$doh_remote_json" | grep -o "$QUERY"`
 	doh_remote_nginx_test=`echo "$doh_remote_nginx" | grepip --ipv4 -o`
 	doh_remote_ctp_test=`echo "$doh_remote_ctp" | grepip --ipv4 -o`

	log_d "dns_local_test :$dns_local_test: doh_remote_json_test :$doh_remote_json_test:"
	log_d "doh_remote_nginx_test :$doh_remote_nginx_test: doh_remote_ctp_test :$doh_remote_ctp_test:"

	if [[ -z "$doh_proxy_local_test" ]] && [[ $(systemctl-inbetween-status doh-server.service) == false ]]; then
		echo "ALERT DOH doh_proxy_local_test doh-proxy :$doh_proxy_local_test:"
		sudo killall -9 doh-server
		systemctl restart doh-server.service
		sleep $WAIT_TIME
	else
		echo "Success doh JSON PROXY"
	fi

	if { { [[ -z "$doh_remote_json_test" ]] && [[ -n "$doh_remote_ctp_test" ]]; } ||
	     { [[ -z "$doh_remote_nginx_test" ]] && [[ -n "$doh_proxy_local_test" ]]; }; } && [[ $(systemctl-inbetween-status nginx.service) == false ]]
	then
		if [[ -z "$doh_remote_ctp_test" ]] || [[ -z "$doh_proxy_local_test" ]]; then
			echo "NOT NGINX doh_remote_ctp_test $doh_remote_ctp_test  $doh_proxy_local_test doh_proxy_local_test"
		else
			echo "ALERT DOH doh_remote_json_test NGINX doh_remote_nginx_test :$doh_remote_json_test: :$doh_remote_nginx_test:"
			echo "dns_local_test :$dns_local_test: doh_proxy_local_test :$doh_proxy_local_test: doh_remote_json_test :$doh_remote_json_test:"
			echo "doh_remote_ctp_test :$doh_remote_ctp_test: doh_remote_nginx_test :$doh_remote_nginx_test:"
			echo "NGINX failed restarting"
			if [[ -f /etc/hosts.bk ]]; then
				sudo cp -rf /etc/hosts.bk /etc/hosts
			fi

			sudo killall -9 nginx
			systemctl restart nginx.service
			sleep $WAIT_TIME
		fi
	else
		echo "Success doh NGNIX"
	fi

	if [[ -z "$doh_remote_ctp_test" ]] && [[ $(systemctl-inbetween-status ctp-dns.service) == false ]]; then
		echo "TESST REMOTE ALERt DOH doh_remote_ctp_test :$doh_remote_ctp_test:"
		echo "TESST REMOTE ALERt DOH CTP_DNS doh_remote_ctp_test :$doh_remote_ctp_test:"
		systemctl daemon-reload
		systemctl restart ctp-dns
		sleep $WAIT_TIME
	else
		echo "Success doh CTP/RFC"
	fi

else
	printf '%s\n' "$dns_local"
	URL="http://localhost:8053/resolve?name=$QUERY&type=A"
	echo -e "$URL\n"
	bash $PROG/lines.sh '#'
	echo -e "\n"
	curl -H 'accept: application/dns-json' -w \
		""" \
		\n\nTesting Website Response Time for: 
		\n%{url_effective}
		\n\nLookup Time:\t\t%{time_namelookup}
		\nConnect Time:\t\t%{time_connect}
		\nPre-transfer Time:\t%{time_pretransfer}
		\nStart-transfer Time:\t%{time_starttransfer}
		\n\nTotal Time:\t\t%{time_total}\n
		""" \
		"$URL"

	URL="https://$HOST/resolve?name=$QUERY&type=A"
	echo -e "$URL\n"
	bash $PROG/lines.sh '#'
	echo -e "\n"
	curl -H 'accept: application/dns-json' -w \
		""" \
		\n\nTesting Website Response Time for: 
		\n%{url_effective}\n\nLookup Time:\t\t%{time_namelookup}\nConnect Time:\t\t%{time_connect}
		\nPre-transfer Time:\t%{time_pretransfer}
		\nStart-transfer Time:\t%{time_starttransfer}
		\n\nTotal Time:\t\t%{time_total}\n
		""" \
		"$URL"

	echo -e "https://$HOST:4443/dns-query\n"
	bash $PROG/lines.sh '#'
	echo -e "\n"
	curl -H 'accept: application/dns-message' "https://$HOST:4443/dns-query?dns=q80BAAABAAAAAAAAA3d3dwdleGFtcGxlA2NvbQAAAQAB" | hexdump -C

	echo -e "https://$HOST:4443/dns-query\n"
	bash $PROG/lines.sh '#'
	echo -e "\n"
	curl -H 'accept: application/dns-message' "https://$HOST:4443/dns-query?dns=q80BAAABAAAAAAAAA3d3dwdleGFtcGxlA2NvbQAAAQAB" --output -

	echo -e "https://$HOST:443/dns-query\n"
	bash $PROG/lines.sh '#'
	echo -e "\n"
	curl -H 'accept: application/dns-message' "https://$HOST/dns-query?dns=q80BAAABAAAAAAAAA3d3dwdleGFtcGxlA2NvbQAAAQAB" | hexdump -C

	URL="https://$HOST:443/dns-query?dns=q80BAAABAAAAAAAAA3d3dwdleGFtcGxlA2NvbQAAAQAB"
	echo -e "$URL\n"
	bash $PROG/lines.sh '#'
	echo -e "\n"
	curl -H 'accept: application/dns-json' -w \
		""" \
		\n\nTesting Website Response Time for: 
		\n%{url_effective}\n\nLookup Time:\t\t%{time_namelookup}\nConnect Time:\t\t%{time_connect}
		\nPre-transfer Time:\t%{time_pretransfer}
		\nStart-transfer Time:\t%{time_starttransfer}
		\n\nTotal Time:\t\t%{time_total}\n
		""" \
		"$URL"

	URL="https://$HOST:4443/dns-query?dns=q80BAAABAAAAAAAAA3d3dwdleGFtcGxlA2NvbQAAAQAB"
	echo -e "$URL\n"
	bash $PROG/lines.sh '#'
	echo -e "\n"
	curl -H 'accept: application/dns-json' -w \
		""" \
		\n\nTesting Website Response Time for: 
		\n%{url_effective}\n\nLookup Time:\t\t%{time_namelookup}\nConnect Time:\t\t%{time_connect}
		\nPre-transfer Time:\t%{time_pretransfer}
		\nStart-transfer Time:\t%{time_starttransfer}
		\n\nTotal Time:\t\t%{time_total}\n
		""" \
		"$URL"
	doh $QUERY https://dns.ctptech.dev/dns-query
	bash $PROG/lines.sh '#'
	echo -e "\n"
	doh $QUERY https://dns.ctptech.dev/resolve
	bash $PROG/lines.sh '#'
	echo -e "\n"
fi
#curl -s -w 'Testing Website Response Time for :%{url_effective}\n\nLookup Time:\t\t%{time_namelookup}\nConnect Time:\t\t%{time_connect}\nPre-transfer Time:\t%{time_pretransfer}\nStart-transfer Time:\t%{time_starttransfer}\n\nTotal Time:\t\t%{time_total}\n' -o /dev/null ADDRESS
# timeout $TIMEOUT curl \
#	-H 'accept: application/dns-message' \
#	--resolve dns.ctptech.dev:443:$EXTENRAL_IP -sw '\n' \
#	"https://dns.ctptech.dev:443/dns-query?dns=$(dns2doh --A dns.ctptech.dev)"
# timeout $TIMEOUT curl \
#	-H 'accept: application/dns-message' \
#	--resolve dns.ctptech.dev:443:$EXTENRAL_IP -sw '\n' \
#	"https://dns.ctptech.dev:443/dns-query?dns=$(dns2doh --A master.dns.ctptech.dev)"
