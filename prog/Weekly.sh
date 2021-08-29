#!/usr/bin/bash

bash $PROG/update.unbound-config.sh
bash $PROG/updates.sh
bash $PROG/newKernelCustomModprobes.sh
bash $PROG/cleanup.sh
bash $PROG/iptables-reload.sh
