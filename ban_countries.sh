#!/bin/bash
source $PROG/ban_ip_conf.sh

create_ip-set china country
url=https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-china.list
run_ip-set-block "$url"

create_ip-set russia country
url=https://raw.githubusercontent.com/cbuijs/ipasn/master/country-europe-russia
run_ip-set-block "$url"

create_ip-set afgahanistan country
url=https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-afghanistan.list
run_ip-set-block "$url"

create_ip-set hk country
url=https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-hong-kong.list
run_ip-set-block "$url"

create_ip-set india country
url=https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-india.list
run_ip-set-block "$url"

create_ip-set iran country
url=https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-iran.list
run_ip-set-block "$url"

create_ip-set iraq country
url=https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-iraq.list
run_ip-set-block "$url"

create_ip-set kazakhstan country
url=https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-kazakhstan.list
run_ip-set-block "$url"

create_ip-set lebanon country
url=https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-lebanon.list
run_ip-set-block "$url"

create_ip-set mongolia country
url=https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-mongolia.list
run_ip-set-block "$url"


create_ip-set nk country
url=https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-north-korea.list
run_ip-set-block "$url"

create_ip-set pakistan country
url=https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-pakistan.list
run_ip-set-block "$url"

create_ip-set uzbekistan country
url=https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-uzbekistan.list
run_ip-set-block "$url"

create_ip-set philippines country
url=https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-philippines.list
run_ip-set-block "$url"

create_ip-set bahamas country
url=https://raw.githubusercontent.com/cbuijs/ipasn/master/country-north-america-bahamas.list
run_ip-set-block "$url"

create_ip-set cuba country
url=https://raw.githubusercontent.com/cbuijs/ipasn/master/country-north-america-cuba.list
run_ip-set-block "$url"

create_ip-set jamaica country
url=https://raw.githubusercontent.com/cbuijs/ipasn/master/country-north-america-jamaica.list
run_ip-set-block "$url"

create_ip-set jamaica country
url=https://raw.githubusercontent.com/cbuijs/ipasn/master/country-north-america-jamaica.list
run_ip-set-block "$url"

create_ip-set haiti country
url=https://raw.githubusercontent.com/cbuijs/ipasn/master/country-north-america-haiti.list
run_ip-set-block "$url"

create_ip-set dominica country
url=https://raw.githubusercontent.com/cbuijs/ipasn/master/country-north-america-dominica.list
run_ip-set-block "$url"

create_ip-set colombia country
url=https://raw.githubusercontent.com/cbuijs/ipasn/master/country-south-america-colombia.list
run_ip-set-block "$url"

create_ip-set ecuador country
url=https://raw.githubusercontent.com/cbuijs/ipasn/master/country-south-america-ecuador.list
run_ip-set-block "$url"

create_ip-set venezuela country
url=https://raw.githubusercontent.com/cbuijs/ipasn/master/country-south-america-venezuela.list
run_ip-set-block "$url"

create_ip-set venezuela country
url=https://raw.githubusercontent.com/cbuijs/ipasn/master/country-south-america-venezuela.list
run_ip-set-block "$url"

create_ip-set australia country
url=https://raw.githubusercontent.com/cbuijs/ipasn/master/country-oceania-australia.list
run_ip-set-block "$url"

save_ip-tables
