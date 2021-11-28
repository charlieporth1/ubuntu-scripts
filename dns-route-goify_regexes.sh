#!/bin/bash
### Add a trim lines to the lists
echo "Filtering"
source ctp-dns.sh --sourced
CTP_LIST=$WWW/txt_lists/ctp-lists/
declare -a files
files=(
	$R_LIST/black/domains.txt
	$R_LIST/white/domains.txt
	$CTP_LIST/google-blacklist.list
	$CTP_LIST/google-whitelist.list
	$CTP_LIST/goverment-whitelist.list
	$CTP_LIST/*.list
	`new_linify.sh $(get_local_lists dns-lists.toml) | grep -v 'regex'`
	`new_linify.sh $(get_local_lists dns-lists-local.toml) | grep -v 'regex'`
)

files=( $( printf '%s\n' "${files[@]}" | sort | sort -u ) )

min_line_count=4
for file in "${files[@]}"
do
	if [[ -f $file ]]; then
		og_file=$ADMIN_HOME/Lists/$file
		if [[ "$HOSTNAME" == 'ctp-vpn' ]] && [[ `wc -l $file | awk '{print $1}'` -le $min_line_count ]] && [[ -f $og_file ]]; then
			sudo cp -rf $og_file $ROUTE_LIST/black/
		fi

		#perl -0777 -i -pe " s/^(\.)?/./gm " $file
#		perl -0777 -i -pe " s/(\.)?$//gm " $file
		bash $PROG/sort-lists.sh $file
	fi
done
#perl -pe " s/(\$)?$/.\$/ " $R_LIST/black/regex.txt > $R_LIST/black/regex.txt.tmp
echo "Moving files over"
#mv $R_LIST/black/regex.txt.tmp $R_LIST/black/regex.txt
echo "Done"
