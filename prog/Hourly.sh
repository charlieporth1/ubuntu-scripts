#!/bin/bash
systemctl daemon-reload


sync; echo 1 > /proc/sys/vm/drop_caches
sync; echo 2 > /proc/sys/vm/drop_caches
sync; echo 3 > /proc/sys/vm/drop_caches


pihole-FTL regex-test ''

bash $PROG/kill-health-check.sh
bash $PROG/pihole-db-sql-changes.sh
bash $PROG/white-regex-yt.sh
bash $PROG/doh_proxy_json.sh

rm -rf /tmp/health-checks.stop.lock

ctp-dns.sh --generate-log
ctp-dns.sh --generate-cache
