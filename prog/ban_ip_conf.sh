#!/bin/bash
source $PROG/all-scripts-exports.sh
source $PROG/create_ban_ignore_ip_list.sh
echo $IS_GCP

if [[ "$IS_GCP" == 'true' ]] && [[ -f $PROG/google_cloud_firewall.sh ]]; then
	source $PROG/google_cloud_firewall.sh
fi

export CONFIG_IP_SET_DIR=/etc/ipset
export CONFIG_IP_TABLES_DIR=/etc/iptables

export BAN_INGRORE_GREP_LIST=/tmp/$FILE_NAME.grep

! [[ -d $CONFIG_IP_SET_DIR ]] && mkdir -p $CONFIG_IP_SET_DIR
! [[ -d $CONFIG_IP_TABLES_DIR ]] && mkdir -p $CONFIG_IP_TABLES_DIR

export ROOT_IP_TABLES_FILE=$CONFIG_IP_TABLES_DIR/iptables-defalt.iptables
alias sort-abused-ip="ip-sort | grep -oE \"${IPV4_REGEX_SUBNET}\""

wait_time=5

ROOT_IP_FILE_DIR=/tmp/blocked_ip_address
! [[ -d $ROOT_IP_FILE_DIR ]]  && mkdir -p $ROOT_IP_FILE_DIR

FILE=/tmp/$FILE_NAME.grep

if ! [[ -f $FILE ]]; then
        bash $PROG/create_ban_ignore_ip_list.sh
fi

export INGORE_IP_ADRESSES=$( cat $FILE )

alias find-ip-block="grepip --exclude-reserved --only-matching | ip-sort | grep -v \"${INGORE_IP_ADRESSES}\""
IP_SUBNET_COUNT=600000
IPSET_HASH_SIZE=$(( $IP_SUBNET_COUNT * 3 ))

function load_file() {
	local file_path="$1"
	echo "Filtering dub ip address"
	perl -i -ne 'print if ! $x{$_}++' $file_path
	echo "Done dub ip address"

	echo "Filtering already added ip address"
#	awk 'NR == FNR{ a[$0] = 1;next } !a[$0]' $IPSET_FILE_FULL $file_path > $file_path.tmp
	# https://www.unix.com/shell-programming-and-scripting/98581-comparing-2-files-return-unique-lines-first-file.html
	awk 'NR==FNR{a[$0];next}!($0 in a)' $file_path $IPSET_FILE_FULL > $file_path.tmp
	echo "Done already added ip address"
	cat $full_url_file_path.tmp | sort-abused-ip > $file_path

	if [[ "$IS_GCP" == 'true' ]] && [[ -f $PROG/google_cloud_firewall.sh ]]; then
		source $PROG/google_cloud_firewall.sh
#		echo "Starting GCP Firewall process"
#		ban_gcloud_firewall_rule_source_range "$IPSET_BK_NAME" "$full_url_file_path"
		mapfile -t ban_ips < $file_path
		declare -agx ban_ips=( ${ban_ips[@]} )
	else
		echo "Starting IP TablesFirewall process"
		mapfile -t ban_ips < $file_path
		declare -agx ban_ips=( ${ban_ips[@]} )
	fi

}

function load_url_to_file() {
	local url="$1"
	local url_file_name="${2:-$IPSET_BK_NAME}"
	echo "Downloading $url to $url_file_name"
	declare -gx full_url_file_path=$ROOT_IP_FILE_DIR/$url_file_name
	#curl $url -o $full_url_file_path
	wget "$url" -O $full_url_file_path
	load_file $full_url_file_path
}

function create_ip-set-allow() {
        local LIST_NAME="$1"
	local LIST_TYPE="${2:-put-type-of-alowlist-here}"

        declare -gx IPSET_BK_NAME=$(echo $LIST_TYPE-alwlst-$LIST_NAME | cut -c -31)
        declare -gx IPSET_FILE=$IPSET_BK_NAME.ipset
        declare -gx IPSET_FILE_FULL=$CONFIG_IP_SET_DIR/$IPSET_FILE

        echo $IPSET_BK_NAME $IPSET_FILE

	IP_SUBNET_COUNT=5000
	IPSET_HASH_SIZE=$(( $IP_SUBNET_COUNT * 3 ))
        sudo ipset create $IPSET_BK_NAME family inet hash:net hashsize $IPSET_HASH_SIZE
        sudo iptables -I OUTPUT -m set --match-set $IPSET_BK_NAME src -j ACCEPT --wait $wait_time
        sudo iptables -I INPUT -m set --match-set $IPSET_BK_NAME src -j ACCEPT --wait $wait_time
        sudo iptables -I FORWARD -m set --match-set $IPSET_BK_NAME src -j ACCEPT --wait $wait_time

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

        declare -gx IPSET_BK_NAME=$(echo $LIST_TYPE-blklst-$LIST_NAME | cut -c -31)
        declare -gx IPSET_FILE=$IPSET_BK_NAME.ipset
        declare -gx IPSET_FILE_FULL=$CONFIG_IP_SET_DIR/$IPSET_FILE


        echo $IPSET_BK_NAME $IPSET_FILE

        sudo ipset create $IPSET_BK_NAME hash:net hashsize $IPSET_HASH_SIZE
        sudo iptables -I INPUT -m set --match-set $IPSET_BK_NAME src -j DROP --wait $wait_time
        sudo iptables -I FORWARD -m set --match-set $IPSET_BK_NAME src -j DROP --wait $wait_time

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
export -f create_ip-set-net-block

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

function run_ip-set-block() {
	local url="$1"
	load_url_to_file "$url"

	for ip in "${ban_ips[@]}"
	do
        	ipset add $IPSET_BK_NAME $ip

	done
	save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL
}

export -f run_ip-set-block

function run_ip-set-block-file() {
	local full_url_file_path="$1"
	load_file $full_url_file_path

	for ip in "${ban_ips[@]}"
	do
        	ipset add $IPSET_BK_NAME $ip

	done
	save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL
}

export -f run_ip-set-block
