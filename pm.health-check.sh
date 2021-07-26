#!/bin/bash
source $PROG/all-scripts-exports.sh
bash $PROG/dns-stale-restart.sh
CONCURRENT

if [[ -f /tmp/health-checks.stop.lock ]]; then
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
Health check starting up
Running $max times.
Sleeping $SLEEP_T invtevals.
Result SLEEP_RESULT: $SLEEP_RESULT
Does $SLEEP_T * $max < $T_TIME ~ 1.5 * $max? Check below
Cron should be setup for 1 minute invtevals.
"""

#bash $PROG/test_dnssec.sh -a

for ((i=1; i < ( $max ); i++))
do
	if [[ -f /tmp/health-checks.stop.lock ]]; then
		echo "LOCK FILE"
		trap 'LOCK_FILE' ERR
		set -e
		kill -9 $$
		exit 1
	fi
	echo "check #$i dns stail `date`"
	bash $PROG/dns-stale-restart.sh
	bash $PROG/test_dns_unbound.sh -a
	bash $PROG/test_dns.sh -a
	bash $PROG/test_dot.sh -a
	bash $PROG/test_doh.sh -a
	bash $PROG/test_doq.sh -a
	echo "check sleeping $SLEEP_T"
	echo "$SLEEP_T `date`"
	sleep $SLEEP_T
done
set -e
[ $? == 1 ] && exit 0 || exit 0;
