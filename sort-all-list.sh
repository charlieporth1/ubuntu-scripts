#!/bin/bash
source  $PROG/custom-list-files.sh
source ctp-dns.sh --sourced

for file in "${black_files[@]}"
do
	echo "sorting list $file"
	bash $PROG/sort-lists.sh "$file"
	echo "done"
done

for file in "${files[@]}"
do
	echo "sorting list $file"
	bash $PROG/sort-lists.sh "$file"
	echo "done"
done

local_lists_1=`get_local_lists dns-lists.toml`
local_lists_2=`get_local_lists dns-lists-local.toml`

IFS=$'\n'

for file in $local_lists_1
do
	echo "sorting list $file"
	bash $PROG/sort-lists.sh "$file"
	echo "done"
done

for file in $local_lists_2
do
	echo "sorting list $file"
	bash $PROG/sort-lists.sh "$file"
	echo "done"
done
