#!/bin/bash
DB_FILE=$HOLE/gravity.db
#sudo chmod 664 $DB_FILE
#sudo chgrp pihole $DB_FILE
sync
echo "PRAGMA journal_mode=WAL;" | sudo sqlite3 $DB_FILE
echo "PRAGMA journal_mode;"  | sudo sqlite3 $DB_FILE
#echo "PRAGMA schema.wal_checkpoint;"  | sudo sqlite3 $DB_FILE
echo "PRAGMA wal_autocheckpoint;"  | sudo sqlite3 $DB_FILE
echo "PRAGMA auto_vacuum = FULL;" | sudo sqlite3 $DB_FILE
echo "PRAGMA threads=2;"  | sudo sqlite3 $DB_FILE
echo "PRAGMA threads;"  | sudo sqlite3 $DB_FILE
#echo "PRAGMA temp_store=MEMORY;"  | sudo sqlite3 $DB_FILE
#echo "PRAGMA temp_store;"  | sudo sqlite3 $DB_FILE
#echo "ATTACH DATABASE 'file::memory:?cache=shared' AS aux1;"  | sudo sqlite3 $DB_FILE
#echo "ATTACH DATABASE 'file::memory:?cache=shared' AS ;"  | sudo sqlite3 $DB_FILE
#echo "ATTACH DATABASE 'file::memory:?cache=shared';"  | sudo sqlite3 $DB_FILE
#echo "ATTACH DATABASE 'file::memory:?cache=shared' AS 'vw_regex_blacklist';" | sudo sqlite3 $DB_FILE
#echo "ATTACH DATABASE 'file::memory:?cache=shared' AS 'vw_whitelist';"  | sudo sqlite3 $DB_FILE
#echo "ATTACH DATABASE 'file::memory:?cache=shared' AS 'vw_regex_whitelist';"  | sudo sqlite3 $DB_FILE
#echo "ATTACH DATABASE 'file::memory:?cache=shared' AS 'vw_blacklist';"  | sudo sqlite3 $DB_FILE
#echo "ATTACH DATABASE 'file::memory:?cache=shared' AS 'vw_gravity';"  | sudo sqlite3 $DB_FILE
#echo "ATTACH DATABASE 'file::memory:?cache=shared' AS '' ;" | sudo sqlite3 $HOLE/gravity.db
#echo "ATTACH DATABASE 'file::memory:?cache=shared' AS 'vw_regex_blacklist';"  | sudo sqlite3 $HOLE/gravity.db
#echo "ATTACH DATABASE 'file::memory:?cache=shared' AS 'vw_whitelist';"  | sudo sqlite3 $HOLE/gravity.db
#echo "ATTACH DATABASE 'file::memory:?cache=shared' AS 'vw_regex_whitelist';"  | sudo sqlite3 $HOLE/gravity.db
#echo "ATTACH DATABASE 'file::memory:?cache=shared' AS 'vw_blacklist';"  | sudo sqlite3 $HOLE/gravity.db
#echo "ATTACH DATABASE 'file::memory:?cache=shared' AS 'vw_gravity';"  | sudo sqlite3 $HOLE/gravity.db
#echo "ATTACH DATABASE 'file::memory:?cache=shared' AS 'vw_adlist';"  | sudo sqlite3 $HOLE/gravity.db
#echo "ATTACH DATABASE 'file::memory:?cache=shared' AS 'gravity';"  | sudo sqlite3 $HOLE/gravity.db
#echo "ATTACH DATABASE 'file::memory:?cache=shared' AS 'adlist';"  | sudo sqlite3 $HOLE/gravity.db
#echo "ATTACH DATABASE 'file::memory:?cache=shared' AS 'domainlist';"  | sudo sqlite3 $HOLE/gravity.db
echo "PRAGMA mmap_size=19128;"  | sudo sqlite3 $DB_FILE
echo "PRAGMA mmap_size;"  | sudo sqlite3 $DB_FILE
#echo "PRAGMA quick_check;"  | sudo sqlite3 $DB_FILE
echo "PRAGMA max_page_count;"  | sudo sqlite3 $DB_FILE
echo "PRAGMA journal_size_limit;"  | sudo sqlite3 $DB_FILE
echo "PRAGMA hard_heap_limit;"  | sudo sqlite3 $DB_FILE
echo "PRAGMA default_cache_size=9000000;"  | sudo sqlite3 $DB_FILE
echo "PRAGMA default_cache_size;"  | sudo sqlite3 $DB_FILE
echo "PRAGMA cache_size=9000000;"  | sudo sqlite3 $DB_FILE
echo "PRAGMA cache_size;"  | sudo sqlite3 $DB_FILE
echo "PRAGMA automatic_index;"  | sudo sqlite3 $DB_FILE
echo "PRAGMA cache_spill=1024;"  | sudo sqlite3 $DB_FILE
echo "PRAGMA cache_spill;"  | sudo sqlite3 $DB_FILE
sync
