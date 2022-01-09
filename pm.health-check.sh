#!/bin/bash
source $PROG/test_dns_args.sh -a
bash $PROG/fix_devnull.sh
bash $PROG/dns-stale-restart.sh --preload
bash $PROG/test_dns.sh -a --preload
echo "Date last open `date` $scriptName"
CONCURRENT


max=6
T_TIME=58
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

nowminute=$(date +%M)
topofhr="00"

if [[ $nowminute == $topofhr ]]; then
	echo "Top of Hour test"
	bash $PROG/test_dns_refresh.sh -a --preload
	bash $PROG/test_dnssec.sh -a --preload
fi

for ((i=1; i < ( $max ); i++))
do
	echo "Check #$i DNS `date`"
	bash $PROG/fix_devnull.sh
	bash $PROG/dns-stale-restart.sh --preload
	bash $PROG/test_dns_unbound.sh -a --preload
	bash $PROG/test_dns.sh -a --preload
	if ! [[ -f $CTP_DNS_LOCK_FILE ]]; then
		bash $PROG/test_dot.sh -a --preload
		bash $PROG/test_doh.sh -a --preload
		bash $PROG/test_doq.sh -a --preload
	else
		echo "LOCK FILE $CTP_DNS_LOCK_FILE"
		if [[ `systemctl-seconds ctp-dns.service` -gt 180 ]]; then
sud			echo "CTP DNS & LOCK FILE Exceded runtime limit running fixing function"
			ctp_dns_lock_file_fix_check
		fi
	fi
	echo "check sleeping $SLEEP_T"
	echo "$SLEEP_T `date`"
	sleep $SLEEP_T
done
