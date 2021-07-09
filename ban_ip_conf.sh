#!/bin/bash
export CONFIG_IP_SET_DIR=/etc/ipset
export CONFIG_IP_TABLES_DIR=/etc/iptables

! [[ -d $CONFIG_IP_SET_DIR ]] && mkdir -p $CONFIG_IP_SET_DIR
! [[ -d $CONFIG_IP_TABLES_DIR ]] && mkdir -p $CONFIG_IP_TABLES_DIR

export ROOT_IP_TABLES_FILE=$CONFIG_IP_TABLES_DIR/iptables-defalt.iptables

function create_ip-set-allow() {
        local LIST_NAME="$1"
	local LIST_TYPE="${2:-put-type-of-blacklist-here}"

        declare -gx IPSET_BK_NAME=$LIST_TYPE-allowlist-$LIST_NAME
        declare -gx IPSET_FILE=$IPSET_BK_NAME.ipset
        declare -gx IPSET_FILE_FULL=$CONFIG_IP_SET_DIR/$IPSET_FILE

        echo $IPSET_BK_NAME $IPSET_FILE

        sudo ipset create $IPSET_BK_NAME hash:net hashsize 8192
        sudo iptables -I OUTPUT -m set --match-set $IPSET_BK_NAME src -j ALLOW
        sudo iptables -I INPUT -m set --match-set $IPSET_BK_NAME src -j ALLOW
        sudo iptables -I FORWARD -m set --match-set $IPSET_BK_NAME src -j ALLOW

        if [[ -f $IPSET_FILE_FULL ]]; then
                ipset restore < $IPSET_FILE_FULL
        else
                touch $IPSET_FILE_FULL
        fi
        sleep 1s

}
function create_ip-set() {
        local LIST_NAME="$1"
	local LIST_TYPE="${2:-put-type-of-blacklist-here}"

        declare -gx IPSET_BK_NAME=$LIST_TYPE-allowlist-$LIST_NAME
        declare -gx IPSET_FILE=$IPSET_BK_NAME.ipset
        declare -gx IPSET_FILE_FULL=$CONFIG_IP_SET_DIR/$IPSET_FILE


        echo $IPSET_BK_NAME $IPSET_FILE

        sudo ipset create $IPSET_BK_NAME hash:net hashsize 8192
        sudo iptables -I INPUT -m set --match-set $IPSET_BK_NAME src -j DROP
        sudo iptables -I FORWARD -m set --match-set $IPSET_BK_NAME src -j DROP

        if [[ -f $IPSET_FILE_FULL ]]; then
                ipset restore < $IPSET_FILE_FULL
        else
                touch $IPSET_FILE_FULL
        fi
        sleep 1s

}
function create_ip-set-net-block() {
	create_ip-set "$@"
}
export -f create_ip-set
export -f create_ip-set-net
function save_ip-set() {
	local list_name="${1:-$IPSET_BK_NAME}"
	local file="${2:-$IPSET_FILE_FULL}"
	ipset save $list_name > $file
}
export -f save_ip-set

function save_ip-tables() {
	local file="${2:-$ROOT_IP_TABLES_FILE}"
	sudo iptables-save > $file
}
export -f save_ip-tables
