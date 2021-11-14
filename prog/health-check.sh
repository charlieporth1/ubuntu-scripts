#!/bin/bash
source $PROG/all-scripts-exports.sh
echo "Date last open `date` $scriptName"
source ctp-dns.sh --source
CONCURRENT
WAIT_TIME=5.5s

max=5
LOG_FILE=$LOG/health_check.log
LOCK_FILE=$CTP_DNS_LOCK_FILE

echo "Date last ran `date`"
chmod 777 /dev/null

if ! [[ -f $LOG_FILE ]]; then
	echo "Created log file at $LOG_FILE"
        touch $LOG_FILE
fi

function RESTART_PIHOLE() {
        echo "RESTART_PIHOLE"
	PIHOLE_RESTART_PRE
        pihole restartdns
	sleep 5s
	PIHOLE_RESTART_POST
        echo "RESTARTING DNS"
        sleep $WAIT_TIME
}

double_block_pihole_err_fix() {
	local file=$HOLE/setupVars.conf
	local setupVarsConf=`cat $file | sort -u`
	cp -rf $file $file.bk
	if [[ `printf '%s\n' "$setupVarsConf" | grep -c BLOCKING_ENABLED` -gt 1 ]]; then
		printf '%s\n' "$setupVarsConf" | grep -v 'BLOCKING_ENABLED=false' > $file
	fi
}


writeLog() {
	local fn="$1"
 	local fcount="${2:-0}"
	local SERVICE="${3:-N_A}"
	local data="$fn,$fcount,$SERVICE,[`date`]"
	echo "$data" | sudo tee -a $LOG_FILE
}

getFailCount() {
        local fn="$1"
        local count=`tail -25 $LOG_FILE | grep "$fn" | tail -1 | awk -F , '{print $2}'`
        echo "${count:-0}"
}

DEFAULT_COUNT_ACTION() {
        local FN="$1"
        local COUNT="${2:-0}"
        local SERVICE="$3"
        local FN_BIN="$4"

        if [[ $COUNT -ge 4 ]] && [[ $COUNT -lt $max ]]; then
                echo "SENDING EMAIL COUNT IS GREATE THAN OR EQUAL TO"
		bash $PROG/create_logging.sh
		systemctl daemon-reload
		systemctl restart $fn
		systemctl is-active --quiet $fn && "echo $fn Service is running now" || echo "${error_str}"
        elif [[ $COUNT -ge $max ]]; then
                echo "Reset failure count $COUNT"
                bash $PROG/alert_user.sh "Failure Alert" "$FN Failed $COUNT times on $HOSTNAME; Service ${SERVICE} $HOSTNAME $COUNT"
                if [[ -n "$SERVICE" ]]; then
			systemctl reset-failed $SERVICE
			restart_service "$SERVICE" "$FN_BIN"
                fi
                writeLog "$FN" 0 "$SERVICE" "$FN_BIN"
        else
                echo "Not sig count $SERVICE $FN_BIN $FN"
        fi

}

COUNT_ACTION() {
        local FN="$1"
        local COUNT="${2:-0}"
        local SERVICE="$3"
        local FN_BIN="$4"

        echo "$COUNT"
	case "$FN" in
	"$LOCK_FILE" )
		if [[ $COUNT -gt $(( $max + 3 )) ]]; then
			echo "Removing $LOCK_FILE file because $COUNT -gt $max sleeping 30s"
			echo "Removing $LOCK_FILE file because $COUNT -gt $max"
        	        bash $PROG/alert_user.sh "Failure Alert" "$FN Failed $COUNT times on $HOSTNAME; Service ${SERVICE} $HOSTNAME $COUNT"
			sudo rm -rf $LOCK_FILE
        	        writeLog "$FN" 0 "$SERVICE"
			return 1
		fi
	;;
	"RESTART_PIHOLE" | "PIHOLE_STATUS" )
		if [[ $COUNT -gt $(( $max + 5 )) ]]; then
			systemctl restart unbound
			RESTART_PIHOLE
		elif [[ $COUNT -gt $(( $max + 3 )) ]] && [[ $COUNT -lt $(( $max + 2 )) ]]; then
			pihole enable
        	        writeLog "$FN" 0 "$SERVICE"
		elif [[ $COUNT -gt $max ]] && [[ $COUNT -le $(( $max + 2 )) ]]; then
			double_block_pihole_err_fix
		else
			RESTART_PIHOLE
		fi
	;;
	"nginx" | "nginx.service" )
		certbot-ocsp-fetcher --output-dir=/var/cache/nginx/
		restart_service "$FN" "$FN_BIN"
	;;
	"ctp-dns" | "ctp-dns.service" )
		if ! [[ -f $LOCK_FILE ]]; then
			restart_service "$FN" "$FN_BIN"
		fi
	;;
	* )
		DEFAULT_COUNT_ACTION "$FN" "$COUNT" "$SERVICE" "$FN_BIN"
	;;
	esac
}

restart_service() {
	local fn="${1}"
	local fn_bin="${2}"
        echo "$fn"

	local error_str="Unable to kill process $fn_bin or $fn something went wrong within status checks maybe process was activating? Result: `systemctl is-active $fn`"
	if [[ `systemctl-exists $fn` == 'true' ]] && [[ `systemctl-seconds $fn` -ge 15 ]] && [[ `systemctl-inbetween-status $fn` == 'false' ]]; then
		if [[ -n "$fn_bin" ]]; then
			killall -9 "$fn_bin"
		fi
		systemctl daemon-reload
		systemctl reload-or-restart $fn
		systemctl is-active --quiet $fn && "echo $fn Service is running now" || echo "${error_str}"
	else
		echo "Else: ${error_str}"
	fi

}

record_action() {
	local fn="$1"
	local fn_bin="${2}"
	writeLog $fn $(( 1 + $( getFailCount $fn ) )) $fn
	COUNT_ACTION "$fn" "$( getFailCount $fn )" "$fn" "$fn_bin"
	sleep $WAIT_TIME
}

health_check_action() {
	local fn="${1}"
	local fn_bin="${2}"
	local case_bin="${fn_bin:=$fn}"

	case "$case_bin" in
		"RESTART_PIHOLE" | "PIHOLE_STATUS" )
			local fn="$fn_bin"
			record_action "$fn" "$fn_bin"
		;;
		* )
			record_action "$fn" "$fn_bin"
		;;
	esac

}

service_check() {
	local fn="$1"
        local fn_bin="$2"
	local service_status=`systemctl-is-failed $fn`
       	if [[ "$service_status" == 'true' ]]; then
		echo "systemd process $fn failed restarting service_status :$service_status:"
		health_check_action "$fn" "$fn_bin"
	else
		echo "systemd process $fn is healthly"
	fi
}

service_health_check() {
	local fn="$1"
	local fn_bin="$2"

	if [[ `systemctl-exists $fn` = 'true' ]] && [[ `systemctl-inbetween-status $fn` == 'false' ]]; then
		echo "systemd process $fn exists"
		service_check "$fn" "$fn_bin"
	else
		[[ `systemctl-exists $fn` = 'false' ]] && echo "Systemd process service $fn not found" || echo "Service isn't ready yet service $fn"
	fi

}

service_port_health_check() {
	local fn="$1"
	local port_and_or_ip="$2"
	local port=$(echo $port_and_or_ip | cut -f 2- -d ':')
	local fn_bin="$3"
	local fn_alias="$fn--$5"

	if [[ `systemctl-exists $fn` = 'true' ]] && [[ `systemctl-inbetween-status $fn` == 'false' ]]; then
		echo "systemd process $fn exists"
#		local port_status=`sudo netstat -tulpn | grep -o "$port" | sort -u`
		local port_status=`ss -alunt "sport = :$port" | grep -o "$port_and_or_ip" | sort -u`
		if [[ -z "$port_status" ]]; then
			echo "systemd process $fn failed restarting port, $port_and_or_ip $port :$port_status: fn :$fn_status: fn_alias :$fn_alias:"
			health_check_action "$fn" "$fn_bin"
		else
			service_check "$fn" "$fn_bin"
			echo "systemd process $fn is healthly port is healthy $port_status"
		fi

	else
		[[ `systemctl-exists $fn` = 'false' ]] && echo "Systemd process not found service $fn port $port" || echo "Service isn't ready yet service $fn port $port"
	fi
}


fn='pihole-FTL.service'
if [[ "$IS_MASTER" == 'true' ]] || [[ `systemctl-exists $fn` = 'true' ]]; then
	if [[ `systemctl-inbetween-status $fn` == 'false' ]]; then

		pihole_status=`pihole status | grep -iv "$pihole_blocking_disabled_grep_around" | grep -io 'not\|[✗]'`
		pihole_status_enable_test=`pihole status | grep -i "$pihole_blocking_disabled_grep_around"`
		ftl_status=`pidof pihole-FTL`

		pihole_status_web=`pihole status web`
		wg=`ss -lun 'sport = :54571'`

		if [[ -n "$pihole_status" ]]; then
			health_check_action "$fn" "PIHOLE_STATUS"
		elif [[ -n "$pihole_status_enable_test" ]]; then
			health_check_action "$fn" "pihole_status_enable_test"
			double_block_pihole_err_fix
		elif [[ -z "$ftl_status" ]]; then
			health_check_action "$fn" "FTL_STATUS"
		fi
	fi
fi

# Order matters
if [[ `systemctl-seconds ctp-dns.service` -ge 300 ]] && [[ -f $LOCK_FILE ]]; then
	echo "Removing lock file runtime is greater than needed"
	sudo rm -rf $LOCK_FILE
elif [[ -f $LOCK_FILE ]]; then
        fn="$LOCK_FILE"
        echo $fn
	health_check_action "$fn"
        echo "LOCK FILE :: COUNT $(getFailCount $fn)"
	kill $$
fi

fn='pihole-FTL.service'
service_port_health_check "$fn" ":53" "pihole-FTL" "DNS"
service_port_health_check "$fn" ":4711" "pihole-FTL" "FTL"
service_port_health_check "$fn" ":53" "RESTART_PIHOLE" "RESTART_PIHOLE-DNS"
service_port_health_check "$fn" ":4711" "RESTART_PIHOLE" "RESTART_PIHOLE-FTL"

fn="doh-server.service"
service_port_health_check "$fn" "127.0.0.1:8053" "doh-server"

fn="nginx.service"
service_port_health_check "$fn" ":443" "nginx"
service_port_health_check "$fn" ":80" "nginx" "http_nginx"

fn="ctp-dns.service"
service_port_health_check "$fn" ":853" ""
service_port_health_check "$fn" ":22443" "" "doh_proxy_https_prt"
service_port_health_check "$fn" ":4443" "" "doh_https_prt"
service_port_health_check "$fn" ":1443" "" "doq_doh_port"
service_port_health_check "$fn" ":784" "" "doq_port"
service_port_health_check "$fn" ":1784" "" "doq_port_1"
service_port_health_check "$fn" ":8853" "" "doq_port_2"

fn="ctp-dns-dnscrypt.service"
service_port_health_check "$fn" ":7443" ""

fn="ctp-yt-ttl-dns.service"
service_port_health_check "$fn" "192.168.40.7:5053" "" "IP-1"
service_port_health_check "$fn" "192.168.40.8:5053" "" "IP-2"

fn="nginx-dns-rfc.service"
service_port_health_check "$fn" "127.0.0.1:11443"

fn='pihole-loadbalancer-ctp-dns.service'
service_port_health_check "$fn" "127.0.0.1:5553"

fn='lighttpd.service'
service_port_health_check "$fn" ":8443"

fn='ctp-YouTube-Ad-Blocker.service'
service_health_check "$fn"

fn='ads-catcher.service'
service_health_check "$fn"

fn='wg-quick@wg0.service'
service_health_check "$fn"

fn='wg-quick.target'
service_health_check "$fn"

fn='lighttpd.service'
service_health_check "$fn"

fn='php7.4-fpm.service'
service_health_check "$fn"

fn='php7.1-fpm.service'
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

#fn='systemd-networkd.socket'
#service_health_check "$fn"

fn='systemd-sysctl.service'
service_health_check "$fn"

fn='cron.service'
service_health_check "$fn"

fn='tailscaled.service'
service_health_check "$fn"

#fn='zerotier-one.service'
#service_health_check "$fn"

fn='dhcpcd.service'
service_health_check "$fn"

#fn='systemd-resolved.service'
#service_health_check "$fn"

fn='avahi-daemon.service'
service_health_check "$fn"

fn='asn.service'
service_health_check "$fn"

fn='containerd.service'
service_health_check "$fn"

fn='docker.socket'
service_health_check "$fn"



if ! ifconfig | grep -o tailscale0 > /dev/null
then
	echo "Tailscale interface isn't ready/healthly"
	bash $PROG/start_tailscale.sh
        systemctl restart "$fn"
fi

if [[ "$IS_MASTER" == 'true' ]] || [[ "$HOSTNAME" == "ctp-vpn" ]]; then
	fn="nginx.service"
	service_port_health_check "$fn" ":11853" "nginx" "http_nginx"

	fn='unbound.service'
	service_port_health_check "$fn" "127.0.0.1:5053" "unbound"

else
	fn="ctp-dns.service"
	service_port_health_check "$fn" ":53" "" "ctp-dns-dns-53"

fi

if [[ -f $PROG/wireguard-health-check.sh ]]; then
	bash $PROG/wireguard-health-check.sh
fi

echo "Done running at: `date`"

[ $? == 1 ] && exit 0 || exit 0;
kill $$
