#!/bin/bash
source /etc/environment
ARGS="$@"
source $PROG/populae-log.sh
PIHOLE_LOG=$LOG/pihole.log

FILE_NAME=`echo $SCRIPT | rev | cut -d '.' -f 2  | rev`
isRunning=`bash $PROG/process_count.sh $FILE_NAME $THIS_PID`
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

[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(v|verbose)'` ]] && export VERBOSE=true || export VERBOSE=false
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(t|test)'` ]] && export TEST=true || export TEST=false

[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(co|mo|concurrent\-overrride|override|manaul|manual\-override|over)'` ]] && export CONCURENT_OVERRIDE=true || export CONCURENT_OVERRIDE=false

shopt -s expand_aliases
SCRIPT=`basename $0 | rev | cut -d '/' -f 1 | rev`
export progName=$SCRIPT
export scriptName=$SCRIPT
export script_name=$SCRIPT
DIR=`realpath . | rev | cut -d '/' -f 1 | rev`

alias isFTLRunning='bash $PROG/process_count.sh pihole-FTL'
export LOG_ROOT=${LOG:-/var/log/}
export LOG_DIR=$LOG_ROOT/$FILE_NAME
export LOG_FILE=$LOG_DIR/$SCRIPT-$ENV.log

export NC="\e[39m"
export TICK="$NC[\e[32m✔\e[0m]$NC"
export RED="\e[31m"
export RED_L="\e[91m"
export CYAN="\e[36m"
export GREEN_L="\e[92m"
export LIGHT_BLUE='\e[1;34m'
export THIS_PID=${BASHPID:-$$}



export IS_GCP=` [[ -n $( timeout 5 facter virtual | grep -o 'gce' ) ]] && echo true || echo false`
export IS_GCP_1=` [[ -n $( timeout 5 curl -s metadata.google.internal -i | grep 'Metadata-Flavor: Google' ) ]] && echo true || echo false`
export IS_AWS=`[[ -n $( timeout 5 curl -s http://169.254.169.254/latest/meta-data/hostname | grep -o 'ec2.internal' ) ]] && echo true || echo false`
export IS_BARE=`[[ -n $(  timeout 5 facter virtual | grep -o 'physical' ) ]] && echo true || echo false`
export IS_VM=`timeout 5 facter is_virtual`

[[ "$ENV" == "PROD" ]] && REDIRECT=/dev/null || REDIRECT=/dev/stdout

export IP_REGEX="((([0-9]{1,3})\.?){4})"
export IP_REGEX_FULL="(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])"

if ! command -v pihole &> /dev/null
then
        export IS_PIHOLE=true
        export IS_MASTER=true
        export MASTER=true

fi

DO=debug_override

function KILL_FILE() {
	bash $PROG/process_count.sh $FILE_NAME $THIS_PID pid | sed -n '2p' | cut -d ':' -f 2- | xargs kill -9 2>1 /dev/null
}
export -f KILL_FILE
function setupLogger() {
	! [[ -d $LOG_DIR ]] && mkdir -p $LOG_DIR/

	! [[ -f $LOG_FILE ]] && touch $LOG_FILE
	! [[ -f $LOG_FILE.colored ]] && touch $LOG_FILE.colored
	! [[ -f $LOG_FILE.debug ]] && touch $LOG_FILE.debug
}
export -f setupLogger
setupLogger
function logger() {
      	local MSG="$@"
        local PREFIX="LOG; ENV: $ENV; DEBUG: $DEBUG;"
	local DATE="`date`;"
        local CALL_LOCATION=""
        if [[ -n ${FUNCNAME[1]} ]] && { [[ -z ${FUNCNAME[2]} ]] || [[ ${FUNCNAME[2]} == 'main' ]]; }; then
	      local CALL_LOCATION="FUNC: ${FUNCNAME[1]};"
	elif [[ -n ${FUNCNAME[2]} ]] && { [[ -z ${FUNCNAME[3]} ]] || [[ ${FUNCNAME[3]} == 'main' ]]; }; then
	     local CALL_LOCATION="FUNC: LEVEL 1 ${FUNCNAME[1]}: LEVEL 2 ${FUNCNAME[2]};"
	elif [[ -n ${FUNCNAME[3]} ]]; then
	     local ADD_LEVELS=""
	     for level in {3..6}
	     do
		[[ -n ${FUNCNAME[$level]} ]] && ADD_LEVELS="$ADD_LEVELS: LEVEL $level ${FUNCNAME[$level]}:" || break
	     done
	     local CALL_LOCATION="FUNC: LEVEL 1 ${FUNCNAME[1]}: LEVEL 2 ${FUNCNAME[2]}: LEVEL 3 ${FUNCNAME[3]}: $ADD_LEVELS:;"
	fi

	if [[ $VERBOSE == 'true' ]]; then
		local isOverride="$1"
		if [[ "$isOverride" == "$DO" ]]; then
			 local DEBUG=true
			 local D_OVERRIDE=true
		fi

	fi

        if [[ $DEBUG == false ]]; then
               	local MSG="${MSG//\\a/}"
        fi

       	local colorLog="$GREEN_L$PREFIX$NC $LIGHT_BLUE$DATE$NC $CYAN$CALL_LOCATION$NC $RED_L$MSG$NC $TICK$NC"
	local nonCLog="$PREFIX $DATE $CALL_LOCATION $MSG"

	{ [[ "$ENV" == "DEV" ]] || [[ $VERBOSE == 'true' ]]; } && echo -e "$colorLog"
#	[[ "$ENV" == "PROD" ]] && [[ $VERBOSE == 'true' ]] echo -e "$PREFIX $CALL_LOCATION $MSG"


	if [[ "$DEBUG" == 'true' ]] && [[ "$D_OVERRIDE" == 'true' ]]; then
		 echo -e "$nonCLog" >> $LOG_FILE.debug
	elif [[ "$D_OVERRIDE" != 'true' ]] && [[ $DEBUG == true ]]; then
		 echo -e "$colorLog"
	else
		 echo -e "$colorLog" >> $LOG_FILE.colored
	       	 echo -e "$nonCLog" >> $LOG_FILE
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
	if [[ $isRunning -ge 1 ]] && [[ $CONCURENT_OVERRIDE == false ]]; then
		logger "$SCRIPT Script already running please kill these $isRunning"
		echo "Date last open `date`"
	   	echo "$SCRIPT Script already running please kill these $isRunning"
		set -e
        	exit 1
	else
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

if [[ $TEST == 'true' ]]; then
	logger "GLOBAL LOGGING TEST"
	log "GLOBAL LOGGING TEST"
	LOG "GLOBAL LOGGING TEST"
	log_d "GLOBAL LOGGING TEST $DEBUG"
fi

function RESET_FTL(){
#		local FTL=alt-pihole-FTL.service
		if [[ `isFTLRunning` -ge 1 ]]; then
			sudo killall pihole-FTL
			[[ `isFTLRunning` -ge 1 ]] && ps -aux | grep pihole-FTL | grep -v 'grep' | awk '{print $2}' | xargs sudo kill -9 > /dev/null 2>1
		fi
		local FTL=pihole-FTL.service
#                systemctl reload $FTL
                systemctl stop $FTL
                systemctl reset-failed $FTL
                systemctl stop $FTL
                systemctl restart $FTL
#                systemctl start $FTL
}
export -f RESET_FTL
function RESTART_PIHOLE() {
        local isNotFTL="$1"
        echo "RESTARTING isNotFTL :$isNotFTL:"
        if [[ -n "$isNotFTL" ]]; then
		log "Restarting DNS"
		echo "Restarting DNS"
                pihole restartdns
        else
		log "Killing FTL"
		echo "Killing FTL"
                RESET_FTL
        fi
        sleep 0.250s
}
export -f RESTART_PIHOLE
function RESTART_TO_MANY() {
        killall -9 pihole-FTL
        sleep 0.5s
        pihole restartdns
}
export -f RESTART_TO_MANY
function WHAT_FOR_ACTIVE_PROCESS() {
	local process="$1"
        local isSystemInactive=`systemctl status $process | grep -oE '(de|)activating'`
        local counter=0

        while [[ -n "$isSystemInactive" ]]
        do
                sleep 0.5s
                #counter=$(($counter+1))
                counter=$[$counter+1]
                [[ $counter -ge 12 ]] && break;
        done


}
export -f WHAT_FOR_ACTIVE_PROCESS
function IF_RESTART() {
        local FAILED_STR="fail\|FAILURE\|SIGTERM\|SERVFAIL\|inactive\|config error is REFUSED"

        local is_failed_ftl_status=`systemctl is-failed pihole-FTL.service | grep -io "$FAILED_STR"`
	local pihole_status=`pihole status | grep -io 'not\|disabled\|[✗]'`

        local logStr=`tail -6 $PIHOLE_LOG`
        local isFailedLogSearch=`echo "$logStr" | grep -io "$FAILED_STR"`


	WHAT_FOR_ACTIVE_PROCESS pihole-FTL.service
	if [[ -z "$isSystemInactive" ]]; then
        	if [[ -n "$is_failed_ftl_status" ]]; then
                	log "RESTART_FTL"
               		RESTART_PIHOLE
        	elif [[ -n "$pihole_status" ]]; then
                	log "RESTART_DNS"
                	RESTART_PIHOLE DNS
        	elif [[ -n "$isFailedLogSearch" ]]; then
                	log "RESTART_DNS"
                	RESTART_PIHOLE DNS
        	fi
	fi
}
export -f IF_RESTART

function systemctl-exists() {
#  [ $(systemctl list-unit-files "${1}*" | wc -l) -gt 3 ]
	local service="${1}"
	local services_list=$(systemctl list-unit-files "${service}*" | wc -l)
	if [[ -z "${service}" ]]; then
		echo false
	elif [[ ${services_list} -gt 3 ]]; then
		echo true
	else
		echo false
	fi
}
export -f systemctl-exists

function systemctl-inbetween-status() {
	local service="${1}"
	local inbetween_status=`systemctl is-failed "${service}" | grep -oE '(de|)activating'`
	if [[ -z "${service}" ]]; then
		echo false
	elif [[ -n "${inbetween_status}" ]]; then
		echo true
	else
		echo false
	fi
}
export -f systemctl-inbetween-status

function filter_ip_address_array() {
        local INPUT_ARRAY=( "$@" )
        # Sort IPs
        printf "%s\n" "${INPUT_ARRAY[@]}" | sort -t . -k 3,3n -k 4,4n | uniq | sort -u
}

export -f filter_ip_address_array
function round() {
    printf "%.${2:-0}f" "$1"
}
export -f round

function die () { echo "$@" >&2; exit 1; }
export -f die

#encrypt <file> | Usage encrypt <file>
function encrypt() {
        [ -e "$1" ] || return 1
        openssl des3 -salt -in "$1" -out "$1.$CRYPT_EXT"
        [ -e "$1.$CRYPT_EXT" ] && shred -u "$1"
}
export -f encrypt
#decrypt <file.> | Usage decrypt <file.>
function decrypt() {
        [ -e "$1" ] || return 1
        [ "${1%.$CRYPT_EXT}" != "$1" ] || return 2
        openssl des3 -d -salt -in $1 -out ${1%.$CRYPT_EXT}
        [ -e "${1%.$CRYPT_EXT}" ] && rm -f "$1"
}
export -f decrypt
function validphone () {
    case ${1//[ -]/} in
     *[!0-9]* | 0* | ???????????* | \
     ????????? | ???????? | ??????? | ?????? | ????? | ???? | ??? | ?? | ? | '')
        return 1 ;;  # Return failure
     *) return 0 ;;  # Success
    esac
}
export -f validphone

function valid_phone() {
	validphone $1
}
export -f valid_phone

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
