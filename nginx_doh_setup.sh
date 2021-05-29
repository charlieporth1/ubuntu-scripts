#!/bin/bash
SCRIPT_DIR=`realpath .`
source $SCRIPT_DIR/.project_env.sh

current_str="server_name  dns.ctptech.dev;"
replace_str="server_name  dns.ctptech.dev master.dns.ctptech.dev;"

sed -i "s/$current_str/$replace_str/g" $SITES/doh
sudo nginx -t
