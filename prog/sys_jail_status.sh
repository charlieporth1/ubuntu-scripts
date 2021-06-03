#!/bin/bash
NC="\e[39m"
RED="\e[31m"
RED_L="\e[91m"
CYAN="\e[36m"
GREEN_L="\e[92m"
black='\e[0;30m'
blue='\e[0;34m'
green='\e[0;32m'
cyan='\e[0;36m'
red='\e[0;31m'
yellow='\e[1;33m'
white='\e[1;37m'
nc='\e[0m'
purple='\e[0;35m'
brown='\e[0;33m'
lightgray='\e[0;37m'
darkgray='\e[1;30m'
lightblue='\e[1;34m'
lightgreen='\e[1;32m'
lightcyan='\e[1;36m'
lightred='\e[1;31m'
lightpurple='\e[1;35m'
TICK="$NC[$green✔$NC]$NC"
FAIL="$NC[$RED✗$NC]$NC"

declare -a JAILs
JAILs=(
 `sudo fail2ban-client status | grep "Jail list:" | awk -F, 'NR==n && $1=$1' n=1 | cut -d ':' -f 2-`
)
printf "|| $CYAN%-20s $NC|$CYAN %-10s $NC|$CYAN %-20s $NC|$CYAN %-10s $NC|$CYAN %-10s $NC|\n" "JAIL" "BAN COUNT" "TOTAL FAILED" "CURRENTLY FAILED"  "TIME"

for jail in "${JAILs[@]}"
do
	ban_count=`sudo fail2ban-client status $jail | sed -n '7p' | awk '{print $4}'`
	total_failed=`sudo fail2ban-client status $jail | grep 'Total failed' | awk -F: '{print $2}'`
	currently_failed=`sudo fail2ban-client status $jail | grep 'Currently failed' | awk -F: '{print $2}'`
	printf "|| %-20s | %-10s | %-20s | %-10s | %-10s |\n" "$jail" "$ban_count" "$total_failed" "$currently_failed" "`date +'%H:%M:%S'`"

done
