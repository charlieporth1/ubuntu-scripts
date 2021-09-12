#!/bin/bash
source /etc/environment
source $PROG/all-scripts-exports.sh
ARGS="$@"
COPY_FILE="$1"
GRAVITY=gravity.db
DB_FILE=$HOLE/$GRAVITY
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(full-update|full|full-after)'` ]] && export FULL_AFTER=true || export FULL_AFTER=false
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(nc|no-check(-|_|\.)?(error|db|database)?)'` ]] && export NO_CHECK=true || export NO_CHECK=false

function query_test() {
	local db_file_input="$1"
        local db_file="${db_file_input:=$DB_FILE}"
	local query_str="$(uuidgen)--salty"
	local match_str="  [i] No results found for $query_str within the block lists"

	local error_query_file=/tmp/pihole_query_test.tmp.err
	if [[ -f $error_query_file ]]; then
		sudo rm -rf $error_query_file
	else
		touch $error_query_file
	fi

	local grep_around_query_test="Error: interrupted\|Error: database is locked\|Error: UNIQUE constraint failed: domainlist.domain, domainlist.type"

	if [[ -f $db_file ]]; then
		debug_logger "$db_file exists moving to compare files for query test"
	 	if cmp --silent $db_file $DB_FILE ; then
			debug_logger "Files match using query test"
			local db_status_query=`pihole -q $query_str 2> $error_query_file`
			local result=$(cat $error_query_file | grep -v "$grep_around_query_test")
			debug_logger "Files match using query test result $result"
			if [[ -z "$result"  ]]; then
				echo "true"
				sudo rm -rf $error_query_file 2>/dev/null
				return 0
		        else
		              	echo "false"
				sudo rm -rf $error_query_file 2>/dev/null
				return 1
			fi
		else
			debug_logger "Files do not match not using query test"
			echo "false"
			sudo rm -rf $error_query_file 2>/dev/null
			return 1
	        fi
	else
		echo "false"
		sudo rm -rf $error_query_file 2>/dev/null
		return 1

	fi
}

function integrity_test() {
	local db_file_input="$1"
        local db_file="${db_file_input:=$DB_FILE}"
        local OK_STR='ok'
	local term_str="Terminated"
	local status_str="$OK_STR\|$term_str"
	if [[ -f $db_file ]]; then
		local result=`integrity_test_quick $db_file`
		if [[ "$result" == "$OK_STR" ]]; then
			debug_logger "$db_file quick_check sucess moving to integrity_check"
		       	local db_status=`sudo cgexec -g cpu:38thspulimied -g memory:512MBRam --sticky /usr/bin/sudo /usr/bin/sqlite3 $db_file "PRAGMA integrity_check"`
			local result=`echo "$db_status" | grep -io "$status_str"`
			debug_logger "integrity_check test result db_status_quick_light $db_status result $result"
	        	if [[ "$result" == "$OK_STR" ]]; then
	               		echo "true"
				return 0
			elif [[ "$result" == "$term_str" ]]; then
				debug_logger "$db_file integrity_check killed recycleing/restarting process"
				integrity_test $db_file
			else
				echo "false"
				return 1
			fi
		elif [[ "$result" == "$term_str" ]]; then
			debug_logger "$db_file quick_check killed recycleing/restarting process"
			integrity_test $db_file
	        else
	               	echo "false"
			return 1
		fi
        else
               	echo "false"
		return 1
	fi

}
function integrity_test_quick() {
	local db_file_input="$1"
        local db_file="${db_file_input:=$DB_FILE}"
        local OK_STR='ok'
	local term_str="Terminated"
	local status_str="$OK_STR\|$term_str"
	if [[ -f $db_file ]]; then
		debug_logger "$db_file exists moving quick_check"
		local db_status=`sudo sqlite3 $db_file "PRAGMA quick_check"`
		local result=`echo "$db_status" | grep -io "$status_str"`
		debug_logger "quick_check test result db_status_quick_light $db_status result $result"
		if [[ "$result" == "$OK_STR" ]]; then
	              	echo "true"
			return 0
		elif [[ "$result" == "$term_str" ]]; then
			debug_logger "$db_file quick_check killed recycleing/restarting process"
			integrity_test_quick $db_file
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
	local db_file_input="$1"
	local arguments="$2"
        local db_file="${db_file_input:=$DB_FILE}"
	if cmp --silent $db_file $DB_FILE; then
		debug_logger "$db_file exists moving to compare files for query test"
		if [[ `query_test $db_file` == 'true' ]]; then
			if [[ "$arguments" == '--quick-check' ]]; then
				local result=`integrity_test_quick $db_file`
				echo "$result"
				return $?
			else
				local result=`integrity_test $db_file`
				echo "$result"
				return $?
			fi
		else
			echo "false"
			return 1
		fi
	else
		if [[ "$arguments" == '--quick-check' ]]; then
			local result=`integrity_test_quick $db_file`
			echo "$result"
			return $?
		else
			local result=`integrity_test $db_file`
			echo "$result"
			return $?
		fi
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
	local RUN_FILE=$PROG/regex.sh
	[[ -f $RUN_FILE ]] && sudo bash $RUN_FILE
	sleep 5s
	local RUN_FILE=$PROG/pihole-company-lists-update.sh
	[[ -f $RUN_FILE ]] && sudo bash $RUN_FILE
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
	if [[ "$NO_CHECK" == 'true' ]] || [[ `is_gravity_ok $COPY_FILE` == 'true' ]] || [[ `is_gravity_ok $DB_FILE` == 'false' ]]
	then
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
