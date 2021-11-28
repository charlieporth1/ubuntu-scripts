#!/bin/bash
source /etc/environment
source $PROG/all-scripts-exports.sh
CONCURRENT
ARGS="$@"
COPY_FILE="$1"
export GRAVITY=gravity.db
export DB_FILE=$HOLE/$GRAVITY
export OTHER_FILES_BLOB={,-{wal,shm}}
export OTHER_DB_FILE=$DB_FILE$OTHER_FILES_BLOB
export OTHER_DB_FILES=$OTHER_DB_FILE

OK_STR='ok'
term_str="Terminated"
status_str="$OK_STR\|$term_str"
query_str="$(uuidgen)--salty"
export byte_size=$(( 1024 * 1024 * 1024 ))
export min_gravity_size=$(( $byte_size * 64 ))

shopt -s expand_aliases

[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(full-update|full|full-after)'` ]] && export FULL_AFTER=true || export FULL_AFTER=false
[[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(nc|no-check(-|_|\.)?(error|db|database)?)'` ]] && export NO_CHECK=true || export NO_CHECK=false

function pihole_json_test() {
        local db_file_input="$1"
        local db_file="${db_file_input:=$DB_FILE}"
        local domain_being_blocked_count=`pihole -c -j | jq '.domains_being_blocked' || echo 0`
        if [[ -f $db_file ]]; then
                if cmp --silent $db_file $DB_FILE ; then
                        if [[ $domain_being_blocked_count -le 0 ]] || [[ -z $domain_being_blocked_count ]]; then
                                echo "false"
                                return 1
                        else
                                echo "true"
                                return 0
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
export -f pihole_json_test

function pihole_cmd_test() {
	local pihole_args="${2:--q}"
	local db_file_input="$1"
        local db_file="${db_file_input:=$DB_FILE}"
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
			local db_status_query=`pihole $pihole_args $query_str 2> $error_query_file`
			if [[ $pihole_args =~ (\-|\-\-)((white-)?(regex|wild)|b(lack)?|w(hite)?) ]]; then
				pihole $pihole_args -d $query_str  > /dev/null
			fi

			local result=$(cat $error_query_file | grep -v "$grep_around_query_test")
			debug_logger "Files match using query test result $result"
			if [[ -z "$result"  ]]; then
				echo "true"
				sudo rm -rf $error_query_file 2> /dev/null
				return 0
		        else
		              	echo "false"
				sudo rm -rf $error_query_file 2> /dev/null
				return 1
			fi
		else
			debug_logger "Files do not match not using query test"
			echo "false"
			sudo rm -rf $error_query_file 2> /dev/null
			return 1
	        fi
	else
		echo "false"
		sudo rm -rf $error_query_file 2> /dev/null
		return 1

	fi
}
function size_test() {
	local db_file_input="$1"
        local db_file="${db_file_input:=$DB_FILE}"
	local size_in_bytes=`ls -s $db_file | awk '{print $1}'`
	if [[ $size_in_bytes -ge $min_gravity_size ]]; then
		echo "true"
	else
		echo "false"
	fi
}
export -f size_test

function query_test() {
	local db_file_input="$1"
	pihole_cmd_test "$db_file_input" '-q'
}
export -f query_test

function block_test() {
	local db_file_input="$1"
	pihole_cmd_test "$db_file_input" '-b'
}
export block_test

function regex_test() {
	local db_file_input="$1"
	pihole_cmd_test "$db_file_input" '--regex'
}
export regex_test

function integrity_test_quick() {
	local db_file_input="$1"
        local db_file="${db_file_input:=$DB_FILE}"

	if [[ -f $db_file ]]; then
	    if [[ `size_test $db_file` == true ]]; then
		debug_logger "$db_file exists moving quick_check integrity_test_quick"
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
        else
               	echo "false"
		return 1
	fi

}
export -f integrity_test_quick
alias quick_check='integrity_test_quick'

function integrity_test() {
	local db_file_input="$1"
        local db_file="${db_file_input:=$DB_FILE}"

	if [[ -f $db_file ]]; then
	    if [[ `size_test $db_file` == true ]]; then
		local quick_result=`integrity_test_quick $db_file`
		if [[ "$quick_result" == 'true' ]]; then
			debug_logger "$db_file quick_check sucess moving to integrity_check"
		       	local db_status=`sudo cgexec -g cpu:38thspulimied -g memory:750MBRam --sticky /usr/bin/sudo /usr/bin/sqlite3 $db_file "PRAGMA integrity_check"`
			local result=`echo "$db_status" | grep -io "$status_str"`
			debug_logger "integrity_check test result db_status $db_status result $result"
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
export -f integrity_test
alias integrity_check='integrity_test'

function vacuum_update() {
	local db_file_input="$1"
	local db_file="${db_file_input:=$DB_FILE}"
	echo "PRAGMA optimize;" | sudo sqlite3 $db_file
	echo "VACUUM;" | sudo sqlite3 $db_file
	echo "PRAGMA auto_vacuum = FULL;" | sudo sqlite3 $db_file
#	echo "PRAGMA auto_vacuum = INCREMENTAL;" | sudo sqlite3 $DB_FILE
	flush_db $db_file
}
export -f vacuum_update

function replace_vacuum_update() {
	local src="$1"
	local dest="$2"
	if [[ "$DB_FILE" != "$src" ]]; then
		vacuum_update $src
		if [[ `integrity_test_quick $src` ]]; then
			sudo mv $src $dest
		else
			echo "Intergraty FAILED"
		fi
	else
		echo "Cannot VACUUM ACTIVE file: $src"
	fi
}
export -f replace_vacuum_update

function replace_vacuum_update_gravity() {
	local src="$1"
	local dest="$DB_FILE"

	replace_vacuum_update "$src" "$dest"
}
export -f replace_vacuum_update_gravity

function replace_vacuum_update_gravity_root() {
	echo "PRAGMA wal_checkpoint(TRUNCATE);" | sudo sqlite3 $DB_FILE
	sudo cp -rf $DB_FILE $DB_FILE.tmp.db

	local src="$DB_FILE.tmp.db"
	local dest="$DB_FILE"

	replace_vacuum_update "$src" "$dest"
}
export -f replace_vacuum_update_gravity_root

function run_sqlite_check() {
        local arguments="$2"
        local db_file="$1"

        if [[ "$arguments" == '--quick-check' ]]; then
                local result=`integrity_test_quick $db_file`
                echo "$result"
                return $?
        else
                local result=`integrity_test $db_file`
                echo "$result"
                return $?
        fi

}

function quick_test() {
	local db_file_input="$1"
        local db_file="${db_file_input:=$DB_FILE}"
	if cmp --silent $db_file $DB_FILE; then
	    if [[ `size_test $db_file` == true ]]; then
		debug_logger "$db_file exists moving to compare files for pihole_json_test test `pihole_json_test`"
	        if [[ `pihole_json_test $db_file` == 'true' ]]; then
			debug_logger "$db_file exists moving to compare files for query test"
			if [[ `query_test $db_file` == 'true' ]]; then
				debug_logger "$db_file moving to block test"
				if [[ `block_test $db_file` == 'true' ]]; then
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
            else
                echo "false"
                return 1
            fi
	else
		echo "false"
		return 1
	fi

}
export -f quick_test

function is_gravity_ok() {
	local arguments="$2"
	local db_file_input="$1"
        local db_file="${db_file_input:=$DB_FILE}"
	if cmp --silent $db_file $DB_FILE; then
	    if [[ `size_test $db_file` == 'true' ]]; then
		if [[ `quick_test $db_file` == 'true' ]]; then
			run_sqlite_check "$db_file" "$arguments"
		else
			echo "false"
			return 1
		fi
            else
                echo "false"
                return 1
            fi
	else
		run_sqlite_check "$db_file" "$arguments"
	fi
}
export -f is_gravity_ok
alias is-gravity-ok='is_gravity_ok'
alias gravity_ok='is_gravity_ok'
alias gravity-ok='is_gravity_ok'

function after_transfer_gravity_extra() {
	bash $PROG/pihole-db-sql-changes.sh
	flush_db
	local sleep_time=2s
	sleep $sleep_time

	local RUN_FILE=$PROG/update-blacklist.sh
	[[ -f $RUN_FILE ]] && sudo bash $RUN_FILE
	sleep $sleep_time

	local RUN_FILE=$PROG/update-whitelist.sh
	[[ -f $RUN_FILE ]] && sudo bash $RUN_FILE
	sleep $sleep_time
	flush_db
	pihole --regex -d '(^|.)((yandex|qq|tencent).(net|com|org|dev|io|sh|cn|ru)|qq|local|localhost|query|sl|(^.$))' \
        '(^|.)(jujxeeerdcnm.intranet|w|aolrlgqh.intranet|((.)?)intranet)' '(^|.)(jujxeeerdcnm.ntranet|w|aolrlgqh.ntranet|((.)?)intranet)' \ 
	'(^|.)((yandex|qq|tencent).(net|com|org|dev|io|sh|cn|ru)|qq|local|localhost|query|sl|(^.$)|cn-geo1.uber.com|metadata.google.internal|((.)?)in-addr.arpa)'
}
export -f after_transfer_gravity_extra

function flush_db() {
	local db_file_input="$1"
        local db_file="${db_file_input:=$DB_FILE}"
	sync
	echo "PRAGMA wal_checkpoint(TRUNCATE);" | sudo sqlite3 $db_file
	sync
}
export -f flush_db
alias flush_transactions_db='flush_db'

function after_transfer_gravity() {
	sync
	flush_db
        bash $PROG/pihole-db-sql-changes.sh
	chown -R pihole:pihole $OTHER_DB_FILES
	chmod -R gu+rw $OTHER_DB_FILES
	pihole --regex -d '(^|.)((yandex|qq|tencent).(net|com|org|dev|io|sh|cn|ru)|qq|local|localhost|query|sl|(^.$))' \
	        '(^|.)(jujxeeerdcnm.intranet|w|aolrlgqh.intranet|((.)?)intranet)' \
	        '(^|.)(jujxeeerdcnm.ntranet|w|aolrlgqh.ntranet|((.)?)intranet)'

	local sleep_time=2s
	sleep $sleep_time
	local RUN_FILE=$PROG/regex.sh
	[[ -f $RUN_FILE ]] && sudo bash $RUN_FILE --no-remove-common
	sleep $sleep_time

	local RUN_FILE=$PROG/pihole-company-lists-update.sh
	[[ -f $RUN_FILE ]] && sudo bash $RUN_FILE
	sleep $sleep_time

	local RUN_FILE=$PROG/generate_vulnerability-blacklist.sh
	[[ -f $RUN_FILE ]] && sudo bash $RUN_FILE
	sleep $sleep_time

	local RUN_FILE=$PROG/white-regex-yt.sh
	[[ -f $RUN_FILE ]] && sudo bash $RUN_FILE
	sleep $sleep_time

	local RUN_FILE=$PROG/quick-whitelist.sh
	[[ -f $RUN_FILE ]] && sudo bash $RUN_FILE
	sleep $sleep_time

	local RUN_FILE=$PROG/remove_common.sh
	[[ -f $RUN_FILE ]] && sudo bash $RUN_FILE
	sleep $sleep_time
	flush_transactions_db
	return $?
}
export -f after_transfer_gravity

function after_transfer_gravity_full() {
	after_transfer_gravity
	after_transfer_gravity_extra
	flush_db
}
export -f after_transfer_gravity_full


if [[ -n "$COPY_FILE" ]] && [ "$0" == "$BASH_SOURCE" ]; then
	if [[ "$NO_CHECK" == 'true' ]] || [[ `is_gravity_ok $COPY_FILE` == 'true' ]] || [[ `is_gravity_ok $DB_FILE` == 'false' ]]
	then
		echo "Gravity is ok Replacing"
		pihole disable 5m
		sync
		sudo rm -rf $DB_FILE*
		sudo cp -vrf $COPY_FILE $DB_FILE && pihole enable
		sync
#		tar cf - $COPY_FILE | pv | (cd $DB_FILE; tar xf -)
s="""
		sudo rsync \
	                $COPY_FILE $DB_FILE \
                	--info=progress2 \
                	--archive \
                	--no-whole-file \
                	--inplace \
                	--numeric-ids \
                	--partial \
                	--progress \
                	--sparse \
                	--rsync-path='sudo rsync' \
                	--dirs \
                	--no-compress \
                	--links \
                	--copy-links \
                	--safe-links \
                	--copy-dirlinks \
                	--super \
                	--checksum \
                	--recursive \
                	--verbose \
                	--human-readable && pihole enable
"""
		if [[ "$FULL_AFTER" == 'true' ]]; then
			after_transfer_gravity_full
		else
			after_transfer_gravity
		fi
		sync
	else
		echo "Gravity Is not ok or courupt and not usable"
	fi
else
	if [[ "$FULL_AFTER" == 'true' ]]; then
		after_transfer_gravity_full || after_transfer_gravity
	fi
fi
