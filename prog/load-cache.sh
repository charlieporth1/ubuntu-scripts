#!/bin/bash

ROOT_CACHE=/var/cache
PERMA_CACHE=/mnt/cache
REMOTE_CACHE_DIR=/tmp/cache

sudo unbound-control load_cache < $PERM_CACHE/unbound.cache
cp -rf $PERMA_CACHE/* $ROOT_CACHE/
