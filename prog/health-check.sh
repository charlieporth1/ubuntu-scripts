#!/bin/bash
source $PROG/all-scripts-exports.sh
sudo rm -rf /etc/{proc,etc,root,home,snap,boot,var,lib,usr,bin,sbin,mnt.opt,swapfile,sys,tmp,dev,media}
CONCURRENT
echo "Health check running at: `date`"
LOG_FILE=$LOG/heath_check.log
echo "Date last ran `date`"

if [[ ! -f $LOG_FILE ]]; then
        touch $LOG_FILE
fi

writeLog() {
  local fn="$1"
  local fcount="${2:-0}"
  local SERVICE="${3:-N_A}"
  local data="$fn,$fcount,$SERVICE,[`date`]"
  echo $data
  echo $data >> $LOG_FILE
}
getFailCount() {
        local fn="$1"
        local count=`tail -100 $LOG_FILE | grep "$fn" | tail -1 | awk -F , '{print $2}'`
        echo "${count:-0}"
}
COUNT_ACTION() {
        local FN="$1"
        local COUNT="${2:-0}"
        local SERVICE="$3"
        echo "$COUNT"
        local max=5
        if [[ $COUNT -ge 3 ]] && [[ $COUNT -lt $max ]]; then
                echo "SENDING EMAIL COUNT IS GREATE THAN OR EQUAL TO"
                bash $PROG/alert_user.sh "Failure Alert" "$FN Failed $COUNT times on $HOSTNAME; Service ${SERVICE}"
        elif [[ $COUNT -ge $max ]]; then
                echo "Reset failure count $COUNT"
                bash $PROG/alert_user.sh "Failure Alert" "$FN Failed $COUNT times on $HOSTNAME; Service ${SERVICE}"
                if [[ -n "$SERVICE" ]]; then
                         systemctl stop $SERVICE
                         systemctl reset-failed $SERVICE
                fi
                writeLog $FN 0 $SERVICE
        else
                echo "Not sig count $SERVICE"
        fi
}



FAILED_STR="fail\|FAILURE"
FULL_FAIL_STR="$FAILED_STR\|inactive\|dead"
WAIT_TIME=5.5s

doh_proxy_status=`systemctl is-failed doh-server.service | grep  Active: | grep -io "$FULL_FAIL_STR"`
nginx_status=`systemctl is-failed nginx.service | grep  Active: | grep -io "$FULL_FAIL_STR"`

status=`systemctl is-failed ctp-dns.service | grep  Active: | grep -io "$FULL_FAIL_STR"`
isSystemInactive=`systemctl status ctp-dns | grep  Active: | grep -oE '(de|)activating'`


if [[ -n "$status" ]] && [[ -z "$isSystemInactive" ]]; then
        fn="ctp-dns"
        echo $fn
	writeLog $fn $((1+$(getFailCount $fn))) $fn
        COUNT_ACTION $fn $(getFailCount $fn) $fn
        systemctl restart $fn
        sleep $WAIT_TIME
fi

if [[ -n "$doh_proxy_status" ]]; then
        fn="doh-server"
        echo $fn
        systemctl restart $fn
        writeLog $fn $((1+$(getFailCount $fn))) $fn
        COUNT_ACTION $fn $(getFailCount $fn) $fn
        sleep $WAIT_TIME
fi

if [[ -n "$nginx_status" ]]; then
        fn="nginx"
        echo $fn
        echo $fn
        systemctl restart $fn
        writeLog $fn $((1+$(getFailCount $fn))) $fn
        COUNT_ACTION $fn $(getFailCount $fn) $fn
        sleep $WAIT_TIME
fi
echo "Done"
