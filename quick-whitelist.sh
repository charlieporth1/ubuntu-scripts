#!/bin/bash
echo "Run Date: `date`"
source $PROG/all-scripts-exports.sh
TIMEOUT=2
TRIES=2
FILE_W=$HOLE/quick-whitelist.list
FILE_B=$HOLE/quick-blacklist.list

mapfile -t DOMAINS_TO_TEST_WHITE < $FILE_W
mapfile -t DOMAINS_TO_TEST_BLACK < $FILE_B

function query_domains_tester() {
	local invert="$1"
	local ARGS="$@"

	if [[ "$invert" == '!' ]]; then
		is_blacklist='true'
	else
		is_blacklist='false'
	fi

	declare -a domains
	domains=( $( new_linify $( printf '%s\n' "$ARGS" ) | grep -v '!' ) )

	declare -a APPENDED_DOMAINS
	APPENDED_DOMAINS=()

	for domain in "${domains[@]}"
	do
		is_blocked_dig=`dig $domain +short +timeout=$TIMEOUT +dnssec @cache.local +retry=$TRIES +tries=$TRIES | grep -o "0.0.0.0\|timed out\|35.192.105.158\|35.232.120.211\|NXDOMAIN"`
		debug_logger "Is blocked domain $domain is_blocked_dig $is_blocked_dig is_blacklist $is_blacklist"

		if [[ -n "$is_blocked_dig" ]] && [[ "$is_blacklist" == 'false' ]]
	        then
			APPENDED_DOMAINS=( ${APPENDED_DOMAINS[@]} $domain )
			debug_logger "Domain $domain is added to list"
		elif [[ -z "$is_blocked_dig" ]] && [[ "$is_blacklist" == 'true' ]]
		then
			APPENDED_DOMAINS=( ${APPENDED_DOMAINS[@]} $domain )
			debug_logger "Domain $domain is added to list"
		elif [[ "$is_blocked_dig" != '35.232.120.211' ]] && [[ "$is_blacklist" == 'true' ]]
		then
			APPENDED_DOMAINS=( ${APPENDED_DOMAINS[@]} $domain )
			debug_logger "Domain $domain is added to list"
		fi
		if [[ "$domain" == "${domains[ ${#domains[@]} - 1 ]}" ]] && [[ ${#APPENDED_DOMAINS[@]} -gt 0 ]]
		then
			debug_logger " {APPENDED_DOMAINS[@]} ${APPENDED_DOMAINS[@]}"
			echo "${APPENDED_DOMAINS[@]}"
		fi
	done
}
BLACK_DOMAINS=`query_domains_tester '!' "${DOMAINS_TO_TEST_BLACK[@]}"`
WHITE_DOMAINS=`query_domains_tester "${DOMAINS_TO_TEST_WHITE[@]}"`
pihole --regex -d '$' '^[a-z].([0-9]+|ad[^d]|click|coun(t|ter)|tra[ck](k|ker|king))' ' ^[a-z].([0-9]+|ad[^d]|click|coun(t|ter)|tra[ck](k|ker|king))' ''

if [[ -n "$BLACK_DOMAINS" ]]; then
	echo "Blacklisting $BLACK_DOMAINS"
	pihole -b $BLACK_DOMAINS doubleclick.net
	pihole -w -d $BLACK_DOMAINS doubleclick.net
	ccat $HOLE/apple-blacklist.list | xargs pihole -b > /dev/null
	ccat $HOLE/google-blacklist.list | xargs pihole -b > /dev/null
else
	echo "Nothing to blacklist"
fi

if [[ -n "$WHITE_DOMAINS" ]]; then
	echo "Whitelisting $WHITE_DOMAINS"
	pihole -w $WHITE_DOMAINS
	pihole -b -d $WHITE_DOMAINS
	ccat $HOLE/amazon-whitelist.list | xargs pihole -w > /dev/null
else
	echo "Nothing to whitelist"
fi

echo "Done Date: `date`"
