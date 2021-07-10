#!/bin/bash
round() {
    printf "%.${2:-0}f" "$1"
}
CPU_CORE_COUNT=`cat /proc/stat | grep cpu | grep -E 'cpu[0-9]+' | wc -l`
MEM_COUNT=$(round `grep MemTotal /proc/meminfo | awk '{print $2 / 1024}'` 0)
if [[ $CPU_CORE_COUNT -le 2 ]] || [[ $MEM_COUNT -le 3096 ]] ; then
	echo "VM has not enough power need to remove gravity.db sync $MEM_COUNT $CPU_CORE_COUNT"
	echo "VM has not enough power need to remove gravity.db sync"
	CRON_FILE=/etc/cron.d/pihole
	#CPU_CORE_COUNT_USAGE=$(( $CPU_CORE_COUNT ))
	grep -v "pihole updateGravity" ${CRON_FILE} > $CRON_FILE.tmp
	mv $CRON_FILE.tmp ${CRON_FILE}
else
	echo "VM has GOOD enough power FOR gravity.db sync $MEM_COUNT $CPU_CORE_COUNT"
	echo "VM has GOOD enough power FOR gravity.db sync"
	echo "VM has GOOD enough power FOR gravity.db sync"
fi
