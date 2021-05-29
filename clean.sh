#!/bin/bash
DIRS=(
	/var/log/ctp-dns
)
amount_used_root_dir=`df | grep "root"  | awk '{print $5}' | sed -n '1p' | cut -d '%' -f 1`

if [[ $amount_used_root_dir -ge 75 ]]; then
	for dir in "${DIRS[@]}"
	do
		sudo rm -rf $dir/*
	done
fi
