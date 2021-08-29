#!/bin/bash
systemctl daemon-reload


sync; echo 1 > /proc/sys/vm/drop_caches
sync; echo 2 > /proc/sys/vm/drop_caches
sync; echo 3 > /proc/sys/vm/drop_caches



bash $ROUTE/ctp-dns-version-mananger.sh

bash $PROG/copy_files.sh
bash $PROG/copy_to_root.sh
bash $PROG/copy_psswd.sh
bash $PROG/copy_psswd.sh --root


bash $PROG/doh_proxy_json.sh
bash $PROG/kill-health-check.sh
bash $PROG/start_fail2ban_jails.sh
bash $PROG/program_usage_retrictions.sh

bash $PROG/generate_udp_tests.sh
bash $PROG/generate_route-dns_groups.sh
bash $PROG/generate_ctp-dns-backup-resolvers.sh
bash $PROG/.secure-exe-files.sh

if [[ "$IS_MASTER" == 'true' ]]; then
	[[ -f $PROG/remove_common.sh ]] && bash $PROG/remove_common.sh
	bash $PROG/create_logging.sh
	bash $PROG/quick-whitelist.sh
	bash $PROG/white-regex-yt.sh
	bash $PROG/copy_master_pihole_config.sh
	bash $PROG/pihole-db-sql-changes.sh
	bash $PROG/generate_dnmasq-servers.sh
	bash $PROG/generate_vulnerability-blacklist.sh
	pihole-FTL regex-test ''
fi

rm -rf /tmp/health-checks.stop.lock

ctp-dns.sh --generate-log
ctp-dns.sh --generate-cache
ctp-dns.sh --generate-config

bash $PROG/create_logging.sh
