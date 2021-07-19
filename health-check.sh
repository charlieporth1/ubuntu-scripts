#!/bin/bash
echo "Date last open `date`"
source $PROG/all-scripts-exports.sh
CONCURRENT
LOG_FILE=$LOG/health_check.log
LOCK_FILE=/tmp/health-checks.stop.lock
echo "Date last ran `date`"

systemctl is-active --quiet ctp-dns.service && echo Service is running
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

health_check_action() {
	local fn="$1"
        echo $fn
	killall -9 $fn
	systemctl daemon-reload
	systemctl restart $fn
	writeLog $fn $((1+$(getFailCount $fn))) $fn
	COUNT_ACTION $fn $(getFailCount $fn) $fn
	sleep $WAIT_TIME
}

service_health_check() {
	local fn="$1"
	if [[ `systemctl-exists $fn` = 'true' ]] && [[ `systemctl-inbetween-status $fn` == 'false' ]]; then
		echo "systemd process $fn exists"
		service_status=`systemctl is-failed $fn | grep -io "$FULL_FAIL_STR"`
		if [[ -n "$service_status" ]]; then
			echo "systemd process $fn failed restarting service_status :$service_status:"
			health_check_action "$fn"
		else
			echo "systemd process $fn is healthly"
		fi
	fi

}

service_port_health_check() {
	local fn="$1"
	local fn_status="$2"
	local port_status="$3"
	if [[ `systemctl-exists $fn` = 'true' ]] && [[ `systemctl-inbetween-status $fn` == 'false' ]]; then
		echo "systemd process $fn exists"
		if [[ -z "$port_status" ]] || [[ -n "$fn_status" ]]; then
			echo "systemd process $fn failed restarting port :$port_status: fn :$fn_status:"
			health_check_action "$fn"
		else
			echo "systemd process $fn is healthly"
		fi
	fi
}

if [[ -f $LOCK_FILE ]]; then
        fn="$LOCK_FILE"
        echo $fn
	writeLog $fn $((1+$(getFailCount $fn)))
	COUNT_ACTION $fn $(getFailCount $fn)
        echo "LOCK FILE :: COUNT $(getFailCount $fn)"
        exit 1
else
        fn="$LOCK_FILE"
	writeLog $fn 0
fi


ftl_port=`netstat -tulpn | grep -o ':4711' | xargs`
dns_out_port=`netstat -tulpn | grep -o ":53"| xargs`
https_prt=`netstat -tulpn | grep -o ":443" | xargs`
dns_https_proxy=`netstat -tulpn | grep -o '127.0.0.1:8053' | xargs`
unbound_port=`netstat -tulpn | grep -o '127.0.0.1:5053' | xargs`
dot_port=`netstat -tulpn | grep -o ":853" | xargs`
lighttpd_port=`netstat -tulpn | grep -o ':8443' | xargs`

wg=`ss -lun 'sport = :54571'`

FAILED_STR="fail\|FAILURE\|failed"
FULL_FAIL_STR="$FAILED_STR\|stop\|inactive\|dead\|stopped"

doh_proxy_status=`systemctl is-failed doh-server.service | grep -io "$FULL_FAIL_STR"`
fail_ftl_status=`systemctl is-failed pihole-FTL.service | grep -io "$FAILED_STR"`
ctp_status=`systemctl is-failed ctp-dns.service | grep -io "$FULL_FAIL_STR"`
lighttpd_status=`systemctl is-failed lighttpd.service | grep -io "$FULL_FAIL_STR"`
nginx_status=`systemctl is-failed nginx.service | grep -io "$FULL_FAIL_STR"`


pihole_status_web=`pihole status web`
pihole_status=`pihole status | grep -io 'not\|disabled\|[✗]'`
ftl_status=`pidof pihole-FTL`


WAIT_TIME=8.5s
function RESTART_PIHOLE() {
	mkdir -p /var/cache/dnsmasq/
	touch /var/cache/dnsmasq/dnsmasq_dnssec_timestamp
	touch /etc/pihole/local.list
	touch /etc/pihole/custom.list
	#chown pihole:pihole -R /var/cache/dnsmasq/
	sudo chown -R dnsmasq:pihole /var/cache/dnsmasq
        echo "RESTART_PIHOLE"
        pihole restartdns
	sleep 5s
        echo "RESTARTING DNS"
	IF_RESTART
	IF_RESTART
	IF_RESTART
        sleep $WAIT_TIME
}

fn='pihole-FTL.service'
if [[ `systemctl-exists $fn` = 'true' ]] && [[ `systemctl-inbetween-status $fn` == 'false' ]]; then
	echo "systemd process $fn exists"
	if { [[ -n "$pihole_status" ]] || [[ -z "$dns_out_port" ]]; }
	then
	        echo "triggers pihole_status :$pihole_status: dns_out_port :$dns_out_port:"
	        fn="local_pihole_dns"
	        echo $fn
	        writeLog $fn $((1+$(getFailCount $fn)))
	        COUNT_ACTION $fn $(getFailCount $fn)
	        RESTART_PIHOLE
	        sleep $WAIT_TIME
	fi
fi

if [[ `systemctl-exists $fn` = 'true' ]] && [[ `systemctl-inbetween-status $fn` == 'false' ]]; then
	echo "systemd process $fn exists"
	if [[ -n "$fail_ftl_status" ]] || [[ -z "$ftl_status" ]] || [[ -z "$ftl_port" ]]; then
		echo "systemd process $fn failed restarting"
	        echo "FTL ftl_status $FTL $ftl_status"
	        echo $fn
		sudo chown -R dnsmasq:pihole /var/cache/dnsmasq
	        systemctl restart $fn
	        writeLog $fn $((1+$(getFailCount $fn))) $fn
	        COUNT_ACTION $fn $(getFailCount $fn) $fn
	        sleep $WAIT_TIME
	fi
fi

fn='unbound.service'
if [[ `systemctl-exists $fn` = 'true' ]] && [[ `systemctl-inbetween-status $fn` == 'false' ]]; then
	service_status=`systemctl is-failed $fn | grep -io "$FULL_FAIL_STR"`
	echo "systemd process $fn exists"
	if { [[ -z "$unbound_port" ]]; } || [[ -n "$service_status" ]] ; then
		echo "systemd process $fn failed restarting"
	        echo $fn
	        systemctl restart $fn
	        writeLog $fn $((1+$(getFailCount $fn))) $fn
	        COUNT_ACTION $fn $(getFailCount $fn) $fn
	        sleep $WAIT_TIME
	fi
fi


fn="doh-server.service"
service_port_health_check "$fn" "$doh_proxy_status" "$dns_https_proxy"

fn="nginx.service"
service_port_health_check "$fn" "$nginx_status" "$https_prt"

fn="ctp-dns.service"
service_port_health_check "$fn" "$ctp_status" "$dot_port"

fn='ctp-YouTube-Ad-Blocker.service'
service_health_check "$fn"

fn='ads-catcher.service'
service_health_check "$fn"

fn='wg-quick@wg0.service'
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

fn='systemd-resolved.service'
service_health_check "$fn"

fn='systemd-networkd.socket'
service_health_check "$fn"

fn='systemd-sysctl.service'
service_health_check "$fn"

fn='systemd-timesyncd.service'
service_health_check "$fn"

echo "Done running at: `date`"
