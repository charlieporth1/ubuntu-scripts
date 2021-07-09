#!/bin/bash

# Order matters
sudo bash $PROG/remove-all-yt-ad-urls.sh
sudo bash $PROG/white-regex-yt.sh

mapfile -t DOMAINS_TO_TEST_WHITE < $HOLE/quick-whitelist.list
mapfile -t DOMAINS_TO_TEST_BLACK < $HOLE/quick-blacklist.list

/usr/local/bin/pihole -b ${DOMAINS_TO_TEST_BLACK[@]}
/usr/local/bin/pihole -w -d ${DOMAINS_TO_TEST_BLACK[@]}

/usr/local/bin/pihole -w ${DOMAINS_TO_TEST_WHITE[@]}
/usr/local/bin/pihole -b -d ${DOMAINS_TO_TEST_WHITE[@]}

pihole --white-regex -d  '^r([0-9]{1,2})---sn-([a-z0-9\-_\.]{4,22})(|-[a-z0-9]{2,6})\.googlevideo\.com$' \
        '^r([0-9]{1,2})\.sn-([a-z0-9\-_\.]{4,22})(|-[a-z0-9]{2,6})\.googlevideo\.com$' \
        '^r([0-9]{1,2})\.sn-([a-za-z0-9\.-]{4,28})\.googlevideo\.com$' \
        '^r([0-9]{1,2})---sn-([a-za-z0-9\.-]{4,28})\.googlevideo\.com$'


