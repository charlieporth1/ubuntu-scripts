#!/bin/bash
shopt -s extglob
SERVICE=pihole-FTL.service
CONFIG_TEST_TIMEOUT=4
ARGS="$@"

PIHOLE_LOG=$LOG/pihole.log
LIST_REGEX='(list|regex)'

function pihole_ctp_dns_status() {
        source $PROG/all-scripts-exports.sh --no-log
        local mark_status=`systemctl is-active --quiet $SERVICE && echo "$TICK" || echo "$X"`
        echo -e "Active Status: `systemctl is-active $SERVICE` $mark_status"
        echo -e "Start time: `systemctl-run-time $SERVICE`"
        echo -e "Run time in seconds: `systemctl-seconds $SERVICE`"
}

export -f pihole_ctp_dns_status

if [ "$0" == "$BASH_SOURCE" ]; then
for i in "$@"; do
    case $i in
        --help | -h | --h | h | help ) shift; echo "$helpString" ; exit 0 ;;
        *qbl | --query-@(block|black)?(list)-log?(s) ) shift ;
                grep --color=auto -Ei "(black|block)($LIST_REGEX?)" $PIHOLE_LOG
        ;;
        *qal | *qwl | --query-@(allow|white)?(list)-log?(s) ) shift ;
                grep --color=auto -Ei "white$LIST_REGEX" $PIHOLE_LOG
        ;;
	--status | *status ) shift; pihole_ctp_dns_status ;;
	--source?(d) | *source ) shift ; echo "ctp-pihole.sh sourced";;
        * ) shift; echo "$helpString" ; exit 0 ;;
    esac
done

fi
