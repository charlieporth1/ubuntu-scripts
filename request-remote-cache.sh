#!/bin/bash
SCRIPT_DIR=`dirname $0`
MASTER_MACHINE="ctp-vpn"
GCLOUD_PROJECT="galvanic-pulsar-284521"
GCLOUD_ZONE="us-central1-a"
ROOT_CACHE=/var/cache
PERMA_CACHE=/mnt/cache
REMOTE_CACHE_DIR=/tmp/cache

if ! [[ -d $PERMA_CACHE ]]; then
	mkdir -p $PERMA_CACHE
fi

sudo unbound-control dump_cache > $PERMA_CACHE/unbound.cache.old.save

gcloud compute ssh $MASTER_MACHINE \
        --project "$GCLOUD_PROJECT" \
        --zone "$GCLOUD_ZONE" -- "sudo bash $PROG/PERMA_CACHE.sh --sync"

gcloud compute scp $MASTER_MACHINE:$REMOTE_CACHE_DIR $PERMA_CACHE \
	--scp-flag="-r" \
        --project "$GCLOUD_PROJECT" \
        --zone "$GCLOUD_ZONE"

bash $SCRIPT_DIR/load-cache.sh
