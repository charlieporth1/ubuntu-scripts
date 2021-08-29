#!/bin/bash
source $PROG/all-scripts-exports.sh
source $PROG/ban_ip_conf.sh
CONCURRENT

create_ip-set brute abuse
url=https://raw.githubusercontent.com/cbuijs/badip-repo/master/brute.list
run_ip-set-block "$url"

create_ip-set nuc abuse
url=https://raw.githubusercontent.com/cbuijs/badip-repo/master/nuc-badip.list
run_ip-set-block "$url"

create_ip-set routedns-badip abuse
url=https://raw.githubusercontent.com/cbuijs/badip-repo/master/routedns-badip.list
run_ip-set-block "$url"

create_ip-set endless-badip abuse
url=https://raw.githubusercontent.com/cbuijs/badip-repo/master/endless-badip.list
run_ip-set-block "$url"

create_ip-set fail2ban-abuse abuse
url=https://raw.githubusercontent.com/cbuijs/accomplist/master/chris/fail2ban
run_ip-set-block "$url"

sudo bash $PROG/get_bad_hosts.sh > /tmp/bad_ips.txt
create_ip-set get_bad_hosts abuse
run_ip-set-block-file /tmp/bad_ips.txt


save_ip-tables

