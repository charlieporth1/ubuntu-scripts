#!/bin/bash
source $PROG/all-scripts-exports.sh
dig www.robtex.com uptimerobot.com www.ipqualityscore.com > /dev/null
dns_ip_subnet=$(bash $PROG/get_ext_ip.sh dns.ctptech.dev | grepip -o)
dns_ip_subnet_v6=$(dig -t aaaa dns.ctptech.dev | grepip -o)

network_interface_ip_subnets=$(bash $PROG/get_network_devices_ip_address.sh --all | grepip -o)
current_ip_address=$(bash $PROG/get_ext_ip.sh --curent-ip | grepip -o)

dns_ip=$(bash $PROG/get_ext_ip.sh dns.ctptech.dev | grepip -o)
home_ip=$(bash $PROG/get_ext_ip.sh home.ctptech.dev | grepip -o)
gcp_ip=$(bash $PROG/get_ext_ip.sh gcp.ctptech.dev | grepip -o)
aws_ip=$(bash $PROG/get_ext_ip.sh aws.ctptech.dev | grepip -o)
gcp1_ip=$(bash $PROG/get_ext_ip.sh gcp1.ctptech.dev | grepip -o)
master_dns_ip=$(bash $PROG/get_ext_ip.sh master.dns.ctptech.dev | grepip -o)

IPv4_ROUTE=$(sudo ip route list | grepip -o | ip-sort)
IPv6_ROUTE=$(sudo ip -6 route list | grepip -o | ip-sort)

IP_ADDR=$(sudo ip addr | grepip -o | ip-sort)
IPv4_ADDR=$(sudo ip -4 addr | grepip -o | ip-sort)
IPv6_ADDR=$(sudo ip -6 addr | grepip -o | ip-sort)

tailscale_ip_addresses=$(tailscale status | awk '{print $1}' | grepip -o)
current_tailscale_ip_addresses=$(tailscale ip | grepip -o)

if [ "$0" == "$BASH_SOURCE" ]; then
	echo "IS_SOURCED"
	export IS_SOURCED=false
else
	export IS_SOURCED=true
fi
echo "IS_SOURCED $IS_SOURCED"

curl_timeout=8
CONCURRENT
#proxychains -q timeout $curl_timeout curl -H "Authorization: Bearer 29b6b3b552a343" ipinfo.io/AS21928
declare -a UNI_IGNORE_IPs
UNI_IGNORE_IP=(
	$dns_ip_subnet
	$dns_ip_subnet_v6
	$network_interface_ip_subnets
	$current_ip_address
	$dns_ip
	$home_ip
	$gcp_ip
	$aws_ip
	$gcp1_ip
	$master_dns_ip
	$IPv4_ROUTE
	$IPv6_ROUTE
	$IP_ADDR
	$IPv4_ADDR
	$IPv6_ADDR
	$current_ip_address
	$dns_ip_subnet
	$dns_ip_subnet_v6
	$network_interface_ip_subnets
	$tailscale_ip_addresses
	$current_tailscale_ip_addresses
	50.224.157.242 # CTP WORK
	100.101.102.103
	192.168.0.0/16
	192.168.0.0/16
	192.168.12.0/24
	192.168.100.0/24
	192.168.45.0/24
	192.168.44.0/24
	192.168.43.0/24
	192.168.42.0/24
	192.168.41.0/24
	192.168.40.0/24
	172.58.142.145
	192.168.127.10/32
	192.168.127.10
	108.73.128.11
	108.73.128.11 # AUNT SUE
        250.44.168.192
        192.168.127.10
	172.31.0.0/20
	10.128.0.0/20
	192.168.99.0/24
        192.168.44.1
        192.168.40.1
	10.138.0.0/20
	192.168.45.0/24
	192.168.44.0/24
	192.168.43.0/24
	192.168.42.0/24
	192.168.41.0/24
	192.168.40.0/24
        0.0.0.0
	0.0.0.0/8
	127.0.0.1
	127.0.0.0/8
	172.58.87.88    #
        172.58.156.197  # *
        172.195.69.25
        127.0.0.0/8
        174.53.130.17 # Home
	174.53.130.17/32
        169.254.169.254
        10.66.66.1
        10.66.66.0/24
        azure.ctptech.dev
        home.ctptech.dev
        aws.ctptech.dev
        gcp.ctptech.dev
        gcp1.ctptech.dev
        dns.ctptech.dev
	home.dns.ctptech.dev
        master.dns.ctptech.dev
)
declare -a UNI_IGNORE_IPs=( $( filter_ip_address_array "${UNI_IGNORE_IPs[@]}" ) )

declare -a DEFAULT_DNS_SERVERS
DEFAULT_DNS_SERVERS=(
	75.75.75.75
	75.75.76.76
	1.0.0.2
	1.1.1.2
        1.1.1.1
        1.0.0.1
        8.8.8.8
        8.8.4.4
        9.9.9.9
        9.9.9.10
        9.9.9.11
        9.9.9.12
        192.168.44.0/24
        192.168.123.0/24
        192.168.44.1
        192.168.40.1
        192.168.40.0/24
	192.168.1.1
        127.0.0.1
	100.100.100.100
)
declare -a DEFAULT_DNS_SERVERS=( $( filter_ip_address_array "${DEFAULT_DNS_SERVERS[@]}" ) )

declare -a UPTIME_IGNORE_IPs=(
        122.248.234.23/24
        63.143.42.248/24
	$(curl -sSL 'https://uptimerobot.com/help/locations/' | grep -oE "${IPV4_REGEX_SUBNET}")
	$(curl -sSL "https://uptimerobot.com/inc/files/ips/IPv4andIPv6.txt")
)
declare -a UPTIME_IGNORE_IPs=( $( filter_ip_address_array "${UPTIME_IGNORE_IPs[@]}" ) )

declare -a T_MobileIPs_SPRINT_asn
T_MobileIPs_SPRINT_asn=(
	AS3651
	AS36517
	AS10507
	AS19290
	AS27021
	AS5112
	AS32068
	AS19
	AS138667
	AS36134
	AS19292
	AS10507
)
declare -a T_MobileIPs_SPRINT
T_MobileIPs_SPRINT=(
	$(
		if [ "$IS_SOURCED" == 'false' ]; then
			for asn in "${T_MobileIPs_SPRINT_asn[@]}"
			do
				# https://superuser.com/questions/405666/how-to-find-out-all-ip-ranges-belonging-to-a-certain-as
				# IPv4
				whois -h whois.radb.net -- "-i origin $asn" | grep -Eo "([0-9.]+){4}/[0-9]+"
				# IPv6
				whois -h whois.radb.net -- "\!6$asn" | grep -Eo "$IPV6_FULL_REGEX_SUBNET"
			done
			for asn in "${T_MobileIPs_SPRINT_asn[@]}"
			do
				# IPv4
				proxychains -q timeout $curl_timeout curl -sL https://www.robtex.com/as/$asn.html | grep -oE "${IPV4_REGEX_SUBNET}"
				# IPv6
				proxychains -q timeout $curl_timeout curl -sL https://www.robtex.com/as/$asn.html | grep -oE "${IPV6_FULL_REGEX_SUBNET}"
			done
		fi
	)

	$(proxychains -q timeout $curl_timeout curl -sL https://myip.ms/view/web_hosting/1441/Sprint.html | grepip -4o | parallel $parallel_args echo '{}/18')
	$(proxychains -q timeout $curl_timeout curl -sL https://myip.ms/view/web_hosting/1441/Sprint.html | grepip -6o | parallel $parallel_args echo '{}/48')
)
declare -a T_MobileIPs_SPRINT=( $( filter_ip_address_array "${T_MobileIPs_SPRINT[@]}" ) )

declare -a T_MobileIPs_asn=(
	AS21928
	AS3651
	AS10507
	AS393494
	AS16586
	AS5079
	AS22140
)

declare -a T_MobileIPs
T_MobileIPs=(
${T_MobileIPs_SPRINT[@]}
	$(
		for asn in "${T_MobileIPs_asn[@]}"
		do
			# https://superuser.com/questions/405666/how-to-find-out-all-ip-ranges-belonging-to-a-certain-as
			# IPv4
			whois -h whois.radb.net -- "-i origin $asn" | grep -Eo "([0-9.]+){4}/[0-9]+"
			# IPv6
#			whois -h whois.radb.net -- "!6as714' -i origin $asn" | grep -Eo "$IPV6_FULL_REGEX_SUBNET"
			whois -h whois.radb.net -- "\!6$asn" | grep -Eo "$IPV6_FULL_REGEX_SUBNET"
		done
	)
	$(
		if [ "$IS_SOURCED" == 'false' ]; then
			for asn in "${T_MobileIPs_asn[@]}"
			do
				# IPv4
				proxychains -q timeout $curl_timeout curl -sL 'https://www.ipqualityscore.com/asn-details/$asn/t-mobile-usa-inc | grep -oE 
				proxychains -q timeout $curl_timeout curl -sL https://www.robtex.com/as/$asn.html | grep -oE "${IPV4_REGEX_SUBNET}"
				# IPv6
				proxychains -q timeout $curl_timeout curl -sL 'https://www.ipqualityscore.com/asn-details/$asn/t-mobile-usa-inc | grep -oE "${IPV6_FULL_REGEX_SUBNET}"
				proxychains -q timeout $curl_timeout curl -sL https://www.robtex.com/as/$asn.html | grep -oE "${IPV6_FULL_REGEX_SUBNET}"
			done
		fi
	)
$( curl -sL https://raw.githubusercontent.com/cbuijs/accomplist/master/chris/mobile.tmobile.list )
$( curl -sL https://raw.githubusercontent.com/cbuijs/accomplist/master/chris/mobile.tmobileus.list )
$( curl -sL https://raw.githubusercontent.com/cbuijs/accomplist/master/chris/white.tmobileus.ip.list )
$(proxychains -q timeout $curl_timeout curl -sL 'https://www.ipqualityscore.com/asn-details/AS21928/t-mobile-usa-inc' | grep -oE "${IPV4_REGEX_SUBNET}")
$(proxychains -q timeout $curl_timeout curl -sL https://myip.ms/view/ip_owners/1779/T_Mobile_Usa_Inc.html | grepip -4o | parallel $parallel_args echo '{}/18')
$(proxychains -q timeout $curl_timeout curl -sL https://myip.ms/view/ip_owners/1779/T_Mobile_Usa_Inc.html | grepip -6o | parallel $parallel_args echo '{}/48')
$(proxychains -q timeout $curl_timeout curl -sL https://myip.ms/browse/ip_ranges/1/ownerID/1779/ownerID_A/1 | grepip -4o | parallel $parallel_args echo '{}/18')
$(proxychains -q timeout $curl_timeout curl -sL https://myip.ms/browse/comp_ip/1/ownerID/1779/ownerID_A/1 | grepip -4o | parallel $parallel_args echo '{}/18')
74.125.42.39
172.56.0.0/8
172.100.0.0/16
172.195.0.0/16
172.56.0.0/16
100.128.0.0/9
162.160.0.0/11
172.32.0.0/11
172.58.0.0/16   # T-Mobile
172.58.87.88    #
172.58.156.197  # *
172.195.69.25
100.128.0.0/9
162.160.0.0/11
162.186.0.0/15
162.190.0.0/16
162.191.0.0/16
172.32.0.0/11
172.56.0.0/16
172.56.10.0/23
172.56.12.0/23
172.56.132.0/24
172.56.134.0/24
172.56.136.0/24
172.56.138.0/24
172.56.140.0/24
172.56.14.0/23
172.56.143.0/24
172.56.146.0/24
172.56.16.0/23
172.56.20.0/23
172.56.2.0/23
172.56.22.0/23
172.56.26.0/23
172.56.28.0/23
172.56.30.0/23
172.56.34.0/23
172.56.36.0/23
172.56.38.0/23
172.56.40.0/23
172.56.4.0/23
172.56.42.0/23
172.56.44.0/23
172.56.6.0/23
172.58.0.0/15
172.58.0.0/21
172.58.104.0/21
172.58.120.0/21
172.58.136.0/21
172.58.144.0/21
172.58.152.0/21
172.58.16.0/21
172.58.168.0/21
172.58.184.0/21
172.58.200.0/21
172.58.216.0/21
172.58.224.0/21
172.58.232.0/21
172.58.24.0/21
172.58.32.0/21
172.58.40.0/21
172.58.56.0/21
172.58.64.0/21
172.58.72.0/21
172.58.80.0/21
172.58.8.0/21
172.58.88.0/21
172.58.96.0/21
174.141.208.0/20
206.29.188.0/23
206.29.190.0/23
208.54.0.0/17
208.54.100.0/22
208.54.104.0/24
208.54.108.0/22
208.54.112.0/24
208.54.117.0/24
208.54.127.0/24
208.54.128.0/19
208.54.134.0/23
208.54.136.0/23
208.54.138.0/23
208.54.140.0/23
208.54.142.0/24
208.54.143.0/24
208.54.144.0/20
208.54.145.0/24
208.54.147.0/24
208.54.153.0/24
208.54.16.0/24
208.54.17.0/24
208.54.18.0/24
208.54.19.0/24
208.54.20.0/24
208.54.2.0/24
208.54.33.0/24
208.54.34.0/24
208.54.35.0/24
208.54.36.0/24
208.54.37.0/24
208.54.39.0/24
208.54.40.0/24
208.54.4.0/24
208.54.44.0/24
208.54.5.0/24
208.54.66.0/24
208.54.67.0/24
208.54.70.0/24
208.54.7.0/24
208.54.74.0/24
208.54.75.0/24
208.54.76.0/22
)
declare -a T_MobileIPs=( $( filter_ip_address_array "${TMobileIPs[@]}" ) )

declare -a local_ignore_ips
local_ignore_ips=(
	$( curl -s 'https://en.wikipedia.org/wiki/Reserved_IP_addresses' | grep -oE "${IPV4_REGEX_SUBNET}")
	$( curl -s 'https://en.wikipedia.org/wiki/Reserved_IP_addresses' | grep -oE "${IPV6_REGEX_SUBNET}")
	$( curl -s https://raw.githubusercontent.com/cbuijs/accomplist/master/chris/private-addresses.list)
)
declare -a DNS_IGNORE_IPs
DNS_IGNORE_IPs=(
	${T_MobileIPs[@]}
        ${UPTIME_IGNORE_IPs[@]}
        ${DEFAULT_DNS_SERVERS[@]}
	${local_ignore_ips[@]}
	67.0.0.0/8
	67.172.110.244
        0.0.0.0
        172.53.0.0/16
	67.172.110.244/24
	67.172.110.244/16
        172.58.0.0/16
        172.100.122.109
        192.168.40.0/24 # Internal servers
        192.168.99.9    #
        10.128.0.9      # *
        ${UNI_IGNORE_IP[@]}
        35.192.105.158
        35.232.120.211
        174.53.130.17
)
declare -a DNS_IGNORE_IPs=( $( filter_ip_address_array "${DNS_IGNORE_IPs[@]}" ) )

IPv4_subnets_list=$(seq 0 32 | parallel echo '/{}')
IPv6_subnets_list=$(seq 0 128 | parallel echo '/{}')
declare -a subnet_ignore_list=(
	0.0.0.0/0
	0.0.0.0/8
	::0/0
	::1/128
	127.0.0.0/8
	$(
		parallel $parallel_args printf '%-1s%-1s\\n' "{}" ::: $current_ip_address ::: $IPv4_subnets_list;
		parallel $parallel_args printf '%-1s%-1s\\n' "{}" ::: $dns_ip_subnet ::: $IPv4_subnets_list

		if [ "$IS_SOURCED" == 'false' ]; then
			parallel $parallel_args printf '%-1s%-1s\\n' "{}" ::: $network_interface_ip_subnets ::: $IPv4_subnets_list;
			parallel $parallel_args printf '%-1s%-1s\\n' "{}" ::: $tailscale_ip_addresses ::: $IPv4_subnets_list;

			parallel $parallel_args printf '%-1s%-1s\\n' "{}" ::: $dns_ip_subnet_v6 ::: $IPv6_subnets_list

			parallel $parallel_args printf '%-1s%-1s\\n' "{}" ::: $IPv4_ADDR ::: $IPv4_subnets_list;
			parallel $parallel_args printf '%-1s%-1s\\n' "{}" ::: $IPv6_ADDR ::: $IPv6_subnets_list;

			parallel $parallel_args printf '%-1s%-1s\\n' "{}" ::: 0.0.0.0 127.0.0.1 ::: $IPv4_subnets_list
			parallel $parallel_args printf '%-1s%-1s\\n' "{}" ::: :: ::0 ::1 ::: $IPv6_subnets_list
		fi
	)
)
# IPv4
declare -a subnet_ignore_list=( $( filter_ip_address_array "${subnet_ignore_list[@]}" ) )

export FILE_NAME='ban_ignore_ip_list'
export INGNORE_IP_FILE_NAME="$FILE_NAME"
export INGNORE_IP="$FILE_NAME"
export INGNORE_IP_TXT=/tmp/$FILE_NAME.txt
export INGNORE_IP_LOCAL_TXT=/tmp/$FILE_NAME-local-address.txt
export INGNORE_IP_CSV=/tmp/$FILE_NAME.csv
export INGNORE_IP_GREP=/tmp/$FILE_NAME.grep
export INGNORE_IP_UNI=/tmp/$FILE_NAME-uni.txt
export INGNORE_IP_TMOBILE=/tmp/$FILE_NAME-t-mobile.txt
export INGNORE_IP_SUBNET=/tmp/$FILE_NAME-subnet.txt
export INGNORE_IP_SUBNET_GREP=/tmp/$FILE_NAME-subnet.grep

INGORE_IP_ADRESSES_GREP=$( bash $PROG/grepify.sh $( printf '%s\n' "${DNS_IGNORE_IPs[@]}" | ip-sort ) )
INGORE_IP_ADRESSES_SUBNET_GREP=$( bash $PROG/grepify.sh $( printf '%s\n' "${subnet_ignore_list[@]}" | ip-sort ) )
INGORE_IP_ADRESSES_CSV=$( bash $PROG/csvify.sh $( printf '%s\n' "${DNS_IGNORE_IPs[@]}" | ip-sort ) )


if [ "$IS_SOURCED" == 'false' ]; then
	echo "Bash non source writing files"
	printf '%s\n' "${DNS_IGNORE_IPs[@]}" | ip-sort | sudo tee $INGNORE_IP_TXT
	printf "%s\n" "${UNI_IGNORE_IP[@]}" | ip-sort | sudo tee $INGNORE_IP_UNI


	printf '%s\n' "${subnet_ignore_list[@]}" | ip-sort | sudo tee $INGNORE_IP_SUBNET
	printf '%s\n' "${T_MobileIPs[@]}" | sudo tee $INGNORE_IP_TMOBILE
	printf '%s\n' "${local_ignore_ips[@]}" | sudo tee $INGNORE_IP_LOCAL_TXT

	echo "$INGORE_IP_ADRESSES_SUBNET_GREP" | sudo tee $INGNORE_IP_SUBNET_GREP
	echo "$INGORE_IP_ADRESSES_GREP" | sudo tee $INGNORE_IP_GREP
	echo "$INGORE_IP_ADRESSES_CSV" | sudo tee $INGNORE_IP_CSV
else
	echo "Bash is source not writing files"
fi

d='
$(
	if [ "$0" == "$BASH_SOURCE" ]; then
		export counter=0
		export count_max=3
		for i in $(seq 1 1000)
		do
			if [[ $counter -le $count_max ]]; then
				export counter=$(( $counter + 1 ))
				(
				 	proxychains -q timeout $curl_timeout curl -sL https://myip.ms/browse/comp_ip/1/ownerID/1779/ownerID_A/$i | grepip -4o | parallel $parallel_args echo '{}/18'
				 	proxychains -q timeout $curl_timeout curl -sL https://myip.ms/browse/comp_ip6/1/ownerID/1779/ownerID_A/$i | grepip -6o | parallel $parallel_args echo '{}/48'
				)&
			else
				export counter=0
			 	proxychains -q timeout $curl_timeout curl -sL https://myip.ms/browse/comp_ip/1/ownerID/1779/ownerID_A/$i | grepip -4o | parallel $parallel_args echo '{}/18'
			 	proxychains -q timeout $curl_timeout curl -sL https://myip.ms/browse/comp_ip6/1/ownerID/1779/ownerID_A/$i | grepip -6o | parallel $parallel_args echo '{}/48'
			fi
		done
	fi
)
	$(
		if [ "$0" == "$BASH_SOURCE" ]; then
			for asn in "${T_MobileIPs_asn[@]}"
			do
				# https://superuser.com/questions/405666/how-to-find-out-all-ip-ranges-belonging-to-a-certain-as
				# IPv4
				timeout $curl_timeout curl -sL "https://bgp.he.net/$asn#_prefixes4" | grep -Eo "([0-9.]+){4}/[0-9]+"
				# IPv6
				timeout $curl_timeout curl -sL "https://bgp.he.net/$asn#_prefixes6" | grep -Eo "$IPV6_FULL_REGEX_SUBNET"
			done
		fi
	)

'
