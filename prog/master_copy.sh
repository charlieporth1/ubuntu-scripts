#!/bin/bash
source $PROG/all-scripts-exports.sh
src="$1"
dest="$2"

private_key=$HOME/.ssh/google_compute_engine

MASTER_MACHINE="ctp-vpn"
GCLOUD_PROJECT="galvanic-pulsar-284521"
GCLOUD_ZONE="us-central1-a"
PERONAL_USR=charlieporth1_gmail_com

if [[ `ip_exists 10.128.0.9` == 'true' ]]; then
        internal_ip='--internal-ip'
        HOST=10.128.0.9
elif [[ `ip_exists 192.168.99.9` == 'true' ]]; then
        internal_ip='--internal-ip'
        HOST=192.168.99.9
else
        HOST=gcp.ctptech.dev
fi

if [[ `command -v rsync` ]] && [[ -f $private_key ]]; then
	sudo rsync \
		--rsh="ssh -p22 -i $private_key" \
		$PERONAL_USR@$HOST:$src $dest \
		--rsync-path='sudo rsync' \
		--dirs \
		--links \
		--copy-links \
		--safe-links \
		--copy-dirlinks \
		--super \
		--checksum \
		--recursive \
		--verbose \
		--progress \
		--human-readable
else
	sudo gcloud compute scp $MASTER_MACHINE:$src $dest \
		--scp-flag="-r" --project "$GCLOUD_PROJECT" --zone "$GCLOUD_ZONE" $internal_ip
fi
