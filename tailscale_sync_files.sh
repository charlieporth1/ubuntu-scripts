#!/bin/bash

declare -a prog_files_array
prog_files_array=(
	all-scripts-exports.sh
	tailscale_sync{,_files,_client_{setup,files_list,env,cron}}.sh
	start_tailscale.sh
)
