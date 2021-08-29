#!/bin/bash
source /etc/environment
ARGS="$@"
COPY_FILE="$1"
GRAVITY=gravity.db
DB_FILE=$HOLE/$GRAVITY
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(full-update|full|full-after)'` ]] && export FULL_AFTER=true || export FULL_AFTER=false

function query_test() {
	local gravity_file="$1"
	local query_str="$(uuidgen)--salty"
	local match_str="  [i] No results found for $query_str within the block lists"
	local error_query_file=/tmp/pihole_query_test.tmp.txt
	local db_status_query=`pihole -q $query_str 2> >(sudo tee $error_query_file)`
	local grep_around_query_test="Error: database is locked\|Error: UNIQUE constraint failed: domainlist.domain, domainlist.type"
	if [[ -z $(cat $error_query_file | grep -v "$grep_around_query_test") ]] && [[ -f $gravity_file ]] && [[ $gravity_file == $DB_FILE ]]; then
		echo "true"
		return 0
        else
              	echo "false"
		return 1
        fi
}

function integrity_test() {
        local db_file="${1:-$DB_FILE}"
        local OK_STR='ok'
	local db_status_quick_light=`sudo sqlite3 $db_file "PRAGMA quick_check" | grep -io "$OK_STR"`
	if [[ -f $db_file ]]; then
		if [[ "$db_status_quick_light" == "$OK_STR" ]]; then
		       	local db_status=`sudo sqlite3 $db_file "PRAGMA integrity_check" | grep -io "$OK_STR"`
	        	if [[ "$db_status" == "$OK_STR" ]]; then
	               		echo "true"
				return 0
			else
				echo "false"
				return 1
			fi
	        else
	               	echo "false"
			return 1
		fi
        else
               	echo "false"
		return 1
	fi

}

function is_gravity_ok() {
        local db_file="${1:-$DB_FILE}"
	if [[ $db_file == $DB_FILE ]]; then
		if [[ `query_test` == 'true' ]]; then
			local result=`integrity_test $db_file`
			echo $result
			return $?
		else
			echo "false"
			return 1
		fi
	else
		local result=`integrity_test $db_file`
		echo $result
		return $?
	fi
}

function after_transfer_gravity_extra() {
	[[ -f $PROG/update-blacklist.sh ]] && sudo bash $PROG/update-blacklist.sh
	sleep 5s
	[[ -f $PROG/update-whitelist.sh ]] && sudo bash $PROG/update-whitelist.sh
	sleep 5s
}

function after_transfer_gravity() {
	sync
	echo "PRAGMA wal_checkpoint(TRUNCATE);" | sudo sqlite3 $DB_FILE
        bash $PROG/pihole-db-sql-changes.sh
	sleep 5s
	[[ -f $PROG/regex.sh ]] && sudo bash $PROG/regex.sh
	sleep 5s
        bash $PROG/generarte_vulnerability-blacklist.sh
	sleep 5s
        bash $PROG/white-regex-yt.sh
	sleep 5s
	bash $PROG/quick-whitelist.sh
	sleep 5s
	sync
	echo "PRAGMA wal_checkpoint(TRUNCATE);" | sudo sqlite3 $DB_FILE
	sync
	return $?
}
function after_transfer_gravity_full() {
	after_transfer_gravity
	after_transfer_gravity_extra
}

export -f is_gravity_ok
export -f after_transfer_gravity
export -f after_transfer_gravity_full
export -f after_transfer_gravity_extra
export -f integrity_test
export -f query_test

if [[ -n "$COPY_FILE" ]] && [ "$0" == "$BASH_SOURCE" ]; then
	if [[ `is_gravity_ok $COPY_FILE` == 'true' ]] || [[ `is_gravity_ok $DB_FILE` == 'false' ]]; then
		echo "Gravity is ok Replacing"
		pihole disable 2m
		sync
		echo "PRAGMA wal_checkpoint(TRUNCATE);" | sudo sqlite3 $DB_FILE
#		echo "PRAGMA wal_autocheckpoint=1;"  | sudo sqlite3 $DB_FILE
#		echo "PRAGMA journal_size_limit=1;"  | sudo sqlite3 $DB_FILE
		sync
		sudo cp -rf $COPY_FILE $DB_FILE && pihole enable

		if [[ "$FULL_AFTER" == 'true' ]]; then
			after_transfer_gravity_full || after_transfer_gravity
		else
			after_transfer_gravity || after_transfer_gravity
		fi
	else
		echo "Gravity Is not ok or courupt and not usable"
	fi
else
	if [[ "$FULL_AFTER" == 'true' ]]; then
		after_transfer_gravity_full || after_transfer_gravity
	fi
fi
