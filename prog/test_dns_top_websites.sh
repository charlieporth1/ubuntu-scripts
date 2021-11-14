#!/bin/bash
source $PROG/.my_envs.sh sample.com #we do this because this script works in tagin with domain_filter.sh
source $PROG/test_dns_args.sh $@
CONCURRENT
#SUDDOMAIN_REGEX="(?=^.{4,253}$)(^(?:[a-zA-Z0-9](?:(?:[a-zA-Z0-9\-]){0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}$)"
SUDDOMAIN_REGEX="^[a-zA-Z0-9]{1,65}\.[a-zA-Z0-9][a-zA-Z0-9-]{1,61}[a-zA-Z0-9](?:\.[a-zA-Z]{2,})+$"
FAIL_STR="NXDOMAIN\|0.0.0.0\|timed out\|NODATA-IPv6\|BOGUS\|SERVFAIL\|ERROR\|ERR\|FAIL"
MAX_TIME=2

function CACHE_DOMAIN() {
	local DOMAIN="$1"
	local ROOT_SERVER=vpn.ctptech.dev
	local HOST=cache.local
	dig $DOMAIN @$HOST +dnssec +timeout=$MAX_TIME #loads to dnsmasq cche
	kdig -d @$HOST  +tls-ca +tls-host=$ROOT_SERVER +dnssec +timeout=$MAX_TIME $DOMAIN #loads to unbound cache
	curl -sw '\n' "https://$ROOT_SERVER/dns-query?name=$DOMAIN&type=A" #mgninx cache

        RESULT=`dig -t AAAA $DOMAIN @$HOST +timeout=$MAX_TIME +dnssec | grep -o "$FAIL_STR"`
	if [[ -z "$RESULT" ]]; then
		dig -t AAAA $DOMAIN @$HOST +dnssec +timeout=$MAX_TIME #loads to dnsmasq cche
		kdig -t AAAA -d @$HOST  +tls-ca +tls-host=$ROOT_SERVER +dnssec +timeout=$MAX_TIME $DOMAIN #loads to unbound cache
		curl -sw '\n' "https://$ROOT_SERVER/dns-query?name=$DOMAIN&type=AAAA" #nginx cache
	fi
}

function LOAD_TO_CACHE() {
	local DOMAIN="$1"
		CACHE_DOMAIN "$DOMAIN"
		CACHE_DOMAIN "$DOMAIN"
		CACHE_DOMAIN "$DOMAIN"

	        RESULT=`dig www.$DOMAIN @cache.local +timeout=$MAX_TIME +dnssec | grep -o "$FAIL_STR"`
		#[[ -z `echo "$DOMAIN" | grep -P "$SUDDOMAIN_REGEX"` ]]; then
		if [[ -z "$RESULT" ]]; then
			CACHE_DOMAIN "www.$DOMAIN"
			CACHE_DOMAIN "www.$DOMAIN"
			CACHE_DOMAIN "www.$DOMAIN"
		fi
		echo "Loaded to $DOMAIN TO CACHE"
		sleep 0.00005s
	echo "Loaded to $DOMAIN TO CACHE"
}

TOP_DOMAINS_FILE=$HOLE/top-1000-domains-whitelist.txt
LOAD_TO_LOCAL_CACHE=$HOLE/custom_local_cache_domains.txt
OTHER_LISTS=$(echo `ls $WHITE_LIST_DIR/*.txt | grep "google\|amazon\|twitter\|youtube\|amp\|snapchat\|gstatic||gmail\|twitter\|tmobile\|t-mobile"`)
IFS=$'\ '
declare -a CACHE_COMMON_WHITELIST_DOMAINS
mapfile -t FILE_TO_LOAD < <(cat $OTHER_LISTS)
for FILE in $OTHER_LISTS
do
	echo "On file $FILE"
	FILE_TO_LOAD_VAR="FILE_TO_LOAD_`echo $file | rev | awk -F '/' '{print $1}' | cut -c 5-10`"
#	unset FILE_TO_LOAD
	echo "FILE_TO_LOAD  ${FILE_TO_LOAD[@]}"
#	declare -a CACHE_COMMON_WHITELIST_DOMAINS=("${CACHE_COMMON_WHITELIST_DOMAINS[@]}" "${FILE_TO_LOAD[@]}"	)
done
#is working
pihole -b remote-data.urbanairship.com -nr
test=`dig remote-data.urbanairship.com @cache.local`
isWorking=`echo $test | grep -o "$FAIL_STR"`
if [[ -z $isWorking ]]; then
	echo "Blocking off not testing"
	exit 1
fi
#test
#IFS=$'\n'
mapfile -t TOP_DOMAINS < $TOP_DOMAINS_FILE
sleep 0.050s
mapfile -t CACHE_DOMAINS_LIST < $LOAD_TO_LOCAL_CACHE
sleep 0.050s
declare -a ALL_DOMAINS
ALL_DOMAINS=(${CACHE_DOMAINS_LIST[@]} ${TOP_DOMAINS[@]} ${FILE_TO_LOAD[@]})
# ${CACHE_COMMON_WHITELIST_DOMAINS[@]})
echo "Loading: ${#ALL_DOMAINS[@]} domains to cache"
pihole -w suggestqueries.google.com datasaver.googleapis.com people-pa.googleapis.com youtubei.googleapis.com \
android-safebrowsing.google.com

for DOMAIN in "${ALL_DOMAINS[@]}"
do
	echo $DOMAIN
	RESULT=`dig $DOMAIN @cache.local +timeout=$MAX_TIME +dnssec| grep -o "$FAIL_STR"`
	if [[ -n "$RESULT" ]] && [[ -n "`echo "$DOMAIN" | grep -oP "$SUDDOMAIN_REGEX"`" ]]; then
		#$PROG/alert_user.sh "Test common domains failed on..." "failed on $DOMAIN"
		sleep 2s
	else
		LOAD_TO_CACHE "$DOMAIN"
	fi
done

