#!/bin/bash
CONFIG_DIR=/etc/ipset
! [[ -d $CONFIG_DIR ]] && mkdir -p $CONFIG_DIR
function create_ip-set() {
        local COUNTRY="$1"

        declare -gx IPSET_BK_NAME=country-blacklist-$COUNTRY
	declare -gx IPSET_FILE=$CONFIG_DIR/$IPSET_BK_NAME.ipset
	echo $IPSET_BK_NAME
        sudo ipset create $IPSET_BK_NAME hash:net hashsize 8192
        sudo iptables -I INPUT -m set --match-set $IPSET_BK_NAME src -j DROP -w
        sudo iptables -I FORWARD -m set --match-set $IPSET_BK_NAME src -j DROP -w

	if [[ -f $IPSET_FILE ]]; then
		ipset restore < $IPSET_FILE
	else
		touch $IPSET_FILE
	fi
	sleep 5s

}
create_ip-set china
echo $IPSET_BK_NAME
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-china.list) )
for ip in  "${ban_ips[@]}"
do
	echo $ip
	ipset add $IPSET_BK_NAME $ip
	sleep 0.250s
done
ipset save $IPSET_BK_NAME > $IPSET_FILE

create_ip-set russia
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-europe-russia))
for ip in  "${ban_ips[@]}"
do
	ipset add $IPSET_BK_NAME $ip
	sleep 0.250s
done
ipset save $IPSET_BK_NAME > $IPSET_FILE

create_ip-set afgahanistan
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-afghanistan.list) )
for ip in  "${ban_ips[@]}"
do
	ipset add $IPSET_BK_NAME $ip
	sleep 0.250s
done
ipset save $IPSET_BK_NAME > $IPSET_FILE

create_ip-set hk
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-hong-kong.list))
for ip in  "${ban_ips[@]}"
do
	ipset add $IPSET_BK_NAME $ip
	sleep 0.250s
done
ipset save $IPSET_BK_NAME > $IPSET_FILE

create_ip-set india
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-india.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip
	sleep 0.250s
done
ipset save $IPSET_BK_NAME > $IPSET_FILE

create_ip-set iran
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-iran.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip
	sleep 0.250s
done
ipset save $IPSET_BK_NAME > $IPSET_FILE

create_ip-set iraq
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-iraq.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip
	sleep 0.250s
done
ipset save $IPSET_BK_NAME > $IPSET_FILE

create_ip-set kazakhstan
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-kazakhstan.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip
	sleep 0.250s
done
ipset save $IPSET_BK_NAME > $IPSET_FILE

create_ip-set lebanon
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-lebanon.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip
	sleep 0.250s
done
ipset save $IPSET_BK_NAME > $IPSET_FILE

create_ip-set mongolia
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-mongolia.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip
	sleep 0.250s
done
ipset save $IPSET_BK_NAME > $IPSET_FILE


create_ip-set nk
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-north-korea.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip
	sleep 0.250s
done
ipset save $IPSET_BK_NAME > $IPSET_FILE


create_ip-set pakistan
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-pakistan.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip
	sleep 0.250s
done
ipset save $IPSET_BK_NAME > $IPSET_FILE


create_ip-set uzbekistan
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-uzbekistan.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip
	sleep 0.250s
done
ipset save $IPSET_BK_NAME > $IPSET_FILE


create_ip-set philippines
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-asia-philippines.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip
	sleep 0.250s
done
ipset save $IPSET_BK_NAME > $IPSET_FILE


create_ip-set bahamas
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-north-america-bahamas.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip
	sleep 0.250s
done
ipset save $IPSET_BK_NAME > $IPSET_FILE

create_ip-set cuba
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-north-america-cuba.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip
	sleep 0.250s
done
ipset save $IPSET_BK_NAME > $IPSET_FILE

create_ip-set jamaica
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-north-america-jamaica.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip
	sleep 0.250s
done
ipset save $IPSET_BK_NAME > $IPSET_FILE

create_ip-set jamaica
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-north-america-jamaica.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip
	sleep 0.250s
done
ipset save $IPSET_BK_NAME > $IPSET_FILE

create_ip-set haiti
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-north-america-haiti.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip
	sleep 0.250s
done
ipset save $IPSET_BK_NAME > $IPSET_FILE

create_ip-set dominica
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-north-america-dominica.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip
	sleep 0.250s
done
ipset save $IPSET_BK_NAME > $IPSET_FILE

create_ip-set colombia
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-south-america-colombia.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip
	sleep 0.250s
done
ipset save $IPSET_BK_NAME > $IPSET_FILE

create_ip-set ecuador
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-south-america-ecuador.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip
	sleep 0.250s
done
ipset save $IPSET_BK_NAME > $IPSET_FILE

create_ip-set venezuela
declare -a ban_ips
ban_ips=( $(curl -s https://raw.githubusercontent.com/cbuijs/ipasn/master/country-south-america-venezuela.list))
for ip in  "${ban_ips[@]}"
do
        ipset add $IPSET_BK_NAME $ip
	sleep 0.250s
done
ipset save $IPSET_BK_NAME > $IPSET_FILE

sudo iptables-save
