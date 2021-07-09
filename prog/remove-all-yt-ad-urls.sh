#!/bin/bash
bash $PROG/dblock.sh

REGEX_EXCLUDE="googlevideo\|gvt"

pihole --wild -d googlevideo.com
pihole --white-wild -d googlevideo.com

parallel -j4 echo "{}" :::: <(pihole --regex -l | grep --line-buffer "$REGEX_EXCLUDE" | awk '{print $2}' ) | \
parallel -j1 --xargs -m --lb --no-run-if-empty pihole --regex -d

parallel -j4 echo "{}" :::: <(pihole --white-regex -l | grep --line-buffer "$REGEX_EXCLUDE" | awk '{print $2}' ) | \
parallel -j1 --xargs -m --lb --no-run-if-empty pihole --white-regex -d




pihole -q r3---sn-vgqsrnld.googlevideo.com  | grep whitelist -A 2| grep -v blacklist | grep -v whitelist | parallel --xargs echo '"{}"' | xargs pihole --white-regex -d
pihole -q r3.sn-vgqsrnld.googlevideo.com  | grep whitelist -A 2 | grep -v blacklist | grep -v whitelist | parallel --xargs echo '"{}"' | xargs pihole --white-regex -d

pihole -q r3.sn-vgqsrnld.googlevideo.com  | grep blacklist -A 2| grep -v whitelist | grep -v blacklist | parallel --xargs echo '"{}"' | xargs pihole --white-regex -d
pihole -q r3--sn-vgqsrnld.googlevideo.com  | grep blacklist -A 2 | grep -v whitelist | grep -v blacklist | parallel --xargs echo '"{}"' | xargs pihole --white-regex -d


pihole --white-regex -d  '^r([0-9]{1,2})---sn-([a-z0-9\-_\.]{4,22})(|-[a-z0-9]{2,6})\.googlevideo\.com$' \
        '^r([0-9]{1,2})\.sn-([a-z0-9\-_\.]{4,22})(|-[a-z0-9]{2,6})\.googlevideo\.com$' \
        '^r([0-9]{1,2})\.sn-([a-za-z0-9\.-]{4,28})\.googlevideo\.com$' \
        '^r([0-9]{1,2})---sn-([a-za-z0-9\.-]{4,28})\.googlevideo\.com$'
