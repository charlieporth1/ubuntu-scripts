#!/bin/bash
### Add a trim lines to the lists
echo "Filtering"
declare -a files
files=(
	$R_LIST/black/domains.txt
	$R_LIST/white/domains.txt
	$WWW/txt_lists/ctp-lists/google-blacklist.list
	$WWW/txt_lists/ctp-lists/google-whitelist.list
)
for file in "${files[@]}"
do
	perl -0777 -i -pe " s/^(\.)?/./gm " $file

	perl -0777 -i -pe " s/(\.)?$//gm " $file
done
#perl -pe " s/(\$)?$/.\$/ " $R_LIST/black/regex.txt > $R_LIST/black/regex.txt.tmp
echo "Moving files over"
#mv $R_LIST/black/regex.txt.tmp $R_LIST/black/regex.txt
echo "Done"
