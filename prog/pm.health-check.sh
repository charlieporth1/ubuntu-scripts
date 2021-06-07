#!/bin/bash
if [[ -f /tmp/health-checks.stop.lock ]]; then
	echo "LOCK FILE"
	trap 'LOCK_FILE' ERR
	set -e
	exit 1
fi
source $PROG/all-scripts-exports.sh
CONCURRENT
systemctl is-active --quiet ctp-dns.service && echo Service is running

max=7
SLEEP_T=$( bc <<< "scale=3;  ( 60 / $max )" )s
SLEEP_RESULT=$( bc <<< "scale=3;  ( ( 60 / $max ) * $max )" )s

printf """
Script $scriptName
Health check starting up
Running $max times.
Sleeping $SLEEP_T invtevals.
Result SLEEP_RESULT: $SLEEP_RESULT
Does $SLEEP_T * $max < 60 ~ 1.5 * $max? Check below
Cron should be setup for 1 minute invtevals.
"""

for ((i=1; i < ( $max - 2); i++))
do
	if [[ -f /tmp/health-checks.stop.lock ]]; then
		echo "LOCK FILE"
		trap 'LOCK_FILE' ERR
		set -e
		set -E
		exit 1
		exit 1
		kill $$
	fi
	echo "check #$i dns stail `date`"
	bash $PROG/dns-stale-restart.sh
	bash $PROG/test_dns.sh -a
	bash $PROG/test_dot.sh -a
	bash $PROG/test_doh.sh -a
	bash $PROG/test_doq.sh -a
	echo "check sleeping $SLEEP_T"
	echo "$SLEEP_T `date`"
	sleep $SLEEP_T
done
set -e
[ $? == 1 ] && exit 0;
