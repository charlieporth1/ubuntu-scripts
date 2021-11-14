#!/bin/bash
if [[ -z "$PROG" ]]; then
	export PROG=/root/Programs
fi
source $PROG/tailscale_sync_files.sh
