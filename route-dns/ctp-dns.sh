#!/bin/bash
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

helpString="""
   -h --help
   -qbl --query-blocklist-log
   -qal --query-allowlist-log
   -t --tail
   -q=* --query=*
    -gc | --generate-cache
"""
function generate_lists_sha() {
	cache_dir="${1}"
	IFS=$'\n'
	http_lists=`grep http $ROUTE/dns-lists.toml | awk -F, '{print $2}' | awk -F'"' '{print $2}'`
	for url in $http_lists
	do
		echo "On $url"
		output=$(sha256sum <(curl -s $url) | awk '{print $1}')
		create_cache_list_sha $output $cache_dir
	done
	local_lists=`grep / $ROUTE/dns-lists.toml | awk -F, '{print $2}' | awk -F'"' '{print $2}' | grep -E ^/`
	for file in $local_lists
	do
		echo "On $file"
		output=$(sha256sum $file | awk '{print $1}')
		create_cache_list_sha $output $cache_dir
	done
}
function create_cache_list_sha() {
	sha="$1"
	cache_dir="${2:-/var/cache/ctp-dns}"
	! [[ -d $cache_dir ]] && sudo mkdir -p $cache_dir
	sudo touch $cache_dir/$sha
	echo "Created Cache $sha in $cache_dir"
	echo "File path $cache_dir/$sha"
}

str_match="'matched blocklist' 'matched allowlist' 'ctp-dns-time-router-yt-ttl-gcp' 'ctp-dns-time-router-yt-gcp' 'ctp-doh-local-nginx' 'ctp-google-video-master-ttl-modifer-dnsmasq-pass-thru-ip-1-udp' 'ctp-google-video-master-ttl-modifer-dnsmasq-pass-thru-ip-1-tcp' 'ctp-dns-yt-google-video-ttl-modifer' 'ctp-dns-cached-google-video-ttl-cache'"
for i in "$@"; do
    case $i in
        --help | -h | --h ) shift; echo "$helpString" ; exit 0 ;;
        -qbl | qbl | --qbl | --query-blocklist-log | --query-blacklist-log ) shift ; grep --color=auto "matched blocklist" $CTP_DNS_LOG_DIR/$LOG_FILE;;
        -qal | -qwl | qwl | qbl | --qwl | --qal | --query-allowlist-log | --query-whitelist-log ) shift ; grep --color=auto "matched allowlist" $CTP_DNS_LOG_DIR/$LOG_FILE;;
        -l | -t | --l | --t | --tail | --log ) shift ; tail -f $CTP_DNS_LOG_DIR/$LOG_FILE | h $str_match ;;
        -q=* | --query=* ) shift ; grep --color=auto "$( echo ${i} | awk -F= '{print $2 }') " $CTP_DNS_LOG_DIR/$LOG_FILE;;
        -gc | --generate-cache ) shift ; generate_lists_sha;;
        * ) shift; echo "$helpString" ; exit 0 ;;
    esac
done


