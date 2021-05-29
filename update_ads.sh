#!/bin/bash
curl -sS -L --compressed "http://pgl.yoyo.org/adservers/serverlist.php?hostformat=unbound&showintro=0&mimetype=plaintext" > /etc/unbound/local.d/unbound_ad_servers.conf
### https://github.com/opencoff/unbound-adblock
if ! [[ -d /etc/unbound/local.d/ ]]; then
	mkdir -p /etc/unbound/local.d/
fi

cd /etc/unbound/local.d/

wget -O adblock.new "https://www.bentasker.co.uk/adblock/autolist.txt"

if [ -f adblock.conf ]
then
    mv adblock.conf adblock.old
fi

mv adblock.new adblock.conf
sed -i "1s/^/server:\n/" adblock.conf
systemctl restart unbound
# Check whether unbound came back up
r=$( pgrep unbound | wc -l )
if [ $r -lt 1 ]
then
    mv adblock.old adblock.conf
    systemctl restart unbound
    exit 1
fi
exit 0

