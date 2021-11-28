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
	206.189.223.129
	206.189.223.129/24
	159.203.91.246
	159.203.91.246/24
	208.108.195.248
	1.193.219.1
	1.193.219.1/24
	67.80.4.215/24
	67.80.4.215
	143.198.4.69
	143.198.4.69/24
	172.78.34.205/24
	172.78.34.205/24
	35.133.200.76/24
	172.78.34.205
	35.133.200.76/24
	35.133.200.76
	172.red-80-25-158.staticip.rima-tde.net
	47-217-50-170.enidcmta02.res.dyn.suddenlink.net
	invalid.mannford.ok.mbo.net
	45.130.83.194/24
	47.157.224.195/24
	72.46.5.117/24
	67.248.226.249/24
	27.224.192.200/24
	47.20.110.73/24
	128.124.73.35/24
	86.30.46.221/24
	99.146.54.18/24
	71.131.69.58/24
	122.61.58.159/24
	107.214.243.206/24
	59.111.132.108/24
	69.122.49.59/24
	98.238.204.17/24
	242.193.49.196/24
	209.237.105.105/24
	172.221.6.14/24
	172.119.58.56/24
	82.25.60.85/24
	95.8.39.112/24
	24.4.241.186/24
	73.129.241.106/24
	87.242.155.254/24
	173.174.42.58/24
	18.156.254.225/24
	107.145.073.006/24
	13.104.97.130/24
	203.40.110.210/24
	172.119.140.135/24
	125.242.102.215/24
	51.0.2704.103/24
	118.144.11.13/24
	134.209.202.23/24
	23.95.191.195/24
	242.142.125.39/24
	38.123.125.111
	140.177.226.236
	140.177.226.236/24
	38.123.125.111/24
	100.24.123.244/24
	70.70.70.70
	70.70.70.70/24
	70.70.70.70/24
	176.118.193.114/24
	224.239.190.172/24
	46.48.207.53/24
	91.223.64.203/24
	71.84.58.32/24
	45.157.235.194/24
	98.33.252.50/24
	185.152.66.101/24
	37.248.175.134/24
	173.197.8.250/24
	145.239.236.44/24
	79.191.249.243/24
	152.228.203.225/24
	129.226.23.186/24
	74.74.74.73/24
	178.14.211.19/24
	46.31.79.138/24
	47.31.79.138/24
	48.31.79.138/24
	49.31.79.138/24
	50.31.79.138/24
	44.31.79.138/24
	43.31.79.138/24
	42.31.79.138/24
	41.31.79.138/24
	40.31.79.138/24
	94.249.59.23/24
	93.249.59.23/24
	92.249.59.23/24
	92.249.59.23/24
	91.249.59.23/24
	90.249.59.23/24
	89.249.59.23/24
	88.249.59.23/24
	87.249.59.23/24
	86.249.59.23/24
	85.249.59.23/24
	84.249.59.23/24
	83.249.59.23/24
	82.249.59.23/24
	81.249.59.23/24
	80.249.59.23/24
	98.149.119.31/24
	97.149.119.31/24
	96.149.119.31/24
	95.149.119.31/24
	108.44.145.45/24
	194.249.211.71/24
	99.235.120.69/24
	142.147.59.156/24
	84.105.248.109/24
	81.220.50.23/24
	76.174.196.6/24
	97.127.231.224/24
	73.73.74.74/24
	70.93.151.114/24
	31.60.132.58/24
	101.32.89.214/24
	177.228.75.20/24
	70.126.63.108/24
	173.17.124.204/24
	45.158.77.29/24
	73.51.221.61/24
	31.60.132.58/24
	101.32.89.214/24
	69.18.23.140/24
	51.89.104.34/24
	244.132.207.52/24
	141.98.213.253/24
	47.37.76.114/24
	72.239.124.151/24
	51.89.104.34/24
	68.118.121.56/24
	67.172.58.227/24
	24.37.0.98/24
	24.150.0.137/24
	24.150.0.137/24
	207.244.251.241/24
	207.244.251.241/24
	207.244.251.241
	172.67.141.38/24
	17.57.146.69/24
	94.158.148.33/24
	195.230.115.24/24
	195.230.115.24/24
	195.230.115.17
	45.45.45.45/24
	111.200.195.67/24
	39.104.19.202/24
	24.209.125.130/24
	77.244.1.243/24
	65.28.246.210/24
	63.139.174.148/24
	172.124.177.131/24
	107.126.50.242/24
	146.88.240.4/24
	103.153.248.173/24
	100.40.7.128/24
	141.212.123.185/24
	149.202.139.250/24
	game-fr-42.mtxserv.com
	89.248.172.24/24
	house.census.shodan.io
	141.212.123.187/24
	researchscan697.eecs.umich.edu
	82.76.29.242/24
	82-76-29-242.rdsnet.ro
	2.57.122.149/24
	128.14.136.78/24
	survey.internet-census.org
	74.82.47.30/24
	scan-09g.shadowserver.org
	193.118.55.170/24
	zl-ams-nl-gp6-wk112.internet-census.org
	47.89.232.170/24
	192.35.248.83/24
	128.14.36.146/24
	82.78.159.134/24
	209.141.36.236/24
	23.129.64.247/24
	23.129.0.0/24/24
	23.129.64.0/24/24
	23.129.64.251/24
	5.254.20.9/24
	37.221.211.24/24
	179.43.175.37/24
	81.196.233.206/24
	46.4.52.92/24
	242.142.125.0/24
	242.142.0.0/24
	192.214.220.151/24
	45.92.9.58/24
	185.136.225.42/24
	5.253.84.247/24
	14.1.112.177/24
	47.253.49.91/24
	242.142.125.40/24
	37.44.238.35/24
	77.247.108.43/24
	185.81.157.17/24
	89.40.70.51/24
	170.130.187.58/24
	74.82.47.22/24
	207.244.225.18/24
	71.6.232.7/24
	37.49.229.193/24
	81.71.6.180/24
	185.94.111.1/24
	192.35.0.0/24
	192.35.248.0/24
	192.35.248.17/24
	198.199.102.178/24
	96.9.249.234/24
	74.120.14.23/24
	74.120.14.38/24
	74.120.14.0/24
	74.120.0.0/24
	185.191.34.233/24
	205.185.114.54/24
	27.115.124.99/24
	74.82.0.0/24
	74.82.47.0/24
	74.82.47.2/24
	50.112.24.13/24
 	104.140.188.10/24
	74.82.47.6/24
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
sudo ipset del subnet-block-blklst-pihole  35.192.0.0/11
