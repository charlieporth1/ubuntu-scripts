#!/bin/bash
source $PROG/all-scripts-exports.sh
source $PROG/name-server-conf.sh
timeout=8
ROOT_DIR=$PROG/ctp-dns-pihole-middleware
! [[ -d $ROOT_DIR ]] && mkdir -p $ROOT_DIR



ROOT_FILE=$ROOT_DIR/route-dns.toml
GROUPS_FILE=$ROOT_DIR/groups.toml
RESOLVERS_FILE=$ROOT_DIR/resolvers.toml
LISTENERS_FILE=$ROOT_DIR/listeners.toml

PIHOLE_ALT_ACTIVE_DNS=`grep -oE "server=$IP_REGEX" $OUT_FILE_SERVERS | grepip -o4 | ip-sort`

declare -a resolvers
resolvers=(
	$PIHOLE_ALT_ACTIVE_DNS
	$PIHOLE_ACTIVE_DNS
)
resolvers=($(printf '%s\n' "${resolvers[@]}" | grep -v 127.0.0.1 | ip-sort))
resolver_start=well_known
group_start=$resolver_start-group
group_retry_start=$group_start-truncate-retry
group_group_title=$group_start-group
group_main=$group_start-main
group_unbound=$group_start-unbound


echo """# Generated by: $scriptName
# Generated at: `date`


# well known Resolver 127.0.0.1
[resolvers.$resolver_start-127-0-0-1-tcp]
address = \"127.0.0.1:5053\"
protocol = \"tcp\"
[resolvers.$resolver_start-127-0-0-1-udp]
address = \"127.0.0.1:5053\"
protocol = \"udp\"

# RETRY
[groups.$group_retry_start-127-0-0-1]
type = \"truncate-retry\"
resolvers = [ \"$resolver_start-127-0-0-1-udp\" ]
retry-resolver = \"$resolver_start-127-0-0-1-tcp\"

""" | sudo tee $RESOLVERS_FILE

for resolver_ip in ${resolvers[@]}
do
	ip_title=${resolver_ip//\./-}
	resolver_title=$resolver_start-$ip_title

echo """
# well known Resolver $resolver_ip
[resolvers.$resolver_title-tcp]
address = \"$resolver_ip:53\"
protocol = \"tcp\"
[resolvers.$resolver_title-udp]
address = \"$resolver_ip:53\"
protocol = \"udp\"

# RETRY
[groups.$group_retry_start-$ip_title]
type = \"truncate-retry\"
resolvers = [ \"$resolver_title-udp\" ]
retry-resolver = \"$resolver_title-tcp\"

""" | sudo tee -a $RESOLVERS_FILE

done


export WELL_KNOWN_RESOLVERS_LIST=$(grep -E "^.resolvers\..*$resolver_start.*" $RESOLVERS_FILE | awk -F. '{print $2}' | awk -F] '{print $1}')
export WELL_KNOWN_RESOLVERS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(printf '%s\n' "$WELL_KNOWN_RESOLVERS_LIST" ) --quotes --space))

export WELL_KNOWN_RESOLVERS_RETRY_LIST=$(grep -E "^.groups\..*$group_retry_start.*" $RESOLVERS_FILE | awk -F. '{print $2}' | awk -F] '{print $1}')
export WELL_KNOWN_RESOLVERS_RETRY=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(printf '%s\n' "$WELL_KNOWN_RESOLVERS_RETRY_LIST" ) --quotes --space))

SMALL_DNS_LIST='8.8.8.8\|8.8.4.4\|1.1.1.1\|1.0.0.1\|1.0.0.2\|1.1.1.2\|75.75.75.75\|75.75.76.76\|208.67.222.222\|208.67.220.220\|9.9.9.9\|149.112.112.112'
WELL_KNOWN_RESOLVERS_UNBOUND=$(printf '%s\n' "$WELL_KNOWN_RESOLVERS_RETRY" | grep "$SMALL_DNS_LIST"  )

declare -a WELL_KNOWN_RESOLVERS_ARRAY
WELL_KNOWN_RESOLVERS_ARRAY=( $WELL_KNOWN_RESOLVERS )

declare -a WELL_KNOWN_RESOLVERS_RETRY_ARRAY
WELL_KNOWN_RESOLVERS_RETRY_ARRAY=( $WELL_KNOWN_RESOLVERS_RETRY )

CUT_PARTS=8
AMOUNT_OF_LINES=$(printf '%s\n' "$WELL_KNOWN_RESOLVERS" | wc -l)
PART_PER_LINE=$(($AMOUNT_OF_LINES / $CUT_PARTS))

AMOUNT_OF_LINES_RETRY=$(printf '%s\n' "$WELL_KNOWN_RESOLVERS_RETRY" | wc -l)
PART_PER_LINE_RETRY=$(($AMOUNT_OF_LINES_RETRY / $CUT_PARTS))

echo """# Generated by: $scriptName
# Generated at: `date`
# CUT_PARTS $CUT_PARTS
# AMOUNT_OF_LINES $AMOUNT_OF_LINES
# PART_PER_LINE $PART_PER_LINE

""" | sudo tee $GROUPS_FILE

for i in $(seq 0 $(( $CUT_PARTS - 1)))
do
	c=$(( $i * $PART_PER_LINE ))
	cr=$(( $i * $PART_PER_LINE_RETRY ))

	DNS_LIST_PART=${WELL_KNOWN_RESOLVERS_ARRAY[@]:$c:$(( $CUT_PARTS ))}
	DNS_LIST_PART_RETRY=${WELL_KNOWN_RESOLVERS_RETRY_ARRAY[@]:$cr:$(( ( $CUT_PARTS / 2 ) ))}

echo """
# GROUP $i
# FALLBACK
[groups.$group_group_title-$i-fail-back]
resolvers = [
        $(bash $PROG/new_linify.sh $(printf '%s\n' "$DNS_LIST_PART"))
]
type = \"fail-back\"
reset-after = $timeout
servfail-error = true

# FASTEST
[groups.$group_group_title-$i-fastest]
resolvers = [
        $(bash $PROG/new_linify.sh $(printf '%s\n' "$DNS_LIST_PART_RETRY"))
]
type = \"fastest\"

""" | sudo tee -a $GROUPS_FILE

done


export WELL_KNOWN_RESOLVERS_GROUP_FAST_LIST=$(grep -E "^.groups\..*$group_group_title.*-fastest" $GROUPS_FILE | awk -F. '{print $2}' | awk -F] '{print $1}')
export WELL_KNOWN_RESOLVERS_GROUP_FAST=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(printf '%s\n' "$WELL_KNOWN_RESOLVERS_GROUP_FAST_LIST" ) --quotes --space))

export WELL_KNOWN_RESOLVERS_GROUP_FAIL_LIST=$(grep -E "^.groups..*$group_group_title.*-fail-back" $GROUPS_FILE | awk -F. '{print $2}' | awk -F] '{print $1}')
export WELL_KNOWN_RESOLVERS_GROUP_FAIL=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(printf '%s\n' "$WELL_KNOWN_RESOLVERS_GROUP_FAIL_LIST" ) --quotes --space))


echo """
# FALLBACK
[groups.$group_main-fail-rotate]
resolvers = [
        $WELL_KNOWN_RESOLVERS_GROUP_FAIL
]
type = \"fail-rotate\"
reset-after = $(( $timeout * 2 ))

servfail-error = true

# FASTEST
[groups.$group_main-fastest]
resolvers = [
	$WELL_KNOWN_RESOLVERS_GROUP_FAST
]
type = \"fastest\"
""" | sudo tee -a $GROUPS_FILE

echo """
[bootstrap-resolver]
address = \"1.1.1.1:853\"
protocol = \"dot\"

[groups.ctp-dns-cached]
type = \"cache\"
resolvers = [ \"ctp-dns-root-unbound\" ]
cache-flush-query = \"dns.ctptech.pihole.flush.cache.root.\"
cache-negative-ttl = 3600
cache-size = 20000
cache-answer-shuffle = \"round-robin\"

# Order matters
[groups.ctp-dns-root]
resolvers = [
	\"$group_main-fastest\",
	$WELL_KNOWN_RESOLVERS_GROUP_FAST,
	\"$group_main-fail-rotate\",
]
reset-after = 64
type = \"fail-back\"
servfail-error = true

[groups.ctp-dns-root-unbound]
resolvers = [
	\"$group_retry_start-127-0-0-1\",
	\"$resolver_start-127-0-0-1-udp\",
	\"$resolver_start-127-0-0-1-tcp\",
	$WELL_KNOWN_RESOLVERS_UNBOUND

]
reset-after = 64
type = \"fail-back\"
servfail-error = true

""" | sudo tee $ROOT_FILE

other_address=$(bash $prog/get_network_devices_ip_address.sh --lo | grep -E '192\.168\.[0-9]{1,3}\.1$')
listeners_start=ctp-dns-lis
local_list=$listeners_start-local


echo """# Generated by: $scriptName
# Generated at: `date`
# Listeners


[listeners.$local_list-udp]
address = \"127.0.0.1:5553\"
protocol = \"udp\"
resolver = \"ctp-dns-cached\"

[listeners.$local_list-tcp]
address = \"127.0.0.1:5553\"
protocol = \"tcp\"
resolver = \"ctp-dns-cached\"

[listeners.$listeners_start-other-udp]
address = \"$other_address:5553\"
protocol = \"udp\"
resolver = \"ctp-dns-cached\"

[listeners.$listeners_start-other-tcp]
address = \"$other_address:5553\"
protocol = \"tcp\"
resolver = \"ctp-dns-cached\"

""" | sudo tee $LISTENERS_FILE

