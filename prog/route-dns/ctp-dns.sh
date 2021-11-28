#!/bin/bash
source /etc/environment
shopt -s extglob
SERVICE=ctp-dns.service
CONFIG_TEST_TIMEOUT=4
ARGS="$@"

LOG_FILE=*.log
#LOG_FILE=error.log
INSTALL_DIR=/usr/local/bin
CONFIG_DIR=${ROUTE}

export CTP_DNS_LOG_DIR=/var/log/ctp-dns
export CTP_DNS_CACHE_DIR=/var/cache/ctp-dns
export CTP_DNS_LOCK_FILE=/tmp/health-checks.stop.lock

export FLUSH_CACHE_QUERY_SUFEX='dns.ctptech.dev.flush.cache.'
KDIG_OPTIONS="+tls-ca +tls-host=dns.ctptech.dev +timeout=4 +dnssec +edns"

str_match=".*matched\sblocklist.* .*matched\sallowlist.* .*ctp-dns-time-router-yt-ttl-gcp.* .*ctp-dns-time-router-yt-gcp.* .*ctp-doh-local-nginx.* .*sending\stcp\sprobe.* .*tcp\sprobe\sfinished.* .*tcp\sprobe\sfailed.* .*cache-hit.* .*resolver\sreturned\sfailure.*"
#.*ctp-google-video-master-ttl-modifer-dnsmasq-pass-thru-ip-1-udp.*
#.*ctp-google-video-master-ttl-modifer-dnsmasq-pass-thru-ip-1-tcp.* .*ctp-dns-yt-google-video-ttl-modifer.* .*ctp-dns-cached-google-video-ttl-cache.*"
#'.*matched blocklist.*' '.*matched allowlist.*'

function get_http_lists() {
	local file_input="$1"
	local file="${file_input:=dns-lists.toml}"
	declare -gx http_lists=`grep http $CONFIG_DIR/$file | grep cache-dir | awk -F, '{print $2}' | awk -F'"' '{print $2}'`
	declare -gx last_list_http=$(printf '%s\n' "$http_lists" | tail -1)
	printf '%s\n' "$http_lists"
}
export -f get_http_lists

function get_local_lists() {
	local file_input="$1"
	local file="${file_input:=dns-lists.toml}"
	declare -gx local_lists=`grep / $CONFIG_DIR/$file | grep cache-dir | awk -F, '{print $2}' | awk -F'"' '{print $2}' | grep -E ^/`
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
	mkdir -p $HOME/go/bin/src
	mkdir -p /root/go/bin/src
	/snap/bin/go get -u -v github.com/folbricht/routedns/cmd/routedns
	sudo /snap/bin/go get -v -u github.com/folbricht/routedns/cmd/routedns
	sudo -u root sudo /snap/bin/go get -v -u github.com/folbricht/routedns/cmd/routedns
}
export -f update_route_dns

function create_logs() {
	! [[ -d $CTP_DNS_LOG_DIR/ ]] && mkdir -p $CTP_DNS_LOG_DIR/
	touch $CTP_DNS_LOG_DIR/{access,error,default}.log
}
export -f create_logs

function clear_cache() {
	sudo rm -rf $CTP_DNS_CACHE_DIR/*
	[[ -f $PROG/generarte_vulnerability-blacklist.sh ]] && sudo bash $PROG/generarte_vulnerability-blacklist.sh
	generate_lists_sha_all_files
	config_test_human
	sudo systemctl restart $SERVICE
}
export -f clear_cache

function clear_logs() {
	sudo rm -rf $CTP_DNS_LOG_DIR/*.log
	config_test_human
	sudo systemctl restart $SERVICE
}
export -f clear_logs

function config_test_exit_code() {
	local config_test_dir="${1:-$CONFIG_DIR}"
	sudo timeout $CONFIG_TEST_TIMEOUT sudo /root/go/bin/routedns $config_test_dir/*.toml --log-level=0 2> /dev/null
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

function test_result() {
	local config_test_dir="${1:-$CONFIG_DIR}"
	sudo timeout $CONFIG_TEST_TIMEOUT sudo /root/go/bin/routedns $config_test_dir/*.toml --log-level=6
	echo "$?"
	return $?
}
export -f test_result

function config_test_human() {
	local config_test_dir="${1}"
	if [[ `config_test $config_test_dir` == 'true' ]]; then
		echo "Route DNS / CTP DNS config is ok"
		return 0
	else
		echo "Route DNS / CTP DNS config is not ok: ERROR"
		echo "RUN for more details /root/go/bin/routedns ${ROUTE}/*.toml --log-level=6"
		test_result $config_test_dir
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
	if [[ `config_test ${CONFIG_DIR}` == 'false' ]]; then
		source $PROG/generate_ctp-dns-envs.sh

		bash $PROG/if_no_ipv6_do_ipv4_only.sh &
		if_master_fix

		local RUN_FILE=$PROG/generarte_vulnerability-blacklist.sh
		[[ -f $RUN_FILE ]] && $RUN_FILE &
		local RUN_FILE=$PROG/generate_ctp-dns-groups.sh
		[[ -f $RUN_FILE ]] && bash $RUN_FILE --preload &
		local RUN_FILE=$PROG/generate_ctp-dns-well-known-retry-groups.sh
		[[ -f $RUN_FILE ]] && bash $RUN_FILE
		local RUN_FILE=$PROG/generate_ctp-dns-well-known-fail-backup-groups.sh
		[[ -f $RUN_FILE ]] && bash $RUN_FILE
		local RUN_FILE=$PROG/generate_ctp-dns-backup-resolvers.sh
		[[ -f $RUN_FILE ]] && bash $RUN_FILE --preload &
		local RUN_FILE=$PROG/dns-route.sh
		[[ -f $RUN_FILE ]] && bash $RUN_FILE
		local RUN_FILE=$ROUTE/ctp-dns-format.sh
		[[ -f $RUN_FILE ]] && bash $RUN_FILE --preload --no-vars
	fi
	config_test_human ${CONFIG_DIR} &
}
export -f generate_config

function rm_lock_file() {
	[[ -f ${CTP_DNS_LOCK_FILE} ]] && /bin/rm ${CTP_DNS_LOCK_FILE}
}
function create_lock_file() {
	touch ${CTP_DNS_LOCK_FILE}
	manage_lock_file
}
export -f rm_lock_file

function manage_lock_file() {
	(
		/bin/sleep 128s
		rm_lock_file
	) &
}
export -f manage_lock_file

function flush_cache() {
	local query="$1"
	local host="${2:-ctp-vpn.local}"
	local full_query="$FLUSH_CACHE_QUERY_SUFEX$query"
	kdig -d @$host $KDIG_OPTIONS $full_query 2>&1 > /dev/null
	[[ $? -le 0 ]] && echo "Flushing cache Success: Query $full_query; Host: $host" || "Flushing cache Failed: Query $full_query; Host: $host"
}
export -f flush_cache

function flush_cache_local() {
	flush_cache 'root'
	flush_cache 'front'
}
export -f flush_cache_local

function flush_cache_all() {
	flush_cache 'root' 'dns.ctptech.dev'
	flush_cache 'front' 'dns.ctptech.dev'
}
export -f flush_cache_all

function reload_systemd_service() {
	sudo systemctl daemon-reload
	sudo systemctl reset-failed $SERVICE
	sudo systemctl reload-or-restart $SERVICE
	ctp_dns_status
}
export -f reload_systemd_service

function restart_systemd_service() {
	sudo systemctl daemon-reload
	sudo systemctl restart $SERVICE
	ctp_dns_status
}
export -f restart_systemd_service

function if_master_fix() {
	if [[ "$IS_MASTER" == 'true' ]] || [[ "$HOSTNAME" == 'ctp-vpn' ]]; then
		echo "" | sudo tee $ROUTE/slave-listeners{,-udp-retry-resolvers}.toml
	else
		echo "" | sudo tee $ROUTE/$HOSTNAME-resolvers.toml
	fi

}
export -f if_master_fix

helpString="""
   -h --help
   -qbl --query-blocklist-log
   -qal --query-allowlist-log
   -t -l --tail --log
   -q=* --query=* --query-log=*
   -ql=* --query-list=*
   -qc=* --query-config=*
   -qr=* --query-resolvers=*
   -gc --generate-cache
   -gl --generate-log
   -gconf --generate-config
   -ct --config-test
   -cth --config-test-human
   -ctid=* --config-test-in-dir=*
   -cthid=* --config-test-human-in-dir=*
   -cc --clear-cache
   -clc --clear-list-cache
   -cl -f --clear-logs --flush
   -mlf --manage-lock-file
   -clf --create-lock-file
   -rlf	--rm-lock-file
   --if-master-fix
   --reset-host-configuration
   --restart
   --reload
   --status
   --source
   --update
"""

#################### CMD START CTP_DNS_START
if [ "$0" == "$BASH_SOURCE" ]; then
for i in "$@"; do
    case $i in
        --help | -h | --h | h | help ) shift; echo "$helpString" ; exit 0 ;;
        -l | -t |  --tail | --log | *tail ) shift ; setup_tail_logs; tail -f $CTP_DNS_LOG_DIR/$LOG_FILE | h $str_match ;;
        -q=* | --query=* | --query-log?(s)=* ) shift ; setup_tail_logs ; QUERY="${i#*=}"; grep --color=auto "$QUERY" $CTP_DNS_LOG_DIR/$LOG_FILE | h -i $str_match ;;
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
        *gc | --generate-cache ) shift ; generate_lists_sha_all_files;;
        *gl | *gls | --generate-log?(s) ) shift ; create_logs;;
        *gconf | --generate-conf?(ig) ) shift ; generate_config;;
        --test-result | *tr | *test-result ) shift ; test_result;;
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
        *clc | --clear-list-cache ) shift ; clear_cache;;
        *cl | *f | *fl | --clear-log?(s) | --flush?(-log?(s)) ) shift ; clear_logs;;
        *cc | *fc | *fcl | *ccl | --clear-cache?(-local) | --flush-cache?(-local) ) shift ; flush_cache_local;;
        *fca | *cca | --clear-cache?(-all) | --flush-cache?(-all) ) shift ; flush_cache_all;;
        *ml | *mlf | --manage-lock?(-file) ) shift ; manage_lock_file;;
        *clf | --create-lock?(-file) ) shift ; create_lock_file;;
        *@(r|c)l | *@(r|c)lf | --@(rm|clear)-lock?(-file) ) shift ; rm_lock_file;;
        --if-master-fix ) shift ; if_master_fix;;
        --restart | *restart | *restartdns ) shift ; restart_systemd_service;;
        --reload | *reload ) shift ; reload_systemd_service;;
        --status | *status ) shift; ctp_dns_status ;;
        --source?(d) | *source ) shift ; echo "ctp-dns.sh sourced";;
        --update?(s) | *update ) shift ; update_route_dns;;
        --@(reset|rm|clear)-host?(s)-conf?(ig)?(uration) ) shift ;
		sudo mkdir -p $CONFIG_DIR/.host_old_reset/
		sudo mv $CONFIG_DIR/$HOSTNAME*.toml $CONFIG_DIR/.host_old_reset/
	;;
        * ) shift; echo "$helpString" ; exit 0 ;;
    esac
done

fi
