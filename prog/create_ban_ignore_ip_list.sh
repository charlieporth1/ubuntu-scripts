#!/bin/bash
source $PROG/all-scripts-exports.sh
CONCURRENT
declare -a UNI_IGNORE_IPs
UNI_IGNORE_IP=(
	192.168.127.10/32
	192.168.127.10
	172.58.0.0/16
	35.192.105.0/24
	35.192.105.158/32
	35.192.105.158
	35.232.120.211/24
	35.232.120.211/32
	35.232.120.211
	172.31.12.154
	172.31.12.154/16
        192.168.44.29/16
        102.168.44.250
        192.168.44.29
        17.130.53.174
        158.105.192.35
        9.123.168.192
	108.73.128.11
	108.73.128.11 # AUNT SUE
        8.123.168.192
        51.44.168.192
        250.44.168.192
        192.168.127.10
        192.168.44.1
        192.168.40.1
        0.0.0.0
        172.58.87.88    #
        172.58.156.197  # *
        172.195.69.25
        127.0.0.0/8
        174.53.130.17 # Home
	174.53.130.17/32
        192.168.0.0/16
        192.168.44.0/24
        192.168.40.0/24
        169.254.169.254
        10.66.66.1
        10.66.66.0/24
        $(bash $PROG/get_ext_ip.sh dns.ctptech.dev | grep -o "${IP_REGEX}")
        $(bash $PROG/get_ext_ip.sh home.ctptech.dev | grep -o "${IP_REGEX}")
        $(bash $PROG/get_ext_ip.sh gcp.ctptech.dev | grep -o "${IP_REGEX}")
        $(bash $PROG/get_ext_ip.sh master.dns.ctptech.dev | grep -o "${IP_REGEX}")
        $(bash $PROG/get_ext_ip.sh --curent-ip | grep -o "${IP_REGEX}")
        $(bash $PROG/get_network_devices_ip_address.sh --loop --wlan | grep -o "${IP_REGEX}")
        home.ctptech.dev
        azure.ctptech.dev
        aws.ctptech.dev
        gcp.ctptech.dev
        dns.ctptech.dev
        master.dns.ctptech.dev
)
UNI_IGNORE_IPs=( $( filter_ip_address_array "${UNI_IGNORE_IPs[@]}" ) )

declare -a DEFAULT_DNS_SERVERS=(
        1.0.0.1
        1.1.1.1
        8.8.8.8
        8.8.4.4
        9.9.9.9
        192.168.44.1
        192.168.40.1
        127.0.0.1
)
filter_ip_address_array "${DEFAULT_DNS_SERVERS[@]}"

declare -a UPTIME_IGNORE_IPs=(
        122.248.234.23/24
        63.143.42.248/24
)
UNI_IGNORE_IPs=( $( filter_ip_address_array "${UNI_IGNORE_IPs[@]}" ) )

declare -a TMobileIPs
T_MobileIPs=(
$(curl -s https://raw.githubusercontent.com/cbuijs/accomplist/master/chris/mobile.tmobile.list)
$(curl -s https://raw.githubusercontent.com/cbuijs/accomplist/master/chris/mobile.tmobileus.list)
$(curl -s https://raw.githubusercontent.com/cbuijs/accomplist/master/chris/white.tmobileus.ip.list)
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


TMobileIPs=( $( filter_ip_address_array "${TMobileIPs[@]}" ) )


declare -a DNS_IGNORE_IPs
DNS_IGNORE_IPs=(
        ${UPTIME_IGNORE_IPs[@]}
        ${DEFAULT_DNS_SERVERS[@]}
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

for i in {0..255}
do
        IP_PRIVATE=192.168.1.$i
        IP_PRIVATE_1=192.168.44.$i
        IP_PRIVATE_2=192.168.43.$i
        IP_PRIVATE_3=192.168.40.$i
        IP_NON=0.0.0.$i
        DNS_IGNORE_IPs=(
                ${DNS_IGNORE_IPs[@]}
                $IP_NON $IP_PRIVATE
                $IP_PRIVATE_1
                $IP_PRIVATE_2
                $IP_PRIVATE_3
        )
done


DNS_IGNORE_IPs=( $( filter_ip_address_array "${DNS_IGNORE_IPs[@]}" ) )

IP_REGEX="((([0-9]{1,3})\.){4})"
FILE_NAME='ban_ignore_ip_list'

INGORE_IP_ADRESSES_GREP=$( bash $PROG/grepify.sh $( echo "${DNS_IGNORE_IPs[@]}" ) )
INGORE_IP_ADRESSES_CSV=$( bash $PROG/csvify.sh $( echo "${DNS_IGNORE_IPs[@]}" ) )

printf '%s\n' "${DNS_IGNORE_IPs[@]}" > /tmp/$FILE_NAME.txt
echo "$INGORE_IP_ADRESSES_GREP" > /tmp/$FILE_NAME.grep
echo "$INGORE_IP_ADRESSES_CSV" > /tmp/$FILE_NAME.csv



printf '%s\n' ${T_MobileIPs[@]} /tmp/tmobile_ips.txt
