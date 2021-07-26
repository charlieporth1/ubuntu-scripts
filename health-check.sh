#!/bin/bash
echo "Date last open `date`"
source $PROG/all-scripts-exports.sh
CONCURRENT

WAIT_TIME=2.5s

LOG_FILE=$LOG/health_check.log
LOCK_FILE=/tmp/health-checks.stop.lock

echo "Date last ran `date`"

if ! [[ -f $LOG_FILE ]]; then
	echo "Created log file at $LOG_FILE"
        touch $LOG_FILE
fi

writeLog() {
	local fn="$1"
 	local fcount="${2:-0}"
	local SERVICE="${3:-N_A}"
	local data="$fn,$fcount,$SERVICE,[`date`]"
	echo $data | sudo tee -a $LOG_FILE
}

getFailCount() {
        local fn="$1"
        local count=`tail -25 $LOG_FILE | grep "$fn" | tail -1 | awk -F , '{print $2}'`
        echo "${count:-0}"
}

COUNT_ACTION() {
        local FN="$1"
        local COUNT="${2:-0}"
        local SERVICE="$3"
        echo "$COUNT"
        local max=5
        if [[ $COUNT -gt $max ]] && [[ "$FN" == "$LOCK_FILE" ]]; then
		echo "Removing $LOCK_FILE file because $COUNT -gt $max sleeping 30s"
		sleep 30s
		echo "Removing $LOCK_FILE file because $COUNT -gt $max"
                bash $PROG/alert_user.sh "Failure Alert" "$FN Failed $COUNT times on $HOSTNAME; Service ${SERVICE} $HOSTNAME $COUNT"
		sudo rm -rf $LOCK_FILE
		return 1
	fi

        if [[ $COUNT -ge 4 ]] && [[ $COUNT -lt $max ]]; then
                echo "SENDING EMAIL COUNT IS GREATE THAN OR EQUAL TO"
#                bash $PROG/alert_user.sh "Failure Alert" "$FN Failed $COUNT times on $HOSTNAME; Service ${SERVICE} $HOSTNAME $COUNT"
        elif [[ $COUNT -ge $max ]]; then
                echo "Reset failure count $COUNT"
                bash $PROG/alert_user.sh "Failure Alert" "$FN Failed $COUNT times on $HOSTNAME; Service ${SERVICE} $HOSTNAME $COUNT"
                if [[ -n "$SERVICE" ]]; then
			systemctl daemon-reload
	                systemctl stop $SERVICE
	                systemctl reset-failed $SERVICE
                fi
                writeLog $FN 0 $SERVICE
        else
                echo "Not sig count $SERVICE"
        fi
}

function RESTART_PIHOLE() {
        echo "RESTART_PIHOLE"
	PIHOLE_RESTART_PRE
        pihole restartdns
	sleep 5s
	PIHOLE_RESTART_POST
        echo "RESTARTING DNS"
        sleep $WAIT_TIME
}

health_check_action() {
	local fn="${1}"
	local fn_bin="${2}"
        echo $fn
	[[ -n "$fn_bin" ]] && killall -9 $fn_bin
	if [[ `systemctl-exists $fn` = 'true' ]]; then
		systemctl daemon-reload
		systemctl restart $fn
		systemctl is-active --quiet $fn && echo $fn Service is running now
	else
		killall -9 $fn
	fi
	writeLog $fn $((1+$(getFailCount $fn))) $fn
	COUNT_ACTION $fn $(getFailCount $fn) $fn
	sleep $WAIT_TIME
}

service_health_check() {
	local fn="$1"
	local fn_bin="$2"
	if [[ `systemctl-exists $fn` = 'true' ]] && [[ `systemctl-inbetween-status $fn` == 'false' ]]; then
		echo "systemd process $fn exists"
		service_status=`systemctl is-failed $fn | grep -io "$FULL_FAIL_STR"`
		if [[ -n "$service_status" ]]; then
			echo "systemd process $fn failed restarting service_status :$service_status:"
			health_check_action "$fn" "$fn_bin"
		else
			echo "systemd process $fn is healthly"
		fi
	fi

}

service_port_health_check() {
	local fn="$1"
	local port="$2"
	local fn_bin="$3"
	local fn_alias="$fn--$5"
	if [[ `systemctl-exists $fn` = 'true' ]] && [[ `systemctl-inbetween-status $fn` == 'false' ]]; then
		echo "systemd process $fn exists"
		port_status=`sudo netstat -tulpn | grep -o "$port" | xargs`
		service_status=`systemctl is-failed $fn | grep -io "$FULL_FAIL_STR"`
		if [[ -z "$port_status" ]] || [[ -n "$service_status" ]]; then
			echo "systemd process $fn failed restarting port :$port_status: fn :$fn_status: fn_alias :$fn_alias:"
			case "$fn_bin" in
				"RESTART_PIHOLE") RESTART_PIHOLE;;
				*) health_check_action "$fn" "$fn_bin";;
			esac
		else
			echo "systemd process $fn is healthly port is healthy $port_status"
		fi
	else
		echo "systemd process $fn not found"
		echo "Counting as function without systemd"
		health_check_action "$fn" "$fn_bin"
	fi
}

if [[ -f $LOCK_FILE ]]; then
        fn="$LOCK_FILE"
        echo $fn
	health_check_action "$fn"
        echo "LOCK FILE :: COUNT $(getFailCount $fn)"
        exit 1
else
        fn="$LOCK_FILE"
	writeLog $fn 0
fi

wg=`ss -lun 'sport = :54571'`

pihole_status_web=`pihole status web`
pihole_status=`pihole status | grep -io 'not\|disabled\|[✗]'`
ftl_status=`pidof pihole-FTL`


fn='pihole-FTL.service'
service_port_health_check "$fn" ":53" "pihole-FTL" "DNS"
service_port_health_check "$fn" ":4711" "pihole-FTL" "FTL"
service_port_health_check "$fn" ":53" "RESTART_PIHOLE" "RESTART_PIHOLE-DNS"
service_port_health_check "$fn" ":4711" "RESTART_PIHOLE" "RESTART_PIHOLE-FTL"

fn='unbound.service'
service_port_health_check "$fn" "127.0.0.1:5053" "unbound"

fn="doh-server.service"
service_port_health_check "$fn" "127.0.0.1:8053" "doh-server"

fn="nginx.service"
service_port_health_check "$fn" ":443" "nginx"

fn="ctp-dns.service"
service_port_health_check "$fn" ":853" "routedns"
service_port_health_check "$fn" ":4443" "routedns" "doh_https_prt"
service_port_health_check "$fn" ":1443" "routedns" "doq_doh_port"
service_port_health_check "$fn" ":784" "routedns" "doq_port"
service_port_health_check "$fn" ":1784" "routedns" "doq_port_1"
service_port_health_check "$fn" ":8853" "routedns" "doq_port_2"

fn='lighttpd.service'
service_port_health_check "$fn" ":8443"

fn='ctp-YouTube-Ad-Blocker.service'
service_health_check "$fn"

fn='ads-catcher.service'
service_health_check "$fn"

fn='wg-quick@wg0.service'
service_health_check "$fn"

fn='lighttpd.service'
service_health_check "$fn"
fn='lighttpd.service'
service_health_check "$fn"

fn='php7.4-fpm.service'
service_health_check "$fn"

fn='fail2ban.service'
service_health_check "$fn"

fn='sshd.service'
service_health_check "$fn"

fn='ssh.service'
service_health_check "$fn"

fn='resolvconf-pull-resolved.path'
service_health_check "$fn"

#fn='systemd-resolved.service'
#service_health_check "$fn"

fn='systemd-networkd.socket'
service_health_check "$fn"

fn='systemd-sysctl.service'
service_health_check "$fn"

echo "Done running at: `date`"

set -e
[ $? == 1 ] && exit 0 || exit 0;
