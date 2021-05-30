#!/bin/bash
echo "Date last open `date`"
source $PROG/all-scripts-exports.sh
CONCURRENT
LOG_FILE=$LOG/health_check.log
LOCK_FILE=/tmp/health-checks.stop.lock
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
        if [[ $COUNT -ge 3 ]] && [[ "$FN" = "$LOCK_FILE" ]] then
		sudo rm -rf $LOCK_FILE
	fi
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
if [[ -f $LOCK_FILE ]]; then
        fn="$LOCK_FILE"
        echo $fn
	writeLog $fn $((1+$(getFailCount $fn)))
	COUNT_ACTION $fn $(getFailCount $fn)
        echo "LOCK FILE :: COUNT $(getFailCount $fn)"
        exit 1
fi

DEFAULT_IFACE="10.128.0.9:$PORT\|192.168.99.9:$PORT"

ftl_port=`netstat -tulpn | grep -o 4711`
dns_out_port=`netstat -tulpn | grep -o ":53"| xargs`
local_dns_port=`netstat -tulpn | grep -oE '192\.168\.40\.[0-9]:53' | xargs`
https_prt=`netstat -tulpn | grep -o ":443" | xargs`
dns_https_proxy=`netstat -tulpn | grep -o '127.0.0.1:8053' | xargs`
unbound_port=`netstat -tulpn | grep -o '127.0.0.1:5053' | xargs`
dot_port=`netstat -tulpn | grep -o ":853" | xargs`
lighttpd_port=`netstat -tulpn | grep -o ':8443' | xargs`

wg=`ss -lun 'sport = :54571'`

FAILED_STR="fail\|FAILURE\|failed"
FULL_FAIL_STR="$FAILED_STR\|stop\|inactive\|dead"

doh_proxy_status=`systemctl status doh-server.service | grep  Active: | grep -io "$FULL_FAIL_STR"`
fail_ftl_status=`systemctl status pihole-FTL.service | grep  Active: | grep -io "$FAILED_STR"`
ctp_status=`systemctl status ctp-dns.service | grep  Active: | grep -io "$FULL_FAIL_STR"`
lighttpd_status=`systemctl status lighttpd.service | grep  Active: | grep -io "$FULL_FAIL_STR"`
nginx_status=`systemctl status nginx.service | grep  Active: | grep -io "$FULL_FAIL_STR"`


pihole_status_web=`pihole status web`
pihole_status=`pihole status | grep -io 'not\|disabled\|[✗]'`
ftl_status=`pidof pihole-FTL`


WAIT_TIME=1.5s
function RESTART_PIHOLE() {
	mkdir -p /var/cache/dnsmasq/
	touch /var/cache/dnsmasq/dnsmasq_dnssec_timestamp
	chown pihole:pihole -R /var/cache/dnsmasq/
        echo "RESTART_PIHOLE"
        pihole restartdns
        echo "RESTARTING DNS"
	IF_RESTART
	IF_RESTART
	IF_RESTART
        sleep $WAIT_TIME
}
fn="pihole-FTL.service"
if [[ `systemctl-exists $fn` = 'true' ]]; then
	if { [[ -n "$pihole_status" ]] || [[ -z "$dns_out_port" ]]; }
	then
	        echo "triggers $local_pihole_dns"   "$pihole_status" "$dig_dns_test"  "$dns_out" "$pihole_error_status" "$out_dns_status"
	        fn="local_pihole_dns"
	        echo $fn
	        writeLog $fn $((1+$(getFailCount $fn)))
	        COUNT_ACTION $fn $(getFailCount $fn)
	        RESTART_PIHOLE
	        sleep $WAIT_TIME
	fi
fi
if [[ `systemctl-exists $fn` = 'true' ]]; then
	if [[ -n "$fail_ftl_status" ]] || [[ -z "$ftl_status" ]] || [[ -z "$ftl_port" ]]; then
	        echo "FTL ftl_status $FTL $ftl_status"
	        fn="pihole-FTL"
	        echo $fn
	        systemctl restart $fn
	        writeLog $fn $((1+$(getFailCount $fn))) $fn
	        COUNT_ACTION $fn $(getFailCount $fn) $fn
	        sleep $WAIT_TIME
	fi
fi

if [[ -z "$dns_https_proxy" ]] || [[ -n "$doh_proxy_status" ]]; then
        fn="doh-server"
        echo $fn
        systemctl restart $fn
        writeLog $fn $((1+$(getFailCount $fn))) $fn
        COUNT_ACTION $fn $(getFailCount $fn) $fn
        sleep $WAIT_TIME
fi

if [[ -z "$https_prt" ]] || [[ -n "$nginx_status" ]]; then
        fn="nginx"
        echo $fn
        echo $fn
	killall -9 $fn
        systemctl restart $fn
        writeLog $fn $((1+$(getFailCount $fn))) $fn
        COUNT_ACTION $fn $(getFailCount $fn) $fn
        sleep $WAIT_TIME
fi

if { [[ -z "$dot_port" ]]; } || [[ -n "$ctp_status" ]] ; then
        echo "FTL ftl_status $FTL $ftl_status"
        fn="ctp-dns"
        echo $fn
	systemctl reset-failed $fn
        systemctl restart $fn
        writeLog $fn $((1+$(getFailCount $fn))) $fn
        COUNT_ACTION $fn $(getFailCount $fn) $fn
        sleep $WAIT_TIME
fi

fn="unbound.service"
if [[ `systemctl-exists $fn` = 'true' ]]; then
	unbound_status=`systemctl status $fn | grep  Active: | grep -io "$FAILED_STR"`
	if { [[ -z "$unbound_port" ]]; } || [[ -n "$unbound_status" ]] ; then
	        echo "unbound_port unbound_status $unbound_port $unbound_status"
	        echo $fn
	        systemctl restart $fn
	        writeLog $fn $((1+$(getFailCount $fn))) $fn
	        COUNT_ACTION $fn $(getFailCount $fn) $fn
	        sleep $WAIT_TIME
	fi
fi

fn="ctp-YouTube-Ad-Blocker.service"
if [[ `systemctl-exists $fn` = 'true' ]]; then
	service_status=`systemctl status $fn | grep  Active: | grep -io "$FULL_FAIL_STR"`
	if [[ -n "$service_status" ]]; then
  	      echo "ctp_youtube_status $ctp_youtube_status"
	        fn="ctp-YouTube-Ad-Blocker.service"
	        echo "YT AD BLOCKER STARTING ctp_youtube_status"
	        echo $fn
		systemctl daemon-reload
	        systemctl restart $fn
	        writeLog $fn $((1+$(getFailCount $fn))) $fn
	        COUNT_ACTION $fn $(getFailCount $fn) $fn
	        sleep $WAIT_TIME
	fi
fi

fn="ads-catcher.service"
if [[ `systemctl-exists $fn` = 'true' ]]; then
	service_status=`systemctl status $fn | grep  Active: | grep -io "$FULL_FAIL_STR"`
	if [[ -n "$service_status" ]]; then
	        echo "ad_catcher_youtube_status $ad_catcher_youtube_status"
	        echo "YT AD BLOCKER STARTING ad_catcher_youtube_status"
	        fn="ads-catcher.service"
	        echo $fn
		systemctl daemon-reload
	        systemctl restart $fn
	        writeLog $fn $((1+$(getFailCount $fn))) $fn
	        COUNT_ACTION $fn $(getFailCount $fn) $fn
	        sleep $WAIT_TIME
	fi
fi

fn="wg-quick@wg0.service"
if [[ `systemctl-exists $fn` = 'true' ]]; then
	service_status=`systemctl status $fn | grep  Active: | grep -io "$FULL_FAIL_STR"`
	if [[ -n "$service_status" ]]; then
	        echo "ad_catcher_youtube_status $ad_catcher_youtube_status"
	        echo "YT AD BLOCKER STARTING ad_catcher_youtube_status"
	        fn="ads-catcher.service"
	        echo $fn
		systemctl daemon-reload
	        systemctl restart $fn
	        writeLog $fn $((1+$(getFailCount $fn))) $fn
	        COUNT_ACTION $fn $(getFailCount $fn) $fn
	        sleep $WAIT_TIME
	fi
fi

fn="lighttpd.service"
if [[ `systemctl-exists $fn` = 'true' ]]; then
	service_status=`systemctl status $fn | grep  Active: | grep -io "$FULL_FAIL_STR"`
	if [[ -n "$service_status" ]]; then
	        echo "ad_catcher_youtube_status $ad_catcher_youtube_status"
	        echo "YT AD BLOCKER STARTING ad_catcher_youtube_status"
	        fn="ads-catcher.service"
	        echo $fn
		systemctl daemon-reload
	        systemctl restart $fn
	        writeLog $fn $((1+$(getFailCount $fn))) $fn
	        COUNT_ACTION $fn $(getFailCount $fn) $fn
	        sleep $WAIT_TIME
	fi
fi
bash $PROG/test_dnssec.sh -a
bash $PROG/test_dns.sh -a
