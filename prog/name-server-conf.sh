#!/bin/bash
shopt -s expand_aliases
export IP_REGEX="($IP_REGEX((#[0-9]{1,5})?))"

export TIMEOUT=4
export TRIES=2
export NUMBER_AND_DECSAML_REGEX="([0-9\.]{1,6})"

export SECONDS_REGEX='s(ec)?'
export MSECONDS_REGEX="m($SECONDS_REGEX)?"
export USECONDS_REGEX="u($SECONDS_REGEX)?"
export SECONDS_UNIT_REGEX="($SECONDS_REGEX|$MSECONDS_REGEX|$USECONDS_REGEX)"

export PIHOLE_FILE=$DNSMASQ/01-pihole.conf

export PIHOLE_ACTIVE_DNS=`grep -oE "server=$IP_REGEX" $PIHOLE_FILE | grepip -o4 | ip-sort`
export PIHOLE_ACTIVE_DNS_GREPIFY=`bash $PROG/grepify.sh $PIHOLE_ACTIVE_DNS`

export QUAD_LIST_DNS_SERVERS_OUT_FILE=/tmp/quad_dns_servers_list.txt
export DNS_LIST_FILE=$HOLE/custom-dns-server.conf
alias query_regex="grep -oE \"Query time: $NUMBER_AND_DECSAML_REGEX $SECONDS_UNIT_REGEX\""

function convert_time_seconds() {
        local amount_of_time="$1"
        local unit_of_time="$2"
        if [[ $unit_of_time =~ ($MSECONDS_REGEX) ]]; then
                local time_in_useconds=`bc <<< "$amount_of_time * 1000"`
                echo "$time_in_useconds"
        elif [[ $unit_of_time =~ ($SECONDS_REGEX) ]]; then
                local time_in_useconds=`bc <<< "$amount_of_time * 1000 * 60"`
                echo "$time_in_useconds"
        elif [[ $unit_of_time =~ ($USECONDS_REGEX) ]]; then
                echo "$amount_of_time"
        else
                echo ""
        fi
}
export -f convert_time_seconds

export MIN_QUERY_TIME_AMOUNT=`convert_time_seconds 35 m`
