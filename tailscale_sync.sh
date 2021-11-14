#!/bin/bash
source $PROG/tailscale_sync_files.sh

tailscale_nodes=`tailscale status | awk '{print $2}' | grep -v 'hello'`


for node in $tailscale_nodes
do
	echo On node: $node
	for file in ${prog_files_array[@]}
	do
		echo On file: $file
		(
			sudo tailscale file cp $file $node:
		)&
	done
done

