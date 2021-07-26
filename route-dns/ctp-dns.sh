#!/bin/bash
source /etc/environment

ARGS="$@"
LOG_FILE=error.log
INSTALL_DIR=/usr/local/bin
CTP_DNS_LOG_DIR=/var/log/ctp-dns


if ! [[ -f $INSTALL_DIR/h ]]; then
	curl -s https://raw.githubusercontent.com/paoloantinori/hhighlighter/master/h.sh | sudo tee $INSTALL_DIR/h
	sudo chmod 777 $INSTALL_DIR/h
	sudo chown bin:bin $INSTALL_DIR/h
	sudo apt install -y ack > /dev/null
	source h
	echo "Finished loading h"
elif [[ -f $INSTALL_DIR/h.sh ]]; then
	source h.sh
elif [[ -f $INSTALL_DIR/h ]]; then
	source h
fi

function create_cache_list_sha() {
	local sha="$1"
	local cache_dir="${2:-/var/cache/ctp-dns}"
	! [[ -d $cache_dir ]] && sudo mkdir -p $cache_dir
	sudo touch $cache_dir/$sha
	echo "Created Cache $sha in $cache_dir"
	echo "File path $cache_dir/$sha"
}

function generate_lists_sha() {
	local cache_dir="${1}"
	IFS=$'\n'

	local http_lists=`grep http $ROUTE/dns-lists.toml | awk -F, '{print $2}' | awk -F'"' '{print $2}'`
	for url in $http_lists
	do
		echo "On $url"
		output=$(sha256sum <(curl -sSL "$url") | awk '{print $1}')
		create_cache_list_sha "$output" "$cache_dir"
	done

	local local_lists=`grep / $ROUTE/dns-lists.toml | awk -F, '{print $2}' | awk -F'"' '{print $2}' | grep -E ^/`
	for file in $local_lists
	do
		echo "On $file"
		output=$(sha256sum $file | awk '{print $1}')
		create_cache_list_sha "$output" "$cache_dir"
	done
}

function create_logs() {
	! [[ -d $CTP_DNS_LOG_DIR/ ]] && sudo mkdir -p $CTP_DNS_LOG_DIR/
	sudo touch $CTP_DNS_LOG_DIR/{access,error,default}.log
}

function config_test_exit_code() {
	timeout 3 sudo /root/go/bin/routedns ${ROUTE}/*.toml --log-level=5 2>1 /dev/null
	echo $?
}

function config_test() {
	if [[ `config_test_exit_code` == 124 ]]; then
		echo "true"
	else
		echo "false"
	fi
}

function config_test_human() {
	if [[ `config_test` == 'true' ]]; then
		echo "Route DNS / CTP DNS config is ok"
	else
		echo "Route DNS / CTP DNS config is not ok: ERROR"
		echo "RUN for more details /root/go/bin/routedns ${ROUTE}/*.toml"
		timeout 5 sudo /root/go/bin/routedns ${ROUTE}/*.toml
	fi
}

function generate_config() {
	if [[ `config_test` == 'false' ]]; then
		[[ -f $PROG/generarte_vulnerability-blacklist.sh ]] && bash $PROG/generarte_vulnerability-blacklist.sh
		[[ -f $PROG/dns-route.sh ]] && bash $PROG/dns-route.sh
	fi
	config_test_human
}

helpString="""
   -h --help
   -qbl --query-blocklist-log
   -qal --query-allowlist-log
   -t --tail
   -q=* --query=*
   -gc --generate-cache
   -gl --generate-log
   -gconf --generate-config
   -ct --config-test
   -cth --config-test-human
"""

str_match="'matched blocklist' 'matched allowlist' 'ctp-dns-time-router-yt-ttl-gcp' 'ctp-dns-time-router-yt-gcp' 'ctp-doh-local-nginx' 'ctp-google-video-master-ttl-modifer-dnsmasq-pass-thru-ip-1-udp' 'ctp-google-video-master-ttl-modifer-dnsmasq-pass-thru-ip-1-tcp' 'ctp-dns-yt-google-video-ttl-modifer' 'ctp-dns-cached-google-video-ttl-cache'"

for i in "$@"; do
    case $i in
        --help | -h | --h ) shift; echo "$helpString" ; exit 0 ;;
        -qbl | qbl | --qbl | --query-blocklist-log | --query-blacklist-log ) shift ; grep --color=auto "matched blocklist" $CTP_DNS_LOG_DIR/$LOG_FILE;;
        -qal | -qwl | qwl | qbl | --qwl | --qal | --query-allowlist-log | --query-whitelist-log ) shift ; grep --color=auto "matched allowlist" $CTP_DNS_LOG_DIR/$LOG_FILE;;
        -l | -t | --l | --t | --tail | --log ) shift ; tail -f $CTP_DNS_LOG_DIR/$LOG_FILE | h $str_match ;;
        -q=* | --query=* ) shift ; grep --color=auto "$( echo ${i} | awk -F= '{print $2 }') " $CTP_DNS_LOG_DIR/$LOG_FILE;;
        -gc | --generate-cache ) shift ; generate_lists_sha;;
        -gl | --generate-log ) shift ; create_logs;;
        -ct | --config-test ) shift ; config_test;;
        -cth | --config-test-human ) shift ; config_test_human;;
        -gconf | --generate-config ) shift ; generate_config;;
        * ) shift; echo "$helpString" ; exit 0 ;;
    esac
done


