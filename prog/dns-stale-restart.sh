#!/bin/bash
source $PROG/all-scripts-exports.sh
source $PROG/populae-log.sh
INIT_POP_TEST
INIT_POP_TEST
INIT_POP_TEST
#sleep 2.5s
#CONCURRENT
PIHOLE_LOG=$LOG/pihole.log
LAST_LOG_DATE=`tail -1 $PIHOLE_LOG | awk '{print $3}'`
SEC=-10
TIME=`bash $PROG/date-compare.sh "$LAST_LOG_DATE"`

EXTENDED_SEC=`bc <<< "scale=3;  $SEC*1.50"`
EXTENDED_BOOL=`bc <<< "$EXTENDED_SEC > $TIME"`
echo $EXTENDED_SEC $SEC $EXT $TIME
if [[ $EXTENDED_BOOL == "1" ]]; then
	echo "IF"
	echo "stale log restarting dns"
	RESTART_PIHOLE
	IF_RESTART
	IF_RESTART
	IF_RESTART
	IF_RESTART
	FILL_LOG
elif [[ $TIME -le $SEC ]]; then
	echo "Elif"
	echo "stale log restarting dns"
	RESTART_PIHOLE DNS
	IF_RESTART
	IF_RESTART
	IF_RESTART
	IF_RESTART
	FILL_LOG
else
	IF_RESTART
	IF_RESTART
	IF_RESTART
	IF_RESTART
	IF_RESTART
	IF_RESTART
fi
