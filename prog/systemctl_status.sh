#!/bin/bash
# sudo systemctl list-units | grep -i failed
# sudo systemctl list-units --state failed
# sudo systemctl list-units --failed
systemctl daemon-reload
ARGS="$@"
TIMEOUT=16
isAutomation=`echo "$ARGS" | grep -io '\-a'`

FAILURE_STR="fail\|FAILURE\|failed"
FULL_FAIL_STR="$FAILED_STR\|deactivating\|stop\|inactive\|dead"
PROG=/home/charlieporth1_gmail_com/Programs/

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
	'google-instance-setup.service'
	'google-network-daemon.service'
	'google-accounts-daemon.service'
	'google-clock-skew-daemon.service'
)
declare -a SERVICES
#	'netdata'
#	'netdata-updater.timer'
SERVICES=(
	'pihole-FTL' 'ctp-dns' 'lighttpd' 'wg-quick@wg0.service' 'ads-catcher'
	'nginx' 'doh-server' 'php7.4-fpm'
	'unbound' 'resolvconf'
	'ctp-YouTube-Ad-Blocker'
	'netfilter-persistent' 'fail2ban' 'ipsec' 'xl2tpd' 'systemd-sysctl.service'
	'cron.service' 'pihole-updatelists.service'  'pihole-updatelists.timer' 'sshd.service' 'ssh.service' 'iptables.service'
	'resolvconf-pull-resolved.service'
	'network.target' 'logrotate.timer' 'logrotate.service' 'load-iptables-rules'
	'openvpn-server@server.service' 'snap.certbot.renew.service'
	'snap.certbot.renew.timer' 'apt-daily-upgrade.service' 'apt-daily-upgrade.timer'
	'apt-daily.timer' 'apt-daily.service'
)
printf "|| $CYAN%-30s $NC| $CYAN %-10s $NC|$CYAN %-20s $NC|$CYAN %-10s $NC|\n" "SERVICE" "STATUS" "ACTIVE TIME" "TIME"
for service in "${SERVICES[@]}"
do
	[[ -z `echo $service | grep -o '\.'` ]] && export is_service=true || export is_service=false
	if [[ -n $isAutomation ]] && [[ -z `echo $service | grep -o "$( bash $PROG/grepify.sh ${GOOGLE_SERVICES[@]} )"` ]] && [[ "$is_service" == 'true' ]]; then
		systemctl stop $service
                systemctl reset-failed $service
		sleep 0.025s
		systemctl restart $service
	fi
	sys_service_status=`timeout $TIMEOUT systemctl status $service`
	active_time=`echo "$sys_service_status" | grep 'Active' | rev | cut -d ';' -f 1 | rev | xargs`
	status=`echo "$sys_service_status" | grep 'Active' | awk '{print $2}'`
	status_str=`[[ $status == "active" ]] && printf "$ACTIVE_STR" || printf "$FAILED_STR"`
	if [[ $status_str == $FAILED_STR ]] && [[ -n $isAutomation ]]; then
		echo "Service $service has failed to restart sucessfully at `date` in automation process" > /tmp/$service.err
	fi
	[[ "$is_service" == 'true' ]] && export service="$service.service"

	printf "|| %-30s | %-30s | %-20s | %-10s |\n" "$service" "$status_str" "$active_time" "`date +'%H:%M:%S'`"
done



exit $?
