#!/bin/bash
source $PROG/all-scripts-exports.sh
dig www.robtex.com uptimerobot.com www.ipqualityscore.com > /dev/null
CONCURRENT
#curl -H "Authorization: Bearer 29b6b3b552a343" ipinfo.io/AS21928
declare -a UNI_IGNORE_IPs
UNI_IGNORE_IP=(
	192.168.0.0/16
	172.58.142.145
	192.168.127.10/32
	192.168.127.10
	108.73.128.11
	108.73.128.11 # AUNT SUE
        250.44.168.192
        192.168.127.10
        192.168.44.1
        192.168.40.1
        0.0.0.0
	0.0.0.0/8
        172.58.87.88    #
        172.58.156.197  # *
        172.195.69.25
        127.0.0.0/8
        174.53.130.17 # Home
	174.53.130.17/32
        169.254.169.254
        10.66.66.1
        10.66.66.0/24
        $(bash $PROG/get_ext_ip.sh dns.ctptech.dev | grepip -o)
        $(bash $PROG/get_ext_ip.sh home.ctptech.dev | grepip -o)
        $(bash $PROG/get_ext_ip.sh gcp.ctptech.dev | grepip -o)
        $(bash $PROG/get_ext_ip.sh aws.ctptech.dev | grepip -o)
        $(bash $PROG/get_ext_ip.sh gcp1.ctptech.dev | grepip -o)
        $(bash $PROG/get_ext_ip.sh master.dns.ctptech.dev | grepip -o)
        $(bash $PROG/get_ext_ip.sh --curent-ip | grepip -o)
        $(bash $PROG/get_network_devices_ip_address.sh --all)
        $(sudo ip route list | grepip -o | sort -u | grepip -o)
        azure.ctptech.dev
        home.ctptech.dev
        aws.ctptech.dev
        gcp.ctptech.dev
        gcp1.ctptech.dev
        dns.ctptech.dev
	home.dns.ctptech.dev
        master.dns.ctptech.dev
)
#UNI_IGNORE_IPs=( $( filter_ip_address_array "${UNI_IGNORE_IPs[@]}" ) )

declare -a DEFAULT_DNS_SERVERS
DEFAULT_DNS_SERVERS=(
	1.0.0.2
	1.1.1.2
        1.1.1.1
        1.0.0.1
        8.8.8.8
        8.8.4.4
        9.9.9.9
        192.168.44.1
        192.168.40.1
        192.168.40.0/24
	192.168.1.1
        127.0.0.1
	100.100.100.100
)
#filter_ip_address_array "${DEFAULT_DNS_SERVERS[@]}"

declare -a UPTIME_IGNORE_IPs=(
        122.248.234.23/24
        63.143.42.248/24
	$(curl -sSL 'https://uptimerobot.com/help/locations/' | grep -oE "${IPV4_REGEX_SUBNET}")
	$(curl -sSL "https://uptimerobot.com/inc/files/ips/IPv4andIPv6.txt" | grep -oE "${IPV4_REGEX_SUBNET}")
)
UNI_IGNORE_IPs=( $( filter_ip_address_array "${UNI_IGNORE_IPs[@]}" ) )

declare -a T_MobileIPs_SPRINT
T_MobileIPs_SPRINT=(
	$(curl -sL https://www.robtex.com/as/AS3651.html | grep -oE "${IPV4_REGEX_SUBNET}")
	$(curl -sL https://www.robtex.com/as/AS36517.html | grep -oE "${IPV4_REGEX_SUBNET}")
	$(curl -sL https://www.robtex.com/as/AS10507.html | grep -oE "${IPV4_REGEX_SUBNET}")
	$(curl -sL https://www.robtex.com/as/AS19290.html | grep -oE "${IPV4_REGEX_SUBNET}")
	$(curl -sL https://www.robtex.com/as/AS10507.html | grep -oE "${IPV4_REGEX_SUBNET}")
	$(curl -sL https://www.robtex.com/as/AS19290.html | grep -oE "${IPV4_REGEX_SUBNET}")
	$(curl -sL https://www.robtex.com/as/AS27021.html | grep -oE "${IPV4_REGEX_SUBNET}")
	$(curl -sL https://www.robtex.com/as/AS5112.html | grep -oE "${IPV4_REGEX_SUBNET}")
	$(curl -sL https://www.robtex.com/as/AS32068.html | grep -oE "${IPV4_REGEX_SUBNET}")
	$(curl -sL https://www.robtex.com/as/AS19.html | grep -oE "${IPV4_REGEX_SUBNET}")
	$(curl -sL https://www.robtex.com/as/AS138667.html | grep -oE "${IPV4_REGEX_SUBNET}")
	$(curl -sL https://www.robtex.com/as/AS36134.html | grep -oE "${IPV4_REGEX_SUBNET}")
	$(curl -sL https://www.robtex.com/as/AS19292.html | grep -oE "${IPV4_REGEX_SUBNET}")
	$(curl -sL https://www.robtex.com/as/AS10507.html | grep -oE "${IPV4_REGEX_SUBNET}")
	$(curl -sL https://www.robtex.com/as/AS10507.html | grep -oE "${IPV4_REGEX_SUBNET}")
	$(curl -sL https://www.robtex.com/as/AS10507.html | grep -oE "${IPV4_REGEX_SUBNET}")
	$(curl -sL https://www.robtex.com/as/AS10507.html | grep -oE "${IPV4_REGEX_SUBNET}")
)
declare -a T_MobileIPs
T_MobileIPs=(
${T_MobileIPs_SPRINT[@]}
$(curl -sL https://www.robtex.com/as/AS21928.html | grep -oE "${IPV4_REGEX_SUBNET}")
$(curl -sL https://www.robtex.com/as/AS21928.html | grep -oE "${IPV4_REGEX_SUBNET}")
$(curl -sL https://www.robtex.com/as/AS10507.html | grep -oE "${IPV4_REGEX_SUBNET}")
$(curl -sL https://www.robtex.com/as/AS3651.html | grep -oE "${IPV4_REGEX_SUBNET}")
$(curl -sL https://www.robtex.com/as/AS16586.html | grep -oE "${IPV4_REGEX_SUBNET}")
$(curl -sL https://www.robtex.com/as/AS393494.html | grep -oE "${IPV4_REGEX_SUBNET}")
$(curl -sL https://www.robtex.com/as/AS5079.html | grep -oE "${IPV4_REGEX_SUBNET}")
$(curl -sL https://www.robtex.com/as/AS22140.html | grep -oE "${IPV4_REGEX_SUBNET}")
$(curl -sL 'https://www.ipqualityscore.com/asn-details/AS21928/t-mobile-usa-inc' | grep -oE "${IPV4_REGEX_SUBNET}")
$(curl -sL https://raw.githubusercontent.com/cbuijs/accomplist/master/chris/mobile.tmobile.list)
$(curl -sL https://raw.githubusercontent.com/cbuijs/accomplist/master/chris/mobile.tmobileus.list)
$(curl -sL https://raw.githubusercontent.com/cbuijs/accomplist/master/chris/white.tmobileus.ip.list)
$(curl -sL 'https://www.ipqualityscore.com/asn-details/AS21928/t-mobile-usa-inc' | grep -oE "${IPV4_REGEX_SUBNET}")
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


#T_MobileIPs=( $( filter_ip_address_array "${TMobileIPs[@]}" ) )

declare -a local_ignore_ips
local_ignore_ips=(
	$(curl -s 'https://en.wikipedia.org/wiki/Reserved_IP_addresses' | grep -oE "${IPV4_REGEX_SUBNET}")
	$(curl -s 'https://en.wikipedia.org/wiki/Reserved_IP_addresses' | grep -oE "${IPV6_REGEX_SUBNET}")
)
declare -a DNS_IGNORE_IPs
DNS_IGNORE_IPs=(
	${T_MobileIPs[@]}
        ${UPTIME_IGNORE_IPs[@]}
        ${DEFAULT_DNS_SERVERS[@]}
	${local_ignore_ips[@]}
        0.0.0.0
        172.53.0.0/16
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



#DNS_IGNORE_IPs=( $( filter_ip_address_array "${DNS_IGNORE_IPs[@]}" ) )

export FILE_NAME='ban_ignore_ip_list'
export INGNORE_IP_FILE_NAME="$FILE_NAME"
export INGNORE_IP="$FILE_NAME"
export INGNORE_IP_TXT=/tmp/$FILE_NAME.txt
export INGNORE_IP_LOCAL_TXT=/tmp/$FILE_NAME-local-address.txt
export INGNORE_IP_CSV=/tmp/$FILE_NAME.csv
export INGNORE_IP_GREP=/tmp/$FILE_NAME.grep
export INGNORE_IP_UNI=/tmp/$FILE_NAME-uni.txt
export INGNORE_IP_TMOBILE=/tmp/$FILE_NAME-t-mobile.txt

INGORE_IP_ADRESSES_GREP=$( bash $PROG/grepify.sh $( printf '%s\n' "${DNS_IGNORE_IPs[@]}" | ip-sort ) )
INGORE_IP_ADRESSES_CSV=$( bash $PROG/csvify.sh $( printf '%s\n' "${DNS_IGNORE_IPs[@]}" | ip-sort ) )


if [ "$0" == "$BASH_SOURCE" ]; then
	printf '%s\n' "${DNS_IGNORE_IPs[@]}" | ip-sort | sudo tee $INGNORE_IP_TXT
	printf "%s\n" "${UNI_IGNORE_IP[@]}" | ip-sort | sudo tee $INGNORE_IP_UNI
	echo "$INGORE_IP_ADRESSES_GREP" | sudo tee $INGNORE_IP_GREP
	echo "$INGORE_IP_ADRESSES_CSV" | sudo tee $INGNORE_IP_CSV


	printf '%s\n' "${T_MobileIPs[@]}" | sudo tee $INGNORE_IP_TMOBILE
	printf '%s\n' "${local_ignore_ips[@]}" | sudo tee $INGNORE_IP_LOCAL_TXT
fi
