#!/bin/bash
configFile=/etc/lighttpd/lighttpd.conf

serverPortStr="server.port                 = 80"
serverPortRplaceStr="server.port                 = 880"

sed -i "s/$serverPortStr/$serverPortRplaceStr/g" $configFile
if [[ -z  `grep -o '"mod_rewrite",' $configFile` ]]; then
       sed -i 's/"mod_rewrite"/"mod_rewrite",\n    "mod_openssl"/g' $configFile
fi
replace_str='"X-Frame-Options" => "DENY",\n\n"X-Powered-By" => "X-DEATH",\n\n"X-XSS-Protection" => "1; mode=block",\n\n"Cache-Control" => "max-age=9600'
sed -i "s/"X-Frame-Options" => "DENY"/$replace_str/g" $configFile
echo "done"
