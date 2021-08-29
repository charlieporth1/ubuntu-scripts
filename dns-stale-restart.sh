#!/bin/bash
source $PROG/all-scripts-exports.sh
#CONCURRENT
if [[ `systemctl-exists pihole-FTL.service` == 'true' ]] && [[ $(systemctl-inbetween-status pihole-FTL.service) == 'false' ]]; then
	source $PROG/populae-log.sh
	INIT_POP_TEST
	INIT_POP_TEST

	PIHOLE_LOG=$LOG/pihole.log
	LAST_LOG_DATE=`tail -1 $PIHOLE_LOG | awk '{print $3}'`


	SEC=-10
	TIME=`bash $PROG/date-compare.sh "$LAST_LOG_DATE"`

	EXTENDED_SEC=`bc <<< "scale=3;  $SEC*1.55"`
	EXTENDED_BOOL=`bc <<< "$EXTENDED_SEC > $TIME"`

	echo $EXTENDED_SEC $SEC $EXT $TIME

	if [[ -z "$LAST_LOG_DATE" ]] || ! [[ -f $PIHOLE_LOG ]] || [[ -z "$TIME" ]]; then
		echo "Date is empty LAST_LOG_DATE $LAST_LOG_DATE TIME $TIME"
		bash $PROG/create_logging.sh
		exit 1
		kill $$
	fi

	if [[ $EXTENDED_BOOL -ge 1 ]]; then
		echo "IF"
		echo "stale log restarting dns"
		RESTART_PIHOLE
		PIHOLE_RESTART_POST
		FILL_LOG

	elif [[ $TIME -le $SEC ]]; then
		echo "Elif"
		echo "stale log restarting dns"
		RESTART_PIHOLE DNS
		PIHOLE_RESTART_POST
		FILL_LOG

	else
		IF_RESTART
	fi
elif [[ `systemctl-exists pihole-FTL.service` == 'true' ]]; then
	echo "stail not run something not found or right"
	bash $PROG/create_logging.sh
	PIHOLE_RESTART_POST
fi
