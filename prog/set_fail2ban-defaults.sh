#!/bin/bash

source $PROG/all-scripts-exports.sh
source $PROG/ban_ip_conf.sh
CONCURRENT
FILE_NAME='ban_ignore_ip_list'
DEFUALT_FILE=/tmp/$FILE_NAME.txt
UNI_FILE=/tmp/$FILE_NAME-uni.txt
DEFUALT_FILE=/tmp/$FILE_NAME.txt
# regex test

# fail2ban-regex /var/log/pihole.log /etc/fail2ban/filter.d/pihole-dns-1-block.conf
# fail2ban-regex /var/log/pihole.log /etc/fail2ban/filter.d/pihole-dns.conf
# fail2ban-regex -D --verbosity=4 /var/log/ctp-dns/default.log  /etc/fail2ban/filter.d/ctp-dns-1-block.conf
# fail2ban-regex -D --verbosity=4 /var/log/ctp-dns/fail2ban-test.log  /etc/fail2ban/filter.d/ctp-dns-1-block.conf
# fail2ban-regex -D --verbosity=4 /var/log/ctp-dns/error.log  /etc/fail2ban/filter.d/ctp-dns-1-block.conf
#$PROG/lookup_ip_address_business.sh --ip=
if ! [[ -f $DEFUALT_FILE ]]; then
        bash $PROG/create_ban_ignore_ip_list.sh
fi

#curl -o /tmp/phising_ip_addres.csv  https://openphish.com/samples/ip_feed.csv

declare -a MY_PIHOLE_BAN_IPs
MY_PIHOLE_BAN_IPs=(
	208.108.195.248
	1.193.219.1
	1.193.219.1/16
	67.80.4.215/16
	67.80.4.215
	143.198.4.69
	143.198.4.69/16
	172.78.34.205/24
	172.78.34.205/16
	35.133.200.76/24
	172.78.34.205
	35.133.200.76/16
	35.133.200.76
	172.red-80-25-158.staticip.rima-tde.net
	47-217-50-170.enidcmta02.res.dyn.suddenlink.net
	invalid.mannford.ok.mbo.net
	45.130.83.194/16
	47.157.216.195/16
	72.46.5.117/16
	67.168.226.169/16
	27.216.192.200/16
	47.20.110.73/16
	128.116.73.35/16
	86.30.46.221/16
	99.146.54.18/16
	71.131.69.58/16
	122.61.58.159/16
	107.214.163.206/16
	59.111.132.108/16
	69.122.49.59/16
	98.238.204.17/16
	162.193.49.196/16
	209.237.105.105/16
	172.221.6.14/16
	172.119.58.56/16
	82.25.60.85/16
	95.8.39.112/16
	24.4.161.186/16
	73.129.161.106/16
	87.242.155.254/16
	173.174.42.58/16
	18.156.254.225/16
	107.145.073.006/16
	13.104.97.130/16
	203.40.110.210/16
	172.119.140.135/16
	125.162.102.215/16
	51.0.2704.103/16
	118.144.11.13/16
	134.209.202.23/16
	23.95.191.195/16
	162.142.125.39/16
	38.123.125.111
	140.177.226.236
	140.177.226.236/16
	38.123.125.111/24
	100.16.123.164/16
	70.70.70.70
	70.70.70.70/16
	70.70.70.70/16
	176.118.193.114/16
	216.239.190.172/16
	46.48.207.53/16
	91.223.64.203/16
	71.84.58.32/16
	45.157.235.194/16
	98.33.252.50/16
	185.152.66.101/16
	37.248.175.134/16
	173.197.8.250/16
	145.239.236.44/16
	79.191.249.163/16
	152.228.203.225/16
	129.226.23.186/16
	74.74.74.73/24
	178.14.211.19/16
	46.31.79.138/16
	47.31.79.138/16
	48.31.79.138/16
	49.31.79.138/16
	50.31.79.138/16
	44.31.79.138/16
	43.31.79.138/16
	42.31.79.138/16
	41.31.79.138/16
	40.31.79.138/16
	94.169.59.23/16
	93.169.59.23/16
	92.169.59.23/16
	92.169.59.23/16
	91.169.59.23/16
	90.169.59.23/16
	89.169.59.23/16
	88.169.59.23/16
	87.169.59.23/16
	86.169.59.23/16
	85.169.59.23/16
	84.169.59.23/16
	83.169.59.23/16
	82.169.59.23/16
	81.169.59.23/16
	80.169.59.23/16
	98.149.119.31/16
	97.149.119.31/16
	96.149.119.31/16
	95.149.119.31/16
	108.44.145.45/24
	194.169.211.71/16
	99.235.120.69/16
	142.147.59.156/16
	84.105.168.109/16
	81.220.50.23/16
	76.174.196.6/16
	97.127.231.224/16
	73.73.74.74/16
	70.93.151.114/16
	31.60.132.58/16
	101.32.89.214/16
	177.228.75.20/16
	70.126.63.108/16
	173.17.116.204/16
	45.158.77.29/16
	73.51.221.61/16
	31.60.132.58/16
	101.32.89.214/16
	69.18.23.140/16
	51.89.104.34/16
	164.132.207.52/16
	141.98.213.253/16
	47.37.76.114/16
	72.239.116.151/16
	51.89.104.34/16
	68.118.121.56/16
	67.172.58.227/16
	24.37.0.98/16
	24.150.0.137/16
	24.150.0.137/16
	207.244.251.241/16
	207.244.251.241/16
	207.244.251.241
	172.67.141.38/16
	17.57.146.69/16
	94.158.148.33/16
	195.230.115.24/16
	195.230.115.24/16
	195.230.115.17
	45.45.45.45/16
	111.200.195.67/16
	39.104.19.202/16
	24.209.125.130/16
	77.244.1.163/16
	65.28.166.210/16
	63.139.174.148/16
	172.116.177.131/16
	107.126.50.162/16
	146.88.240.4/16
	103.153.248.173/16
	100.40.7.128/16
	141.212.123.185/16
	149.202.139.250/16
	game-fr-42.mtxserv.com
	89.248.172.16/16
	house.census.shodan.io
	141.212.123.187/16
	researchscan697.eecs.umich.edu
	82.76.29.242/16
	82-76-29-242.rdsnet.ro
	2.57.122.149/16
	128.14.136.78/16
	survey.internet-census.org
	74.82.47.30/16
	scan-09g.shadowserver.org
	193.118.55.170/16
	zl-ams-nl-gp6-wk112.internet-census.org
	47.89.232.170/16
	192.35.168.83/16
	128.14.36.146/16
	82.78.159.134/16
	209.141.36.236/16
	23.129.64.247/16
	23.129.0.0/16/16
	23.129.64.0/24/16
	23.129.64.251/16
	5.254.20.9/16
	37.221.211.24/16
	179.43.175.37/16
	81.196.233.206/16
	46.4.52.92/16
	162.142.125.0/24
	162.142.0.0/16
	192.214.220.151/16
	45.92.9.58/16
	185.136.225.42/16
	5.253.84.247/16
	14.1.112.177/16
	47.253.49.91/16
	162.142.125.40/16
	37.44.238.35/16
	77.247.108.43/16
	185.81.157.17/16
	89.40.70.51/16
	170.130.187.58/16
	74.82.47.22/16
	207.244.225.18/16
	71.6.232.7/16
	37.49.229.193/16
	81.71.6.180/16
	185.94.111.1/16
	192.35.0.0/16
	192.35.168.0/24
	192.35.168.17/16
	198.199.102.178/16
	96.9.249.234/16
	74.120.14.23/16
	74.120.14.38/16
	74.120.14.0/24
	74.120.0.0/16
	185.191.34.233/16
	205.185.114.54/16
	27.115.124.99/16
	74.82.0.0/16
	74.82.47.0/24
	74.82.47.2/16
	50.112.24.13/16
 	104.140.188.10/16
	74.82.47.6/16
)
declare -a PIHOLE_BAN_IPs=(
	${MY_PIHOLE_BAN_IPs[@]}
)
PIHOLE_BAN_IPs=( $( filter_ip_address_array "${PIHOLE_BAN_IPs[@]}" ) )

#sudo fail2ban-client set ctp-dns-1-block banip ${MY_PIHOLE_BAN_IPs[@]}
#sudo fail2ban-client set ctp-dns-1-block banip ${PIHOLE_BAN_IPs[@]}
#sudo fail2ban-client set ctp-dns-1-block banip  $( curl -s https://raw.githubusercontent.com/cbuijs/accomplist/master/chris/fail2ban | xargs )
# sudo fail2ban-client set ctp-dns-1-block banip  $( curl -s | xargs )

create_ip-set pihole subnet-block

for ip in ${PIHOLE_BAN_IPs[@]}
do
	ipset add $IPSET_BK_NAME $ip
done
save_ip-set $IPSET_BK_NAME $IPSET_FILE_FULL


create_ip-set fail2ban subnet-block
url=https://raw.githubusercontent.com/cbuijs/accomplist/master/chris/fail2ban
run_ip-set-block "$url"


save_ip-tables

mapfile -t UNI_IGNORE_IP < $UNI_FILE
mapfile -t DNS_IGNORE_IPs < $DEFUALT_FILE

declare -a JAILs
JAILs=(
        `timeout $TIMEOUT sudo fail2ban-client status | grep "Jail list:" | awk -F, 'NR==n && $1=$1' n=1 | cut -d ':' -f 2-`
)

declare -a pihole_services
pihole_services=(
        "pihole-dns-1-block"
        "pihole-dns"
)

declare -a dns_jails=(
        $( [[ "$IS_MASTER" == true ]] && echo "${pihole_services[@]}" )
	"ctp-dns-1-block"
	"nginx-limit-req"
)

for jail in "${JAILs[@]}"
do
        echo "Enabling, restarting and umasking service $jail"
        sudo fail2ban-client add $jail
        sudo fail2ban-client start $jail
	sudo fail2ban-client set $jail addignoreip ${UNI_IGNORE_IP[@]}
	sudo fail2ban-client set $jail unbanip ${UNI_IGNORE_IP[@]}
done

for jail in "${dns_jails[@]}"
do
	sudo fail2ban-client set $jail addignoreip ${DNS_IGNORE_IPs[@]}
	sudo fail2ban-client set $jail unbanip ${DNS_IGNORE_IPs[@]}
done


sudo bash $PROG/set_unban_ip.sh
