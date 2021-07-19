#!/bin/bash
declare -a files
files=(
	/etc/hosts
	$HOLE/dns-servers.conf
	$SITES/doh
)


for file in "${files[@]}"
do
	echo "Running file $file"
	if [[ -f $file.bk ]]; then
		echo "$file.bk exists coping to $file"
		cp -rf $file.bk $file
	else
		echo "Does not $file.bk exist error"
	fi
done
