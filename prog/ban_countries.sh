#!/bin/bash
source $PROG/ban_ip_conf.sh
create_ip-set china county
echo $IPSET_BK_NAME
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-china.list) )
for ip in  "${ban_ips[@]}"
do
	echo $ip
	ipset add $IPSET_BK_NAME $ip
done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL

create_ip-set russia county
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-europe-russia))
for ip in  "${ban_ips[@]}"
do
	ipset add $IPSET_BK_NAME $ip

done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL

create_ip-set afgahanistan county
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-afghanistan.list) )
for ip in  "${ban_ips[@]}"
do
	ipset add $IPSET_BK_NAME $ip

done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL

create_ip-set hk county
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-hong-kong.list))
for ip in  "${ban_ips[@]}"
do
	ipset add $IPSET_BK_NAME $ip

done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL

create_ip-set india county
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-india.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip

done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL

create_ip-set iran county
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-iran.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip

done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL

create_ip-set iraq county
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-iraq.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip
done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL

create_ip-set kazakhstan county
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-kazakhstan.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip

done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL

create_ip-set lebanon county
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-lebanon.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip

done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL

create_ip-set mongolia county
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-mongolia.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip

done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL


create_ip-set nk county
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-north-korea.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip

done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL


create_ip-set pakistan county
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-pakistan.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip

done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL


create_ip-set uzbekistan county
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-uzbekistan.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip

done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL


create_ip-set philippines county
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-philippines.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip

done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL


create_ip-set bahamas county
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-north-america-bahamas.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip

done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL

create_ip-set cuba county
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-north-america-cuba.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip

done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL

create_ip-set jamaica county
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-north-america-jamaica.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip

done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL

create_ip-set jamaica county
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-north-america-jamaica.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip

done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL

create_ip-set haiti county
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-north-america-haiti.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip

done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL

create_ip-set dominica county
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-north-america-dominica.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip

done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL

create_ip-set colombia county
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-south-america-colombia.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip

done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL

create_ip-set ecuador county
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-south-america-ecuador.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip

done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL

create_ip-set venezuela county
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-south-america-venezuela.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip

done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL

save_ip-tables
