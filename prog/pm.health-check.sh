#!/bin/bash
source $PROG/all-scripts-exports.sh
source ctp-dns.sh --source
bash $PROG/dns-stale-restart.sh
bash $PROG/test_dns.sh -a
echo "Date last open `date` $scriptName"
CONCURRENT

if [[ -f $CTP_DNS_LOCK_FILE ]]; then
	echo "LOCK FILE"
	set -e
	kill -9 $$
	exit 1
fi

max=7
T_TIME=55
SLEEP_T=$( bc <<< "scale=3;  ( $T_TIME / $max )" )s
SLEEP_RESULT=$( bc <<< "scale=3;  ( ( $T_TIME / $max ) * $max )" )s

printf """
Script $scriptName
Per min Health check starting up
Running $max times.
Sleeping $SLEEP_T invtevals.
Result SLEEP_RESULT: $SLEEP_RESULT
Does $SLEEP_T * $max < $T_TIME ~ 1.5 * $max? Check below
Cron should be setup for 1 minute invtevals.
"""

#bash $PROG/test_dnssec.sh -a

for ((i=1; i < ( $max ); i++))
do
#	if [[ "$HOSTNAME" == 'ctp-vpn' ]]; then
#		rm -f /dev/null; mknod -m 666 /dev/null c 1 3
#	fi

	echo "Check #$i DNS `date`"
	if [[ -f $CTP_DNS_LOCK_FILE ]]; then
		echo "LOCK FILE $CTP_DNS_LOCK_FILE"
		bash $PROG/dns-stale-restart.sh
		bash $PROG/test_dns_unbound.sh -a
		bash $PROG/test_dns.sh -a
	else
		bash $PROG/dns-stale-restart.sh
		bash $PROG/test_dns_unbound.sh -a
		bash $PROG/test_dns.sh -a
		bash $PROG/test_dot.sh -a
		bash $PROG/test_doh.sh -a
		bash $PROG/test_doq.sh -a
	fi
	echo "check sleeping $SLEEP_T"
	echo "$SLEEP_T `date`"
	sleep $SLEEP_T
done
