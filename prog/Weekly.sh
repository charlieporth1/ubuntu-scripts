#!/usr/bin/bash
bash $PROG/PERMA_CACHE.sh
bash $PROG/update.unbound-config.sh
bash $PROG/updates.sh
bash $HOLE/whitelist-porn.sh
bash $PROG/newKernelCustomModprobes.sh
bash $PROG/cleanup.sh
bash $PROG/iptables-reload.sh
curl -s https://raw.githubusercontent.com/neodevpro/neodevhost/master/install.sh | bash
/etc/piadvanced/piholetweaks/adguard.sh

if [[ "$HOSTNAME" == 'ctp-vpn' ]]; then
	cp -rf $DB_FILE $DB_FILE.bk.db
	bash $PROG/acrhive_gravity.sh --archive-path=$DB_FILE.bk.db
fi
