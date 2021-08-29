#!/bin/bash
source /etc/environment
shopt -s extglob
SERVICE=ctp-dns.service
ARGS="$@"
LOG_FILE=error.log
INSTALL_DIR=/usr/local/bin
CONFIG_DIR=${ROUTE}
export CTP_DNS_LOG_DIR=/var/log/ctp-dns
export CTP_DNS_CACHE_DIR=/var/cache/ctp-dns
export CTP_DNS_LOCK_FILE=/tmp/health-checks.stop.lock

str_match="'matched blocklist' 'matched allowlist' 'ctp-dns-time-router-yt-ttl-gcp' 'ctp-dns-time-router-yt-gcp' 'ctp-doh-local-nginx' 'ctp-google-video-master-ttl-modifer-dnsmasq-pass-thru-ip-1-udp' 'ctp-google-video-master-ttl-modifer-dnsmasq-pass-thru-ip-1-tcp' 'ctp-dns-yt-google-video-ttl-modifer' 'ctp-dns-cached-google-video-ttl-cache'"

function get_http_lists() {
	local file="${1:-dns-lists.toml}"
	declare -gx http_lists=`grep http $CONFIG_DIR/$file | awk -F, '{print $2}' | awk -F'"' '{print $2}'`
	declare -gx last_list_http=$(printf '%s\n' "$http_lists" | tail -1)
	printf '%s\n' "$http_lists"
}
export -f get_http_lists

function get_local_lists() {
	local file="${1:-dns-lists.toml}"
	declare -gx local_lists=`grep / $CONFIG_DIR/$file | awk -F, '{print $2}' | awk -F'"' '{print $2}' | grep -E ^/`
	declare -gx last_list_local=$(printf '%s\n' "$local_lists" | tail -1)
	printf '%s\n' "$local_lists"
}
export -f get_local_lists

function setup_tail_logs() {
	if ! [[ -f $INSTALL_DIR/h ]]; then
		curl -s https://raw.githubusercontent.com/paoloantinori/hhighlighter/master/h.sh | sudo tee $INSTALL_DIR/h
		sudo chmod 777 $INSTALL_DIR/h
		sudo chown bin:bin $INSTALL_DIR/h
		sudo apt install -y ack ack-grep > /dev/null
		source h
		echo "Finished loading h"
	elif [[ -f $INSTALL_DIR/h.sh ]]; then
		source h.sh
	elif [[ -f $INSTALL_DIR/h ]]; then
		source h
	fi
}
export -f setup_tail_logs

function create_cache_list_sha() {
	local sha="$1"
	local cache_dir="${2:-$CTP_DNS_CACHE_DIR}"
	! [[ -d $cache_dir ]] && sudo mkdir -p $cache_dir
	sudo touch $cache_dir/$sha
	echo "Created Cache $sha in $cache_dir"
	echo "File path $cache_dir/$sha"
}
export -f create_cache_list_sha

function generate_lists_sha() {
	local file="${1:-dns-lists.toml}"
	local cache_dir="${2:-$CTP_DNS_CACHE_DIR}"

	local_lists=`get_local_lists "$file"`
	http_lists=`get_http_lists "$file"`

	for url in $http_lists
	do
		(
			echo "On $url"
			local output=$(sha256sum <(curl -sSL "$url") | awk '{print $1}')
			create_cache_list_sha "$output" "$cache_dir" &
		)&
	done

	for file in $local_lists
	do
		echo "On $file"
		local output=$(sha256sum $file | awk '{print $1}')
		create_cache_list_sha "$output" "$cache_dir" &
	done
}
export -f generate_lists_sha

function generate_lists_sha_all_files() {
	generate_lists_sha 'dns-lists-local.toml' &
	generate_lists_sha
}
export -f generate_lists_sha_all_files

function query_search() {
	local query="${1}"
	local file="${2}"

	local query_result=`grep "$query" $file`
	if [[ -n "$query_result" ]]; then
		echo "Found On List $file"
		printf '%s\n' "$query_result"
	fi
}
export -f query_search

function get_lists_from_file() {
	local list_file="${1}"
	local query="${2}"
	local cache_dir="${3:-$CTP_DNS_CACHE_DIR}"

	IFS=$'\n'

	local local_lists=`get_local_lists "$list_file"`
	local http_lists=`get_http_lists "$list_file"`

	local last_list_http=$(printf '%s\n' "$http_lists" | tail -1)
	local last_list_local=$(printf '%s\n' "$local_lists" | tail -1)

	for l_file in $local_lists
	do
		if [[ -f $l_file ]] && [[ -n `cat $l_file` ]]; then
			query_search "$query" $file
		elif [[ $l_file == $last_list_local ]]; then
			echo "$query not found CTP-DNS local_lists"
		fi
	done

	for url in $http_lists
	do
		if [[ -n $url ]]; then
			query_search "$query" <(curl -s "$url")
		elif [[ $url == $last_list_http ]]; then
			echo "$query not found CTP-DNS http_lists"
		fi
	done

}
export -f get_lists_from_file

function query_lists() {
	local query="${1}"
	get_lists_from_file 'dns-lists-local.toml' "$query"
	get_lists_from_file 'dns-lists.toml' "$query"
}
export -f query_lists

function update_route_dns() {
	go get -u -v github.com/folbricht/routedns/cmd/routedns
	sudo /snap/bin/go get -v -u github.com/folbricht/routedns/cmd/routedns
}
export -f update_route_dns

function create_logs() {
	! [[ -d $CTP_DNS_LOG_DIR/ ]] && sudo mkdir -p $CTP_DNS_LOG_DIR/
	sudo touch $CTP_DNS_LOG_DIR/{access,error,default}.log
}
export -f create_logs

function clear_cache() {
	sudo rm -rf $CTP_DNS_CACHE_DIR/*
	[[ -f $PROG/generarte_vulnerability-blacklist.sh ]] && sudo bash $PROG/generarte_vulnerability-blacklist.sh
	config_test_human
	sudo systemctl restart ctp-dns.service
}
export -f clear_cache

function clear_logs() {
	sudo rm -rf $CTP_DNS_LOG_DIR/*.log
	config_test_human
	sudo systemctl restart ctp-dns.service
}
export -f clear_logs

function config_test_exit_code() {
	local config_test_dir="${1:-$CONFIG_DIR}"
	sudo timeout 5 sudo /root/go/bin/routedns $config_test_dir/*.toml --log-level=0 2>  /dev/null
	echo $?
}
export -f config_test_exit_code

function config_test() {
	local config_test_dir="${1}"
	if [[ `config_test_exit_code $config_test_dir` == 124 ]]; then
		echo "true"
		return 0
	else
		echo "false"
		return $?
	fi
}
export -f config_test


function config_test_human() {
	local config_test_dir="${1}"
	if [[ `config_test $config_test_dir` == 'true' ]]; then
		echo "Route DNS / CTP DNS config is ok"
		return 0
	else
		echo "Route DNS / CTP DNS config is not ok: ERROR"
		echo "RUN for more details /root/go/bin/routedns ${ROUTE}/*.toml --log-level=6"
		sudo timeout 5 sudo /root/go/bin/routedns $CONFIG_DIR/*.toml --log-level=6
		echo "$?"
		return $?
	fi
}
export -f config_test_human

function ctp_dns_status() {
	source $PROG/all-scripts-exports.sh --no-log
	local mark_status=`systemctl is-active --quiet $SERVICE && echo "$TICK" || echo "$X"`
	echo -e "Active Status: `systemctl is-active $SERVICE` $mark_status"
	echo -e "Start time: `systemctl-run-time $SERVICE`"
	echo -e "Run time in seconds: `systemctl-seconds $SERVICE`"
	config_test_human
}
export -f ctp_dns_status

function generate_config() {
	if [[ `config_test` == 'false' ]]; then
		[[ -f $PROG/generarte_vulnerability-blacklist.sh ]] && bash $PROG/generarte_vulnerability-blacklist.sh &
		[[ -f $PROG/dns-route.sh ]] && bash $PROG/dns-route.sh
	fi
	config_test_human
}
export -f generate_config

function rm_lock_file() {
	[[ -f ${CTP_DNS_LOCK_FILE} ]] && /bin/rm ${CTP_DNS_LOCK_FILE}
}
export -f rm_lock_file

function manage_lock_file() {
	(
		/bin/sleep 128s
		rm_lock_file
	) &
}
export -f manage_lock_file

helpString="""
   -h --help
   -qbl --query-blocklist-log
   -qal --query-allowlist-log
   -t -l --tail --log
   -q=* --query=* --query-log=*
   -ql=* --query-list=*
   -gc --generate-cache
   -gl --generate-log
   -gconf --generate-config
   -ct --config-test
   -cth --config-test-human
   -cc --clear-cache
   -cl -f --clear-logs --flush
   -mlf --manage-lock-file
   -rlf	--rm-lock-file
   --reset-host-configuration
   --source
   --update
"""
#################### CMD START CTP_DNS_START
if [ "$0" == "$BASH_SOURCE" ]; then
for i in "$@"; do
    case $i in
        --help | -h | --h | h | help ) shift; echo "$helpString" ; exit 0 ;;
        -l | -t |  --tail | --log ) shift ; setup_tail_logs; tail -f $CTP_DNS_LOG_DIR/$LOG_FILE | h $str_match ;;
        -q=* | --query=* | --query-log?(s)=* ) shift ; setup_tail_logs ; QUERY="${i#*=}"; grep --color=auto "$QUERY" $CTP_DNS_LOG_DIR/$LOG_FILE | h $str_match ;;
        *ql=* | --query-list?(s)=* ) shift ; setup_tail_logs ; QUERY="${i#*=}"; query_lists "$QUERY";;
        *qr=* | *qc=*| --query-@(resolver|conf?(ig))?(s)=* ) shift ; QUERY="${i#*=}"; grep --color=auto "$QUERY" $CONFIG_DIR/*.toml;;
        *qbl | --query-@(block|black)?(list)-log?(s) ) shift ;
		setup_tail_logs
		grep --color=auto "matched blocklist" $CTP_DNS_LOG_DIR/$LOG_FILE
	;;
        *qal | *qwl | --query-@(allow|white)?(list)-log?(s) ) shift ;
		setup_tail_logs
		grep --color=auto "matched allowlist" $CTP_DNS_LOG_DIR/$LOG_FILE
	;;
        *status ) shift; ctp_dns_status ;;
        *gc | --generate-cache ) shift ; generate_lists_sha_all_files;;
        *gl | *gls | --generate-log?(s) ) shift ; create_logs;;
        *gconf | --generate-conf?(ig) ) shift ; generate_config;;
        *ct | --config-test ) shift ; config_test;;
        *cth | *cht | --config-test-human ) shift ; config_test_human;;
        *cthi?(n)?(d) | *chti?(n)?(d) | --config-test-human-in?(-dir)=* ) shift ;
		config_dir="${i#*=}"
		config_test_human $config_dir
	;;
        *cti?(n)?(d) | *cti?(n)?(d) | --config-test-in?(-dir)=* ) shift ;
		config_dir="${i#*=}"
		config_test $config_dir
	;;
        *cc | --clear-cache ) shift ; clear_cache;;
        *cl | *f | --clear-log?(s) | --flush ) shift ; clear_logs;;
        *ml | *mlf | --manage-lock?(-file) ) shift ; manage_lock_file;;
        *@(r|c)l | *@(r|c)lf | --@(rm|clear)-lock?(-file) ) shift ; rm_lock_file;;
        --source?(d) ) shift ; echo "ctp-dns.sh sourced";;
        --update?(s) ) shift ; update_route_dns;;
        --@(reset|rm|clear)-host?(s)-conf?(ig)?(uration) ) shift ;
		sudo mkdir -p $CONFIG_DIR/.host_old_reset/
		sudo mv $CONFIG_DIR/$HOSTNAME*.toml $CONFIG_DIR/.host_old_reset/
	;;
        * ) shift; echo "$helpString" ; exit 0 ;;
    esac
done

fi
