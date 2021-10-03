#!/bin/bash

bash $PROG/copy_psswd.sh
bash $PROG/copy_psswd.sh --root
bash $PROG/copy_to_root.sh
bash $PROG/copy_files.sh


bash $PROG/create_logging.sh

bash $PROG/cert_manager.sh
bash $PROG/cleanup.sh
bash $PROG/univeral_system_links.sh

bash $PROG/generate_udp_tests.sh
bash $PROG/generate_ctp-dns-groups.sh
bash $PROG/generate_ctp-dns-well-known-retry-groups.sh
bash $PROG/generate_ctp-dns-well-known-fail-backup-groups.sh
bash $PROG/generate_ctp-dns-backup-resolvers.sh

if [[ "$HOSTNAME" == "ctp-vpn" ]] || [[ "$IS_MASTER" = 'true' ]];then
	bash $PROG/generate_cache_interface_shorten_queries.sh
	bash $PROG/pihole-db-sql-changes.sh
	bash $PROG/pihole-lighttpd-changes.sh
	bash $PROG/generate_quad-name-server-list.sh
	bash $PROG/generate_name-server-list.sh
fi

if [[ "$HOSTNAME" == "ctp-vpn" ]]; then
	source $PROG/replace_gravity.sh
	replace_vacuum_update_gravity_root &
	bash $PROG/generate_dns_host_vulnerability-blacklist.sh
	bash $PROG/list-sync.sh
	bash $PROG/sort-all-list.sh
#	bash $PROG/pihole-company-lists-{sort,update}.sh
	bash $PROG/pihole-company-lists-sort.sh
	bash $PROG/pihole-company-lists-update.sh
	bash $PROG/pihole-backup.sh
	bash $PROG/git-prog.sh
fi

rm -rf $WWW/.well-known/{acme-challenge,pki-validation}
mkdir -p $WWW/.well-known/{acme-challenge,pki-validation}
