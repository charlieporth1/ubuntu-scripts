#!/bin/bash
TMP_DIR=/tmp
sync_file=$1
sync_file_dir=$2
sync_file_path=$sync_file_dir$sync_file
tmp_file_path=$TMP_DIR/$sync_file

sudo tailscale file get --wait=true $TMP_DIR

if [[ -f $tmp_file_path ]]; then
	sudo mv $tmp_file_path $sync_file_path
	sudo rm -rf $tmp_file_path
	sudo rm -rf $sync_file_path
fi
exit 0
