#!/bin/bash
file=$1

perl -0777 -i -pe 's/^",//gm' $file
perl -0777 -i -pe 's/",,$/",/gm' $file
perl -0777 -i -pe 's/^(|\t|\ )".*"$/",/gm' $file
perl -0777 -i -pe 's/^(("|,|\.){1,3})$//gm' $file
perl -0777 -i -pe 's/^((\t|\ )?)('\''|"|\.|,)(,|\.)?$//gm' $file
perl -0777 -i -pe 's/""//gm' $file
perl -0777 -i -pe 's/^"ctp-dns/\t"ctp-dns/gm' $file
perl -0777 -i -pe 's/^"well-known/\t"well-known/gm' $file
perl -0777 -i -pe 's/^"/\t"/gm' $file

if [[ "$HOSTNAME" != "ctp-vpn" ]]; then
	replace_str_regex='local-address = "(192\.168\.99\.9|10\.128\.0\.9)"'
	perl -0777 -i -pe "s/^$replace_str_regex//gm" $file
fi

echo "Done formating $file"
