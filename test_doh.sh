#!/bin/bash
source $PROG/test_dns_args.sh
CONCURRENT
dns_logger "Running DoH TEST"

[[ "$1" == "-a" ]] && isAuto="-o"
[[ "$1" == "-t" ]] && is_test="true"
[[ "$1" == "-m" ]] && is_metric="true"
[[ "$1" == "-tm" ]] && is_tm="true"
[[ "$1" == "-mt" ]] && is_tm="true"

TIMEOUT=32

if ! command -v doh &> /dev/null
then
    echo "COMMAND doh could not be found"
    exit 1
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
doh_remote_ctp_alt_nginx=`timeout $TIMEOUT doh -4 -r$HOST:443:$EXTENRAL_IP -tA $QUERY "https://$HOST/dns-query"`
doh_remote_ctp=`timeout $TIMEOUT doh -4 -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST:4443/dns-query"`
doh_local_ctp=`timeout $TIMEOUT doh -k -4 -r$HOST:22443:127.0.0.1 -tA $QUERY "https://$HOST:22443/dns-query"`
doh_local_nginx_rfc=`timeout $TIMEOUT doh -k -4 -r$HOST:11443:127.0.0.1 -tA $QUERY "https://$HOST:11443/dns-query"`

log_d "$PATH"
log_d "doh_remote_ctp :$doh_remote_ctp: doh_remote_nginx :$doh_remote_nginx:"
log_d "doh_remote_json :$doh_remote_json: doh_local :$doh_local:"
if [[ -n "$isAuto" ]]; then
	if_plain_dns_fail
 	doh_proxy_local_test=`echo "$doh_proxy_local" | grep -o "$QUERY"`
 	doh_remote_json_test=`echo "$doh_remote_json" | grep -o "$QUERY"`
 	doh_remote_nginx_test=`echo "$doh_remote_nginx" | grepip --ipv4 -o`
 	doh_remote_ctp_test=`echo "$doh_remote_ctp" | grepip --ipv4 -o`
 	doh_local_ctp_test=`echo "$doh_remote_ctp" | grepip --ipv4 -o`
 	doh_local_nginx_rfc_test=`echo "$doh_local_nginx_rfc" | grepip --ipv4 -o`

	log_d "dns_local_test :$dns_local_test: doh_remote_json_test :$doh_remote_json_test:"
	log_d "doh_remote_nginx_test :$doh_remote_nginx_test: doh_remote_ctp_test :$doh_remote_ctp_test:"

	if [[ -z "$doh_proxy_local_test" ]] && [[ $(systemctl-inbetween-status doh-server.service) == false ]]; then
		dns_logger "ALERT DOH doh_proxy_local_test doh-proxy :$doh_proxy_local_test:"
		[[ -f $PROG/doh_proxy_json.sh ]] && bash $PROG/doh_proxy_json.sh
		sudo killall -9 doh-server
		systemctl restart doh-server.service
		#sleep $WAIT_TIME
	else
		dns_logger "Success DoH JSON PROXY"
	fi

	if { { [[ -z "$doh_remote_json_test" ]] && [[ -n "$doh_remote_ctp_test" ]]; } || \
	     { [[ -z "$doh_remote_nginx_test" ]] && [[ -n "$doh_proxy_local_test" ]]; }; } && \
	       [[ $(systemctl-inbetween-status nginx.service) == false ]]
	then
		if [[ -z "$doh_remote_ctp_test" ]] || [[ -z "$doh_proxy_local_test" ]]; then
			dns_logger "NOT NGINX doh_remote_ctp_test $doh_remote_ctp_test  $doh_proxy_local_test doh_proxy_local_test"
		else
			dns_logger "ALERT DOH doh_remote_json_test NGINX doh_remote_nginx_test :$doh_remote_json_test: :$doh_remote_nginx_test:"
			dns_logger "dns_local_test :$dns_local_test: doh_proxy_local_test :$doh_proxy_local_test: doh_remote_json_test :$doh_remote_json_test:"
			dns_logger "doh_remote_ctp_test :$doh_remote_ctp_test: doh_remote_nginx_test :$doh_remote_nginx_test:"
			dns_logger "NGINX failed restarting"
			if [[ -f /etc/hosts.bk ]]; then
				sudo cp -rf /etc/hosts.bk /etc/hosts
			fi

			sudo killall -9 nginx
			systemctl restart nginx.service
			#sleep $WAIT_TIME
		fi
		run_fail_automation_action
	else
		dns_logger "Success DoH NGNIX"
	fi

	fn="ctp-dns.service"
	if [[ $(systemctl-inbetween-status $fn) == false ]] && [[ `systemctl-seconds $fn` -gt 128 ]]; then
		systemctl daemon-reload
		if [[ -z "$doh_remote_ctp_test" ]]; then
			echo "TESST REMOTE ALERt DOH doh_remote_ctp_test :$doh_remote_ctp_test:"
			systemctl restart "$fn"
			#sleep $WAIT_TIME
		elif [[ -z "$doh_local_ctp_test" ]]; then
			echo "TESST REMOTE ALERt DOH doh_local_ctp_test :$doh_local_ctp_test:"
			systemctl restart "$fn"
		else
			echo "Success DoH CTP/RFC"
		fi
	fi

	fn=" nginx-dns-rfc.service"
	if [[ -z "$doh_local_nginx_rfc_test" ]] &&  [[ $(systemctl-inbetween-status $fn) == false ]] && [[ `systemctl-seconds $fn` -gt 30 ]]; then
		echo "TESST REMOTE ALERt DOH doh_local_nginx_rfc_test :$doh_local_nginx_rfc_test:"
		systemctl daemon-reload
		systemctl restart $fn
	else
		echo "Success DoH NGINX DNS/RFC"
	fi

else
	function print_tests() {
		printf '%s\n' "$doh_proxy_local"
		bash $PROG/lines.sh '#'
		printf '%s\n' "$doh_remote_ctp"
		bash $PROG/lines.sh '#'
		printf '%s\n' "$doh_remote_json"
		bash $PROG/lines.sh '#'
		printf '%s\n' "$doh_remote_nginx"
		bash $PROG/lines.sh '#'
		printf '%s\n' "$doh_remote_ctp_alt_nginx"
		bash $PROG/lines.sh '#'
		printf '%s\n' "$doh_remote_ctp"
		bash $PROG/lines.sh '#'
		printf '%s\n' "$doh_local_ctp"
		bash $PROG/lines.sh '#'
		printf '%s\n' "$doh_local_nginx_rfc"
		bash $PROG/lines.sh '#'

	}
	function print_metrics() {

		URL="http://localhost:8053/resolve?name=$QUERY&type=A"
		echo -e "$URL\n"
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
	}
	if [[ -n $is_test ]]; then
		print_tests
	elif [[ -n $is_metric ]]; then
		print_metrics
	elif [[ -n $is_tm ]]; then
		print_metrics
		print_tests
	else
		print_tests
	fi
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
