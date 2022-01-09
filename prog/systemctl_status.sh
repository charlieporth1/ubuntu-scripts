#!/bin/bash
# sudo systemctl list-units | grep -i failed
# sudo systemctl list-units --state failed
# sudo systemctl list-units --failed
#sudo systemctl daemon-reload
ARGS="$@"
TIMEOUT=24
isAutomation=`echo "$ARGS" | grep -io '\-a'`
FAILURE_STR="fail\|FAILURE\|failed"
FULL_FAIL_STR="$FAILED_STR\|deactivating\|stop\|inactive\|dead"

source /etc/environment
source $PROG/all-scripts-exports.sh --no-log
system_information

# prints colored text
NC="\e[39m"
RED="\e[31m"
RED_L="\e[91m"
CYAN="\e[36m"
GREEN_L="\e[92m"
black='\e[0;30m'
blue='\e[0;34m'
green='\e[0;32m'
cyan='\e[0;36m'
red='\e[0;31m'
yellow='\e[1;33m'
white='\e[1;37m'
nc='\e[0m'
purple='\e[0;35m'
brown='\e[0;33m'
lightgray='\e[0;37m'
darkgray='\e[1;30m'
lightblue='\e[1;34m'
lightgreen='\e[1;32m'
lightcyan='\e[1;36m'
lightred='\e[1;31m'
lightpurple='\e[1;35m'
TICK="$NC[$green✔$NC]$NC"
FAIL="$NC[$RED✗$NC]$NC"

ACTIVE_STR="$green Active $TICK"
FAILED_STR="$RED Failed $FAIL"

declare -a GOOGLE_SERVICES
GOOGLE_SERVICES=(
	'google-oslogin-cache.service'
	'google-oslogin-cache.timer'
	'google-startup-scripts.service'
	'google-shutdown-scripts.service'
#	'google-instance-setup.service'
#	'google-network-daemon.service'
#	'google-accounts-daemon.service'
#	'google-clock-skew-daemon.service'
)
declare -a SERVICES
#	'netdata'
#	'netdata-updater.timer'
SERVICES=(
	'pihole-FTL'
	'ctp-dns'
	'ctp-dns-dnscrypt'
	'ctp-yt-ttl-dns'
	'ctp-YouTube-Ad-Blocker'
	'ctp-auto-6to4'
	'ctp-fail-over-dns'
	'pihole-loadbalancer-ctp-dns'
	'nginx-dns-rfc'
	'nginx'
	'doh-server'
	'lighttpd'
	'php7.4-fpm.service'
	'unbound'
	'wg-quick@wg0.service'
	'ads-catcher'
	'zerotier-one'
	'resolvconf'
	'netfilter-persistent'
	'fail2ban'
	'ipsec'
	'xl2tpd'
	'modprobe@drm.service'
	'cron.service'
	'pihole-updatelists.service'
	'pihole-updatelists.timer'
	'sshd.service'
	'ssh.service'
	'iptables.service'
	'load-iptables-rules'
	'resolvconf-pull-resolved.service'
	'resolvconf-pull-resolved.pull'
	'network.target'
	'logrotate.timer'
	'logrotate.service'
	'snap.certbot.renew.service'
	'snap.certbot.renew.timer'
	'apt-daily-upgrade.service'
	'apt-daily-upgrade.timer'
	'apt-daily.timer'
	'apt-daily.service'
	'systemd-timesyncd'
	'systemd-networkd.service'
	'systemd-timesyncd'
	'systemd-sysctl'
	'systemd-hostnamed'
	'system-getty.slice'
	'unattended-upgrades.service'
	'cockpit.service'
	'cockpit.socket'
	$( [[ "$IS_GCP" == 'true' ]] && echo ${GOOGLE_SERVICES[@]} )
)

printf "|| $CYAN%-40s $NC| $CYAN %-10s $NC|$CYAN %-13s $NC|$CYAN %-30s $NC|$CYAN %-10s $NC|\n" "SERVICE" "STATUS HUMAN" "STATUS REAL" "ACTIVE TIME" "TIME"

function print_service() {
	local service="$1"
	local sys_service_status=`systemctl status $service | grep ""`
	local active_str=`echo "$sys_service_status" | grep 'Active'`
	local active_time=`echo "$active_str" | rev | cut -d ';' -f 1 | rev | xargs`
	local status_real=`echo "$active_str" | awk '{print $2}'`
	declare -gx status_human_str=`[[ "$status_real" == "active" ]] && printf "$ACTIVE_STR" || printf "$FAILED_STR"`
	printf "|| %-40s | %-30s | %-15s | %-30s | %-10s |\n" "$service" "$status_human_str" "$status_real" "$active_time" "`date +'%H:%M:%S'`"
}
GOOGLE_SERVICES_GREPIFY=$( bash $PROG/grepify.sh ${GOOGLE_SERVICES[@]} )

for service in "${SERVICES[@]}"
do
	[[ -z `echo "$service" | grep -o '\.'` ]] && is_service=true || is_service=false
	[[ "$is_service" == 'true' ]] && export service="$service.service"
	if [[ `systemctl-exists "$service"` == 'true' ]]; then
		if [[ -n "$isAutomation" ]]; then
			if [[ -z `echo "$service" | grep -o "$GOOGLE_SERVICES_GREPIFY"` ]] && [[ "$is_service" == 'true' ]]; then
				systemctl enable $service
				systemctl stop $service
	       	        	systemctl reset-failed $service
				sleep 0.025s
				systemctl restart $service
				sleep 2.000s
				if [[ "$status_human_str" == "$FAILED_STR" ]]; then
					echo "Service $service has failed to restart sucessfully at `date` in automation process" > /tmp/$service.err
					bash $PROG/alert_user.sh "Starting process error Service: $service; Error: `cat /tmp/$service.err`;"
				fi
			fi
		fi
		print_service "$service"

	elif [[ `systemctl-sockets-exists "$service"` == 'true' ]]; then
		print_service "$service"
	elif [[ `systemctl-timer-exists "$service"` == 'true' ]]; then
		print_service "$service"
	fi
done



exit 0
