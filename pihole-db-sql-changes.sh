#!/bin/bash
source $PROG/all-scripts-exports.sh
system_information

DB_FILE_DEFAULT=$HOLE/gravity.db
#DB_FILE_INPUT="$1"
DB_FILE=${DB_FILE_INPUT:=$DB_FILE_DEFAULT}
function pihole_sqlite3_changes() {
	local DB_FILE=${1:-$DB_FILE}
	echo "PRAGMA optimize;" | sudo sqlite3 $DB_FILE
	echo "PRAGMA secure_delete;" | sudo sqlite3 $DB_FILE
	echo "PRAGMA locking_mode;"  | sudo sqlite3 $DB_FILE
	echo "PRAGMA temp_store;"  | sudo sqlite3 $DB_FILE
	echo "PRAGMA threads;"  | sudo sqlite3 $DB_FILE
	echo "PRAGMA journal_mode;"  | sudo sqlite3 $DB_FILE
	if [[ $MEM_COUNT -ge 4096 ]]; then
		echo "PRAGMA default_cache_size=50000;"  | sudo sqlite3 $DB_FILE
		sudo sqlite3 $DB_FILE "PRAGMA default_cache_size=50000;"
	elif [[ $MEM_COUNT -ge 2048 ]]; then
		echo "PRAGMA default_cache_size=25000;"  | sudo sqlite3 $DB_FILE
		sudo sqlite3 $DB_FILE "PRAGMA default_cache_size=25000;"
	else
		echo "PRAGMA default_cache_size=7500;"  | sudo sqlite3 $DB_FILE
		sudo sqlite3 $DB_FILE "PRAGMA default_cache_size=7500;"
	fi
	echo "PRAGMA default_cache_size;"  | sudo sqlite3 $DB_FILE
	echo "PRAGMA cache_size;"  | sudo sqlite3 $DB_FILE
	sudo sqlite3 $DB_FILE "PRAGMA default_cache_size;"
	sudo sqlite3 $DB_FILE "PRAGMA cache_size;"
	echo "PRAGMA journal_mode=WAL;" | sudo sqlite3 $DB_FILE
	echo "PRAGMA journal_mode;"  | sudo sqlite3 $DB_FILE
	echo "PRAGMA journal_size_limit=5000;"  | sudo sqlite3 $DB_FILE
	echo "PRAGMA journal_size_limit;"  | sudo sqlite3 $DB_FILE
	echo "PRAGMA wal_autocheckpoint=5000;"  | sudo sqlite3 $DB_FILE
	echo "PRAGMA wal_autocheckpoint;"  | sudo sqlite3 $DB_FILE
	echo "PRAGMA auto_vacuum=FULL;"  | sudo sqlite3 $DB_FILE
	echo "PRAGMA auto_vacuum;"  | sudo sqlite3 $DB_FILE
	echo "PRAGMA automatic_index=true;"  | sudo sqlite3 $DB_FILE
	echo "PRAGMA automatic_index;"  | sudo sqlite3 $DB_FILE
	echo "PRAGMA threads=4;"  | sudo sqlite3 $DB_FILE
	echo "PRAGMA threads;"  | sudo sqlite3 $DB_FILE
	echo "PRAGMA temp_store=MEMORY;"  | sudo sqlite3 $DB_FILE
	echo "PRAGMA temp_store;"  | sudo sqlite3 $DB_FILE
	echo "PRAGMA secure_delete=FAST;" | sudo sqlite3 $DB_FILE
	echo "PRAGMA secure_delete;" | sudo sqlite3 $DB_FILE
	#echo "ATTACH DATABASE 'file::memory:?cache=shared' AS aux1;"  | sudo sqlite3 $DB_FILE
	#echo "ATTACH DATABASE 'file::memory:?cache=shared' AS ;"  | sudo sqlite3 $DB_FILE
	#echo "ATTACH DATABASE 'file::memory:?cache=shared';"  | sudo sqlite3 $DB_FILE
	#echo "ATTACH DATABASE 'file::memory:?cache=shared' AS '';"  | sudo sqlite3 $DB_FILE
	#echo "ATTACH DATABASE 'file::memory:?cache=shared' AS 'vw_regex_blacklist';" | sudo sqlite3 $DB_FILE
	#echo "ATTACH DATABASE 'file::memory:?cache=shared' AS 'vw_whitelist';"  | sudo sqlite3 $DB_FILE
	#echo "ATTACH DATABASE 'file::memory:?cache=shared' AS 'vw_regex_whitelist';"  | sudo sqlite3 $DB_FILE
	#echo "ATTACH DATABASE 'file::memory:?cache=shared' AS 'vw_blacklist';"  | sudo sqlite3 $DB_FILE
	#echo "ATTACH DATABASE 'file::memory:?cache=shared' AS 'vw_gravity';"  | sudo sqlite3 $DB_FILE
	echo "PRAGMA mmap_size=19128;"  | sudo sqlite3 $DB_FILE
	echo "PRAGMA mmap_size;"  | sudo sqlite3 $DB_FILE
	echo "PRAGMA max_page_count;"  | sudo sqlite3 $DB_FILE
	echo "PRAGMA journal_size_limit;"  | sudo sqlite3 $DB_FILE
	echo "PRAGMA hard_heap_limit;"  | sudo sqlite3 $DB_FILE
	echo "PRAGMA default_cache_size;"  | sudo sqlite3 $DB_FILE
	#echo "PRAGMA cache_size=-$(( 64 * 1024 * 1024 * 1024 ));"  | sudo sqlite3 $DB_FILE
	echo "PRAGMA automatic_index;"  | sudo sqlite3 $DB_FILE
	echo "PRAGMA cache_spill=1024;"  | sudo sqlite3 $DB_FILE
	echo "PRAGMA cache_spill;"  | sudo sqlite3 $DB_FILE


}
if ! ps -aux | grep 'pihole -g\|pihole  -g' | grep -v 'grep' > /dev/null; then
#echo "PRAGMA quick_check;"  | sudo sqlite3 $DB_FILE
# https://www.sqlite.org/pragma.html
# NOTE -CACHE IS KB
# PRAGMA schema.cache_size;
# PRAGMA schema.cache_size = pages;
# PRAGMA schema.cache_size = -kibibytes;
	pihole_sqlite3_changes $DB_FILE

fi
pihole_sqlite3_changes $FTL_DB
