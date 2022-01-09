#!/bin/bash
source /etc/environment
if [[ -f /etc/profile.d/bash-exports-global.sh ]]; then
	source /etc/profile.d/bash-exports-global.sh
fi
ARGS="$@"

arm64_regex_root="((v|m)?)"
arm64_regex="($arm64_regex_root(8|9|64)$arm64_regex_root)"
arm32_regex_root="((h|l|f|v|7|6)?)"
arm32_regex="($arm32_regex_root{1,3})"

[[ -f $PROG/populae-log.sh ]] && source $PROG/populae-log.sh
! [[ -d $PROG ]] && PROG=${CONF_PROG_DIR:-$PROG}


export FAILED_STR="fail\|FAILURE\|failed"
export FAILED_STR_LOG="FAILURE\|SIGTERM\|SIGFAIL"
export FULL_FAIL_STR="$FAILED_STR\|$FAILED_STR_LOG\|stop\|inactive\|dead\|stopped"
#export FAILED_STR_LOG="FAILURE\|SIGTERM\|config error is REFUSED"
export pihole_blocking_disabled_grep_around="Pi-hole blocking is disabled\|[✗] Pi-hole blocking is disabled"
export CPU_ARCH=$(uname -m)
export IS_X86=$( [[ $CPU_ARCH =~ (x86((_64)?)) ]] && echo true || echo false )
export IS_ARM=$( [[ $CPU_ARCH =~ ((arm)(($arm32_regex|$arm64_regex)?)) ]] && echo true || echo false )

if [[ -z "$ENV" ]] && [[ -z `echo "$ARGS" | grep -Eio '(\-\-|\-)(e|env)'` ]]; then
	export ENV='PROD'

elif [[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(e|env)'` ]] && [[ -z "$ENV" ]]; then
	[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(e|env)(=| )PROD'` ]] && export ENV=PROD || export ENV=DEV
	[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(e|env)(=| )DEV'` ]] && export ENV=DEV

elif [[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-|)(DEV|PROD)'` ]] && [[ -z "$ENV" ]]; then
	export ENV=`echo "$ARGS" | grep -Eio '(\-\-|\-|)(DEV|PROD)'`

else
	export ENV="$ENV"

fi

[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(d|debug)'` ]] && export DEBUG=true || export DEBUG=false
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(no-log)[s]?'` ]] && export NO_LOG=true || export NO_LOG=false

[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(v|vvv|verbose)'` ]] && export VERBOSE=true || export VERBOSE=false
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(t|test)'` ]] && export TEST=true || export TEST=false

[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(co|mo|concurrent\-overrride|override|manual|manual\-override|over)'` ]] && export CONCURENT_OVERRIDE=true || export CONCURENT_OVERRIDE=false

shopt -s expand_aliases
shopt -s extglob

[[ $0 != -bash ]] && export SCRIPT=`realpath $0 | rev | cut -d '/' -f 1 | rev`

export FILE_NAME=`echo $SCRIPT | rev | cut -d '.' -f 2 | rev`
export progName=$SCRIPT
export scriptName=$SCRIPT
export script_name=$SCRIPT
export DIR=`realpath . | rev | cut -d '/' -f 1 | rev`

export IP_REGEX="(([0-9]{1,3})\.){3}[0-9]{1,3}"
export IPV4_REGEX="$IP_REGEX"

export IP_REGEX_PORT="$IP_REGEX$PORT_REGEX"
export IPV4_REGEX_PORT="$IP_REGEX_PORT"

export IP_REGEX_SUBNET="$IP_REGEX$PORT_REGEX"
export IPV4_REGEX_SUBNET="$IP_REGEX_SUBNET"

export IP_REGEX_PORT_SUBNET="$IP_REGEX$PORT_SUBNET_REGEX"
export IPV4_REGEX_PORT="$IP_REGEX_PORT_SUBNET"

export IP_REGEX_FULL="(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])"
export IPV4_REGEX_FULL="(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])"

export IPV6_REGEX="(([0-9a-fA-F]{0,4}:){1,7}[0-9a-fA-F]{0,4})"

export IPV6_FULL_REGEX="[0-9a-fA-F]{1,4}:[0-9a-fA-F]{1,4}:[0-9a-fA-F]{1,4}:[0-9a-fA-F]{1,4}:[0-9a-fA-F]{1,4}:[0-9a-fA-F]{1,4}:[0-9a-fA-F]{1,4}:[0-9a-fA-F]{1,4}"
export IPV6_FULL_REGEX_PORT="[0-9a-fA-F]{1,4}:[0-9a-fA-F]{1,4}:[0-9a-fA-F]{1,4}:[0-9a-fA-F]{1,4}:[0-9a-fA-F]{1,4}:[0-9a-fA-F]{1,4}:[0-9a-fA-F]{1,4}:[0-9a-fA-F]{1,4}$PORT_SEPERATOR_REGEX$PORT_REGEX"
export IPV6_FULL_REGEX_SUBNET="[0-9a-fA-F]{1,4}:[0-9a-fA-F]{1,4}:[0-9a-fA-F]{1,4}:[0-9a-fA-F]{1,4}:[0-9a-fA-F]{1,4}:[0-9a-fA-F]{1,4}:[0-9a-fA-F]{1,4}:[0-9a-fA-F]{1,4}$SUBNET_SEPERATOR_REGEX$PORT_REGEX"

export ODD_ETH_REGEX="(n(x|s|n|o|p|e)([[:alnum:]]*))"
export WLAN_DEVICE_REGEX="(wl((an)?)[0-9]+)"
export ETH_DEVICE_REGEX="(e($ODD_ETH_REGEX|th[0-9]+))"
export USB_DEVICE_REGEX="(usb[0-9]+)"
export VPN_DEVICE_REGEX="((tailscale|wg|tap|tun((l|nel)?)|sit)[0-9]+)"
export OTHER_DEVICE_REGEX="((ip_vti|tun((l|nel)?))[0-9]+)"
export LO_DEVICE_REGEX="(lo:?[0-9]*)"


export NET_DEVICE_REGEX="($ETH_DEVICE_REGEX|$WLAN_DEVICE_REGEX|$USB_DEVICE_REGEX)"
export NET_DEVICE_REGEX_IFCONFIG="$NET_DEVICE_REGEX\:"
export default_iface=`sudo ip route | grep '^default' | grep -oiE "$NET_DEVICE_REGEX" | awk '{ print $1}' | sed -n '1p'`
#export default_iface_address=`sudo ifconfig $default_iface | awk '{print $2}' | grepip -4`
export default_iface_address=`sudo ip add show dev $default_iface | grepip | awk '{print $2}' | sed -n '1p' | awk  -F/ '{print $1}'`
export MASTER_MACHINE="ctp-vpn"
export GCLOUD_PROJECT="galvanic-pulsar-284521"
export GCLOUD_ZONE="us-central1-a"

alias isFTLRunning='bash $PROG/process_count.sh pihole-FTL'
alias sort-uniq='sort -u | uniq | sort -u'
alias ip-sort='sort -u -t . -k 1,1n -k 2,2n -k 3,3n -k 4,4n | uniq'
alias ip-sort-oct='sort -u -t. -n +3.0'

# DO NOT CHANGE ORDER
export THIS_PID=${BASHPID:-$$}
export isRunning_str="bash $PROG/process_count.sh $THIS_PID"
export isRunning="`$isRunning_str`"
alias isRunning="$isRunning_str"

export parallel_args=" --trim rl --no-run-if-empty --jobs +1"
export parallel_args_lb=" --lb $parallel_args"
export parallel_xargs="$parallel_args -m --xargs"
export parallel_xargs_lb="$parallel_args_lb -m --xargs"
export parallel_args_pihole="$parallel_xargs_lb -P 1 "
export parallel_xargs_pihole="$parallel_args_pihole"

export LOG_ROOT=${LOG:-/var/log}
export LOG_DIR=$LOG_ROOT/$FILE_NAME
export LOG_FILE=$LOG_DIR/$SCRIPT-$ENV.log

export NC="\e[39m"
export RED="\e[31m"
export RED_L="\e[91m"
export CYAN="\e[36m"
export GREEN_L="\e[92m"
export LIGHT_BLUE='\e[1;34m'
export TICK="$NC[\e[32m✔\e[0m]$NC"
export CHECK="$TICK"
export X="$NC[$RED_L✗$NC]$NC"

export TRIES=4
export TIMEOUT=16

ROOT_PID=$$
BASH_ROOT_PID=$BASHPID

[[ "$ENV" == "PROD" ]] && REDIRECT=/dev/null || REDIRECT=/dev/stdout
PORT_REGEX="([0-9]{1,6})"
SUBNET_SEPERATOR_REGEX="(/)"
PORT_SEPERATOR_REGEX="(:|#|@)"
PORT_SUBNET_SEPERATOR_REGEX="($PORT_SEPERATOR_REGEX|$SUBNET_SEPERATOR_REGEX)"
export PORT_SUBNET_REGEX="($PORT_SUBNET_SEPERATOR_REGEX)($PORT_REGEX?)"
export DOMAIN_REGEX="(([0-9A-Za-z\.-]{1,64}){0,64})((\.[a-z]{2,5}){1,4})"

round() {
    printf "%.${2:-0}f" "$1"
}
function bytes_to_gb() {
	 numfmt --to iec --format "%8.4f" 5104726016
}

if command -v pihole &> /dev/null
then
	export PIHOLE_LOG=$LOG/pihole.log
	export PIHOLE_FTL_LOG=$LOG/pihole-FTL.log
	export FTL_LOG=$PIHOLE_FTL_LOG
        export IS_PIHOLE=true
        export IS_MASTER=$IS_PIHOLE
        export MASTER=$IS_PIHOLE
	export HOLE=/etc/pihole
	export PIHOLE=$HOLE
	export DNSMASQ=/etc/dnsmasq.d
	export GRAVITY=gravity.db
	export GRAVITY_FILE=$HOLE/$GRAVITY
	export DB_FILE=$GRAVITY_FILE
	export FTL_DB_FILE=$HOLE/pihole-FTL.db
	export FTL_DB=$FTL_DB_FILE
fi

DO=debug_override

function what_system() {
	local vm_timeout=4
	declare -gx IS_VM=$( timeout $vm_timeout facter is_virtual )

	if [[ "$IS_VM" == 'true' ]]; then
	        if [[ -n $( timeout $vm_timeout curl -s metadata.google.internal -i | grep 'Metadata-Flavor: Google' ) ]]; then
	                declare -gx IS_GCP=true
	        else
	                if [[ -n $( timeout $vm_timeout facter virtual | grep -o 'gce' ) ]]; then
	                        declare -gx IS_GCP=true
	                else
	                        if [[ -n $( timeout $vm_timeout curl -s http://169.254.169.254/latest/meta-data/hostname | grep -o 'ec2.internal' ) ]]; then
	                                declare -gx IS_AWS=true
	                        else
	                                declare -gx IS_AWS=false
	                        fi
	                fi
	        fi
	else
		declare -gx IS_BARE=$( [[ -n $( timeout $vm_timeout facter virtual | grep -o 'physical' ) ]] && echo true || echo false)
	fi

}
export -f what_system

function system_stats() {
	declare -gx ROOT_PID=$$
	declare -gx CPU_CORE_COUNT=`cat /proc/stat | grep cpu | grep -E 'cpu[0-9]+' | wc -l`
	declare -gx MEM_COUNT=$(round `grep MemTotal /proc/meminfo | awk '{print $2 / 1024}'` 0)
	declare -gx SWAP_COUNT=$(round `grep SwapTotal /proc/meminfo | awk '{print $2 / 1024}'` 0)
	declare -gx NIC_COUNT=$(sudo ifconfig | grep -E "^$ETH_DEVICE_REGEX" | wc -l)
	declare -gx WLAN_COUNT=$(sudo ifconfig | grep -E "^$WLAN_DEVICE_REGEX" | wc -l)
	declare -gx DDR_VERSION=$(sudo dmidecode | grep -Eo 'DDR[0-9]' | grep -o '[0-9]' )
	declare -gx MEMORY_COUNT=$MEM_COUNT
	declare -gx default_iface=$default_iface
	declare -gx IS_AES_HW=$(cat /proc/cpuinfo | grep -io aes > /dev/null && echo true || echo false)
	declare -gx IS_AES=$IS_AES_HW
	declare -gx IS_64BIT=$(grep -o -w 'lm' /proc/cpuinfo  > /dev/null && echo true || echo false)
	declare -gx CPU_ARCH=$CPU_ARCH
	declare -gx IS_X86=$IS_X86
	declare -gx IS_ARM=$IS_ARM
}

export -f system_stats

function system_information() {
	system_stats
	what_system
}
export -f system_information
function get_ifaces() {
	local eth_iface_count=$(ifconfig | grep -oE "$ETH_DEVICE_REGEX" | wc -l)
	declare -gx default_iface=`sudo ip route | grep '^default' | grep -oiE "$NET_DEVICE_REGEX" | awk '{ print $1}' | sed -n '1p'`

	local iface_eth=`ifconfig | grep -oiE "$ETH_DEVICE_REGEX"`
	local iface_wlan=`ifconfig  | grep -oiE "$WLAN_DEVICE_REGEX"`

	declare -gx default_iface_address=`sudo ifconfig $default_iface | awk '{print $2}' | grepip -4`
	declare -gxa ifaces_list=(
		$default_iface
		$iface_eth
		$iface_wlan
	)
}
function KILL_FILE() {
	bash $PROG/process_count.sh $FILE_NAME $THIS_PID pid | sed -n '2p' | cut -d ':' -f 2- | xargs kill -9 2> /dev/null
}
export -f KILL_FILE

function setupLogger() {
	! [[ -d $LOG_DIR ]] && mkdir -p $LOG_DIR/ 2>/dev/null

	! [[ -f $LOG_FILE ]] && touch $LOG_FILE 2>/dev/null
	! [[ -f $LOG_FILE.colored ]] && touch $LOG_FILE.colored 2>/dev/null
	! [[ -f $LOG_FILE.debug ]] && touch $LOG_FILE.debug 2>/dev/null
}
export -f setupLogger

if [[ "$NO_LOG" == 'false' ]] && [[ $- != *i* ]] && [[ `shopt -q login_shell; echo $?` -gt 0 ]]; then
	if [[ $0 != -bash ]]; then
      		setupLogger
	fi
fi

function get_function_location() {
        local CALL_LOCATION=""
	if [[ -n ${FUNCNAME[1]} ]] && { [[ -z ${FUNCNAME[2]} ]] || [[ ${FUNCNAME[2]} == 'main' ]]; }; then
	      local CALL_LOCATION="FUNC: ${FUNCNAME[1]};"
	elif [[ -n ${FUNCNAME[2]} ]] && { [[ -z ${FUNCNAME[3]} ]] || [[ ${FUNCNAME[3]} == 'main' ]]; }; then
	     local CALL_LOCATION="FUNC: LEVEL 1 ${FUNCNAME[1]}: LEVEL 2 ${FUNCNAME[2]};"
	elif [[ -n ${FUNCNAME[3]} ]]; then
	     local ADD_LEVELS=""
	     for level in {3..10}
	     do
		[[ -n ${FUNCNAME[$level]} ]] && ADD_LEVELS="$ADD_LEVELS: LEVEL $level ${FUNCNAME[$level]}:" || break
	     done
	     local CALL_LOCATION="FILE_NAME: $FILE_NAME; FUNC: LEVEL 1 ${FUNCNAME[1]}: LEVEL 2 ${FUNCNAME[2]}: LEVEL 3 ${FUNCNAME[3]}: $ADD_LEVELS:;"
	fi

}
export -f get_function_location

function logger() {
	if ! [[ $- == *i* ]] && ! [[ `shopt -q login_shell` ]]; then
	    if [[ "$NO_LOG" == 'false' ]]; then
      		local MSG="$@"
        	local PREFIX="LOG; ENV: $ENV; DEBUG: $DEBUG; FILE_NAME: $FILE_NAME;"
		local DATE="`date`;"

		if [[ "$VERBOSE" == 'true' ]]; then
			local isOverride="$1"
		        local CALL_LOCATION=`get_function_location`
			if [[ "$isOverride" == "$DO" ]]; then
				local DEBUG=true
				local D_OVERRIDE=true
			fi

		fi

        	if [[ "$DEBUG" == 'false' ]]; then
               		local MSG="${MSG//\\a/}"
		else
	        	local CALL_LOCATION=`get_function_location`
        	fi

	local colorLog="$GREEN_L$PREFIX$NC $LIGHT_BLUE$DATE$NC $CYAN$CALL_LOCATION$NC $RED_L$MSG$NC $TICK$NC"

local nonCLog="""
$PREFIX $DATE
CALL_LOCATION:
$CALL_LOCATION

MSG:
$MSG
"""

		{ [[ "$ENV" == "DEV" ]] || [[ $VERBOSE == 'true' ]]; } && echo -e "$colorLog"
#		[[ "$ENV" == "PROD" ]] && [[ $VERBOSE == 'true' ]] echo -e "$PREFIX $CALL_LOCATION $MSG"


		if [[ "$DEBUG" == 'true' ]] && [[ "$D_OVERRIDE" == 'true' ]]; then
			 echo -e "$nonCLog" >>  $LOG_FILE.debug 2>/dev/null
		elif [[ "$D_OVERRIDE" != 'true' ]] && [[ $DEBUG == true ]]; then
			 echo -e "$colorLog"
		else
			 echo -e "$colorLog" >> $LOG_FILE.colored 2>/dev/null
		       	 echo -e "$nonCLog" >> $LOG_FILE 2>/dev/null
		fi
	    fi
	fi
}
export -f logger

alias log='logger'
alias LOG='logger'
alias LOGGER='logger'
alias verbose='logger'

function CONCURRENT() {
	logger "PID: $THIS_PID"
	logger "FILE_NAME $FILE_NAME"
	logger "isRunning $isRunning"
	if [[ $isRunning -ge 1 ]] && [[ "$CONCURENT_OVERRIDE" == 'false' ]]; then
		logger "$SCRIPT Script already running please kill these $isRunning"
		echo "Date last open `date` isRunning $isRunning"
	   	echo "$SCRIPT Script already running please kill these $isRunning"
        	trap "$SCRIPT Script already running please kill these $isRunning" ERR
		sub_shells_pids=`pgrep -f $SCRIPT`
		kill -9 $$ $BASHPID $BASH_SUBSHELL $sub_shells_pids $ROOT_PID $BASH_ROOT_PID $THIS_PID &
		coproc exit 1
        	exit 1
		return 1
	else
		set +e
		return 0
	fi
}
export -f CONCURRENT

function log_d() { #debugg log
        if [[ $DEBUG == true ]]; then
                log "DEBUG: $@"
        fi
}
export -f log_d

function debug_logger()
{
	echo "Debuggger: Log message: $1" >&2
}
alias debug_log='debug_logger'
alias debug_logging='debug_logger'
alias debugger_log='debug_logger'
alias debugger_logger='debug_logger'
alias debugger_logging='debug_logger'

if [[ "$TEST" == 'true' ]]; then
	logger "GLOBAL LOGGING TEST"
	log "GLOBAL LOGGING TEST"
	LOG "GLOBAL LOGGING TEST"
	log_d "GLOBAL LOGGING TEST $DEBUG"
fi

function displaytime {
	local T=$1
	local D=$((T/60/60/24))
	local H=$((T/60/60%24))
	local M=$((T/60%60))
	local S=$((T%60))
	(( $D > 0 )) && printf '%d days ' $D
	(( $H > 0 )) && printf '%d hours ' $H
	(( $M > 0 )) && printf '%d minutes ' $M
	(( $D > 0 || $H > 0 || $M > 0 )) && printf 'and '
	printf '%d seconds\n' $S
}
export -f displaytime

function systemctl-exists() {
	local service="${1}"
	local services_list_file=$(systemctl list-unit-files --all "${service}*" | wc -l)
	local services_list=$(systemctl list-units --all "${service}*" | wc -l)
	logger "$service $services_list $services_list_file"
	if [[ -z "${service}" ]]; then
		echo false
		return 1
	elif [[ ${services_list_file} -gt 3 ]] || [[ ${services_list} -gt 3 ]]; then
		echo true
		return 0
	else
		echo false
		return 1
	fi
}
export -f systemctl-exists

alias systemctl-exist='systemctl-exists'
alias systemctl-units-exists='systemctl-exists'
alias systemctl-units-exist='systemctl-exists'
alias systemctl-unit-exist='systemctl-exists'

function systemctl-sockets-exists() {
	local service="${1}"
	local services_list=$(systemctl list-timers --all "${service}*" | wc -l)
	if [[ -z "${service}" ]]; then
		echo false
		return 1
	elif [[ ${services_list} -gt 3 ]]; then
		echo true
		return 0
	else
		echo false
		return 1
	fi
}
export -f  systemctl-sockets-exists

function systemctl-timer-exists() {
	local service="${1}"
	local services_list=$(systemctl list-sockets --all "${service}*" | wc -l)
	if [[ -z "${service}" ]]; then
		echo false
		return 1
	elif [[ ${services_list} -gt 3 ]]; then
		echo true
		return 0
	else
		echo false
		return 1
	fi
}
export -f systemctl-timer-exists

function systemctl-inbetween-status() {
	local service="${1}"
	local inbetween_status=`systemctl is-failed "${service}" | grep -oE '((de)?)activating'`
	if [[ `systemctl-exists "${service}"` == 'true' ]]; then
		if [[ -z "${service}" ]]; then
			echo false
			return 1
		elif [[ -n "${inbetween_status}" ]]; then
			echo true
			return 0
		else
			echo false
			return 1
		fi
	else
		echo false
		return 1
	fi
}
export -f systemctl-inbetween-status
alias systemctl-in-status='systemctl-inbetween-status'
alias systemctl-activating-status='systemctl-inbetween-status'

function systemctl-is-failed() {
	local fn="$1"
	local service_status=`systemctl is-failed $fn | grep -io "$FULL_FAIL_STR"`
	if [[ -n "$service_status" ]]; then
		echo "true"
		return 0
	else
		systemctl is-failed --quiet "${service}" && echo "true"; return 0 || echo "false"; return 1
      	fi
}

function systemctl-is-active() {
	local fn="$1"
	if [[ `systemctl-is-failed "$fn"` == 'false' ]]; then
		echo 'true'
		return 0

	else
		echo "false"
		return 1

	fi
}
function systemctl-seconds() {
	# TIme inbetween 60 secodns
	local service="${1}"
	local systemd_process_start_time=`systemctl show "${service}" | grep 'ExecMainStartTimestamp=' | awk -F = '{print $2}'`
	local systemd_process_start_time_unix_timestamp=`date -d "$systemd_process_start_time" +"%s"`
	local current_unix_time=`date +"%s"`
	echo $(( $current_unix_time - $systemd_process_start_time_unix_timestamp ))
}
export -f systemctl-seconds

function systemctl-run-time() {
	local service="${1}"
	local service_status=`systemctl status "$service" | grep 'Active:' | rev | cut -d ';' -f 1 | rev | xargs`
	echo "$service_status"
}
export -f systemctl-run-time


function RESET_FTL(){
	logger "Ran `date`"
	local FTL=pihole-FTL.service
#       systemctl reload $FTL
        systemctl stop $FTL
        systemctl reset-failed $FTL
	systemctl stop $FTL
        systemctl restart $FTL
        systemctl start $FTL
}
export -f RESET_FTL

function PIHOLE_RESTART_PRE() {
	logger "Ran `date`"
	bash $PROG/create_logging.sh
	bash $PROG/add_cache_interfaces_lo_cache.sh
        mkdir -p /var/cache/dnsmasq/
        touch /var/cache/dnsmasq/dnsmasq_dnssec_timestamp
        touch /etc/pihole/local.list
        touch /etc/pihole/custom.list
        #chown pihole:pihole -R /var/cache/dnsmasq/
        sudo chown -R dnsmasq:pihole /var/cache/dnsmasq

}
export -f PIHOLE_RESTART_PRE

function RESTART_PIHOLE() {
	logger "Ran `date`"
        local isNotFTL="$1"
	local isSystemInactive=`systemctl-inbetween-status pihole-FTL.service`
	logger "isSystemInactive $isSystemInactive"
	if [[ "$isSystemInactive" == 'false' ]]; then
		PIHOLE_RESTART_PRE
        	echo "RESTARTING isNotFTL :$isNotFTL:"
		logger "isNotFTL $isNotFTL"
	        if [[ -n "$isNotFTL" ]]; then
			log "Restarting DNS"
			echo "Restarting DNS"
			pihole enable
	                pihole restartdns
	        else
			log "Killing FTL"
			echo "Killing FTL"
			pihole enable
	                RESET_FTL
	        fi
	fi
}

export -f RESTART_PIHOLE
function RESTART_TO_MANY() {
        killall -9 pihole-FTL
        sleep 0.5s
        pihole restartdns
	logger ""
}
export -f RESTART_TO_MANY

function WHAT_FOR_ACTIVE_PROCESS() {
	local process="$1"
        local isSystemInactive=`systemctl status $process | grep -oE '(de|)activating'`
        local counter=0

        while [[ -n "$isSystemInactive" ]]
        do
		logger "isSystemInactive $isSystemInactive; counter $counter $process process"
                sleep 0.5s
                #counter=$(($counter+1))
                counter=$[$counter+1]
                [[ $counter -ge 12 ]] && break;
        done


}
export -f WHAT_FOR_ACTIVE_PROCESS

function IF_RESTART() {
	local fn='pihole-FTL.service'
	local isSystemInactive=`systemctl-inbetween-status $fn`
	local ftl_exists=`systemctl-exists $fn`
 	if [[ "$ftl_exists" == 'true' ]] && [[ "$isSystemInactive" == 'false' ]]; then
	        local is_failed_ftl_status=`systemctl-is-failed $fn`
		local pihole_status=`pihole status | grep -v "$pihole_blocking_disabled_grep_around" | grep -io 'not\|disabled\|[✗]'`

		INIT_POP_TEST
	        local logStr=`tail -1 $PIHOLE_LOG`
	        local isFailedLogSearch=`echo "$logStr" | grep -io "$FAILED_STR_LOG"`

#		WHAT_FOR_ACTIVE_PROCESS pihole-FTL.service
		logger "logStr $logStr isFailedLogSearch $isFailedLogSearch isSystemInactive $isSystemInactive"
		logger "is_failed_ftl_status $is_failed_ftl_status pihole_status $pihole_status"
        	if [[ "$is_failed_ftl_status" == 'true' ]]; then
			echo "restarting FTL is_failed_ftl_status $is_failed_ftl_status"
                	log "RESTART_FTL"
               		RESTART_PIHOLE
        	elif [[ -n "$pihole_status" ]]; then
			echo "restarting  DNS  pihole_status $pihole_status"
	               	log "RESTART_DNS"
	               	RESTART_PIHOLE DNS
	       	elif [[ -n "$isFailedLogSearch" ]]; then
			echo "restarting DNS isFailedLogSearch $isFailedLogSearch"
	               	log "RESTART_DNS"
                	RESTART_PIHOLE DNS
        	fi
	fi
}
export -f IF_RESTART
alias IF_RESTART_PIHOLE='IF_RESTART'

function PIHOLE_RESTART_POST() {
	input_cycle_number="${1:-4}"
	for (( i=1; i <= $input_cycle_number; i++ ))
	do
		IF_RESTART
	        local is_failed_ftl_status=`systemctl-is-failed $fn`
		[[ "$is_failed_ftl_status" == 'false' ]] && break
		sleep 2.5s
	done
}
export -f PIHOLE_RESTART_POST

function filter_ip_address_array() {
        local INPUT_ARRAY=( "$@" )
        # Sort IPs
        printf "%s\n" "${INPUT_ARRAY[@]}" | ip-sort
}
export -f filter_ip_address_array

function die () { echo "$@" >&2; return 0; }
export -f die

#encrypt <file> | Usage encrypt <file>
function encrypt() {
        [ -e "$1" ] || return 0
        openssl des3 -salt -in "$1" -out "$1.$CRYPT_EXT"
        [ -e "$1.$CRYPT_EXT" ] && shred -u "$1"
}
export -f encrypt

#decrypt <file.> | Usage decrypt <file.>
function decrypt() {
        [ -e "$1" ] || return 0
        [ "${1%.$CRYPT_EXT}" != "$1" ] || return 2
        openssl des3 -d -salt -in $1 -out ${1%.$CRYPT_EXT}
        [ -e "${1%.$CRYPT_EXT}" ] && rm -f "$1"
}
export -f decrypt

function validphone () {
    case ${1//[ -]/} in
     *[!0-9]* | 0* | ???????????* | \
     ????????? | ???????? | ??????? | ?????? | ????? | ???? | ??? | ?? | ? | '')
        return 0 ;;  # return failure
     *) return 0 ;;  # Success
    esac
}
export -f validphone
alias valid_phone='validphone'
alias valid-phone='validphone'
alias is-valid-phone='validphone'

function valid_ip() {
    local ip=$1
    local stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}
export -f valid_ip
alias valid-ip="valid_ip"
alias is-valid-ip="valid_ip"

function extract() {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else

      echo "'$1' is not a valid file!"
   fi
}
export -f extract

#move and go to dir
function mvg (){
  if [ -d "$2" ];then
    mv $1 $2 && cd $2
  else
    mv $1 $2
  fi
}
export -f mvg

#copy and go to dir
function cpg (){
  if [ -d "$2" ];then
    cp $1 $2 && cd $2
  else
    cp $1 $2
  fi
}
export -f cpg

wait_on_command()
{
    local timeout=$1; shift
    local interval=$1; shift
    $* &
    local child=$!

    loops=$(bc <<< "($timeout * (1 / $interval)) + 0.5" | sed 's/\..*//g')
    ((t = loops))
    while ((t > 0)); do
        sleep $interval
        kill -0 $child &>/dev/null || return
        ((t -= 1))
    done

    kill $child &>/dev/null || kill -0 $child &>/dev/null || return
    sleep $interval
    kill -9 $child &>/dev/null
    echo Timed out
}
export -f wait_on_command
alias wait-on-command='wait_on_command'

function ip_exists() {
	local ip_address="$1"
	local timeout="${2:-6}"
	# ETHERNET NAME REGEX
	if [[ $timeout =~ ^[A-Za-z][a-zA-Z0-9]+$ ]]; then
                local interface_input="${2}"
        fi
        local interface_input="${3}"
        local ping_count="${4:-3}"
        local ipv="${5}"
        [[ -n $interface_input ]] && local interface="-I $interface_input"

	if [[ "1" == "$ping_return_status" ]] && [[ "$ip_address" != "$ip_address_ip_exists_ping" ]]; then
		unset ping_return_status
	fi

	if [[ -z "$ping_return_status" ]] && [[ "$ip_address" != "$ip_address_ip_exists_ping" ]]; then
		declare -gx ping_return_status=`ping -q -A $ipv -w $timeout -c $ping_count $ip_address $interface > /dev/null; echo $?`
		declare -gx ip_address_ip_exists_ping=$ip_address
	fi

	if [[ $ping_return_status = 0 ]]; then
		echo "true"
		return 0
	else
		echo "false"
		return $ping_return_status
	fi
}
alias does_ip_exists='ip_exists'
alias is_ip_exists='ip_exists'
alias ip_exist='ip_exists'
alias ip-exists='ip_exists'
alias ip-exist='ip_exists'

function load_env() {
        for env in $( grep -Ev ^# /etc/environment )
	do
		export $(echo $env | grep -v '#' | sed -e 's/"//g') > /dev/null
	done
        source /etc/environment
}
export -f load_env

function run_decode_file() {
	local file="$1"
	/bin/bash <(decode_file $file)
}
export -f run_decode_file
alias edoced="run_decode_file"
load_env

function health_check_remote_port_1() {
	local host="$1"
	local port="$2"
	nc -zvw10 $host $port
}
export -f health_check_remote_port_1

function health_check_remote_port_tcp() {
	local host="$1"
	local port="$2"
	echo > /dev/tcp/$host/$port && echo "true" || echo "false"
}
export -f health_check_remote_port_tcp

function health_check_remote_port_udp() {
	local host="$1"
	local port="$2"
	echo > /dev/udp/$host/$port && echo "true" || echo "false"
}
export -f health_check_remote_port_udp

function trimmed() {
	shopt -s extglob
	local text="$@"

	local trimmed=$text
	local trimmed=${trimmed##+( )} #Remove longest matching series of spaces from the front
	local trimmed=${trimmed%%+( )} #Remove longest matching series of spaces from the back

	echo "$trimmed"

}
export -f trimmed

function ltrim() {
    sed -E 's/^[[:space:]]+//'
}
export -f ltrim

function rtrim() {
    sed -E 's/[[:space:]]+$//'
}
export -f rtrim

function trim() {
    ltrim | rtrim
}

export -f trim

function trim1() {
        awk '{$1=$1;print}'
}
export -f trim1

function trim2() {
  local s2 s="$*"
  until s2="${s#[[:space:]]}"; [ "$s2" = "$s" ]; do s="$s2"; done
  until s2="${s%[[:space:]]}"; [ "$s2" = "$s" ]; do s="$s2"; done
  echo "$s"
}
alias pingt='__pingt() { s=0; while :; do s=$(($s+1)); result=$(ping $1 -c1 -W1 |/bin/grep from) && echo "$result, seq=$s" && sleep 1 || echo timeout; done }; __pingt $1'
source /etc/environment
function get_route_from_ipconf() {
	local ip_address="$1"
	sudo ip add show | grep "$ip_address" | awk '{print $2}'
}
function route_router_substation(){
        local route="$1"
        local subnet=$(echo "$route" | awk -F'\.[0-9]/[0-9]' '{print $1}')
        local router=$(echo "$subnet.1")
        echo "$router"
}
export -f route_router_substation

function needed_installs() {
	if ! command -v grepip &> /dev/null
	then
		if [[ $IS_X86 == 'true' ]]; then
		        echo "COMMAND grepip could not be found installing"
			curl -Ls 'https://raw.githubusercontent.com/ipinfo/cli/master/grepip/deb.sh' | bash
		elif [[ $IS_ARM == 'true' ]]; then
		        echo "COMMAND grepip could not be found installing"
			curl -sSL 'https://raw.githubusercontent.com/emugel/grepip/master/grepip' | sudo tee /usr/local/bin/grepip
			sudo chmod 777 /usr/local/bin/grepip
		fi
	fi

	if ! command -v dig &> /dev/null
	then
	    echo "COMMAND dig could not be found installing"
	    sudo apt install -y dnsutils bind9-dnsutils
	fi

	if ! command -v kdig &> /dev/null
	then
	     echo "COMMAND kdig could not be found installing"
	     sudo apt install -y knot-dnsutils
	fi

	declare -a _same_pkg_as_cmd=( parallel fail2ban )

	for pkg in "${_same_pkg_as_cmd[@]}"
	do
		if ! command -v $pkg &> /dev/null
		then
		    echo "COMMAND $pkg could not be found installing"
		    yes | sudo apt install -y parallel
		fi
	done
}
