#!/bin/bash
source /etc/environment
shopt -s extglob
SERVICE=pihole-FTL.service
CONFIG_TEST_TIMEOUT=4
ARGS="$@"

PIHOLE_LOG=$LOG/pihole.log
LIST_REGEX='(list|regex)'

function pihole_ctp_dns_status() {
        source $PROG/all-scripts-exports.sh --no-log
        local mark_status=`systemctl is-active --quiet $SERVICE && echo "$TICK" || echo "$X"`
	local service_status=$(systemctl status $SERVICE | grep "")
        local service_memory_usage=$(printf '%s\n' "$service_status" | grep -i mem | awk -F: '{print $2}')

	echo -e "Active Status: `systemctl is-active $SERVICE` $mark_status"
        echo -e "Start time: `systemctl-run-time $SERVICE`"
        echo -e "Run time in seconds: `systemctl-seconds $SERVICE`"
	echo -e "RAM Usage: $service_memory_usage"
}

export -f pihole_ctp_dns_status

function config_test_human() {
        local config_test_dir="${1}"
	echo "Running Config test"
	echo "Running Pihole DNSMASQ test"
	sudo pihole-FTL debug dnsmasq-test
	echo Exit Code: $?
	echo "Running PiHole FTL test"
	sudo pihole-FTL debug test
	echo Exit Code: $?
}

if [ "$0" == "$BASH_SOURCE" ]; then
for i in "$@"; do
    case $i in
        --help | -h | --h | h | help ) shift; echo "$helpString" ; exit 0 ;;
        -q=* | --query=* | --query-log?(s)=* ) shift ; setup_tail_logs ; QUERY="${i#*=}"; grep --color=auto "$QUERY" $CTP_DNS_LOG_DIR/$LOG_FILE;;
	*qbl | --query-@(block|black)?(list)-log?(s) ) shift ;
                grep --color=auto -Ei "(black|block)($LIST_REGEX?)" $PIHOLE_LOG
        ;;
        *qal | *qwl | --query-@(allow|white)?(list)-log?(s) ) shift ;
                grep --color=auto -Ei "white$LIST_REGEX" $PIHOLE_LOG
        ;;
	*cth | *cht | --config-test-human ) shift ; config_test_human;;
	--status | *status ) shift; pihole_ctp_dns_status ;;
	--source?(d) | *source ) shift ; echo "ctp-pihole.sh sourced";;
	-l | -t |  --tail | --log | *tail ) shift ; bash $PROG/pihole-f.sh;;
	--@(tail|log)-FTL ) shift ; tail -f $LOG/pihole-FTL.log;;
        * ) shift; echo "$helpString" ; exit 0 ;;
    esac
done

fi
