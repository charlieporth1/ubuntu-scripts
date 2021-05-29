#!/bin/bash
source $PROG/all-scripts-exports.sh
CONCURRENT
# regex test

# fail2ban-regex /var/log/pihole.log /etc/fail2ban/filter.d/pihole-dns-1-block.conf
# fail2ban-regex /var/log/pihole.log /etc/fail2ban/filter.d/pihole-dns.conf
# fail2ban-regex -D --verbosity=4 /var/log/ctp-dns/default.log  /etc/fail2ban/filter.d/ctp-dns-1-block.conf
# fail2ban-regex -D --verbosity=4 /var/log/ctp-dns/fail2ban-test.log  /etc/fail2ban/filter.d/ctp-dns-1-block.conf
# fail2ban-regex -D --verbosity=4 /var/log/ctp-dns/error.log  /etc/fail2ban/filter.d/ctp-dns-1-block.conf
#$PROG/lookup_ip_address_business.sh --ip=
IP_REGEX="([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})"
curl -o /tmp/phising_ip_addres.csv  https://openphish.com/samples/ip_feed.csv

if ! command -v pihole &> /dev/null
then
	export IS_PIHOLE=true
fi

function filter_ip_address_array() {
	INPUT_ARRAY=( "$@" )
 	# Sort IPs
	printf "%s\n" "${INPUT_ARRAY[@]}" | sort -t . -k 3,3n -k 4,4n | uniq
}
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

declare -a PIHOLE_BAN_IPs
PIHOLE_BAN_IPs=(
	38.123.125.111
	140.177.226.236
	140.177.226.236/8
	38.123.125.111/24
	100.16.123.164/8
	70.70.70.70
	70.70.70.70/8
	70.70.70.70/8
	176.118.193.114/8
	216.239.190.172/8
	46.48.207.53/8
	$(curl https://raw.githubusercontent.com/cbuijs/accomplist/master/chris/fail2ban)
	91.223.64.203/8
	71.84.58.32/8
	45.157.235.194/8
	98.33.252.50/8
	185.152.66.101/8
	37.248.175.134/8
	173.197.8.250/8
	145.239.236.44/8
	79.191.249.163/8
	152.228.203.225/8
	129.226.23.186/8
	74.74.74.73/24
	178.14.211.19/8
	46.31.79.138/8
	47.31.79.138/8
	48.31.79.138/8
	49.31.79.138/8
	50.31.79.138/8
	44.31.79.138/8
	43.31.79.138/8
	42.31.79.138/8
	41.31.79.138/8
	40.31.79.138/8
	94.169.59.23/8
	93.169.59.23/8
	92.169.59.23/8
	92.169.59.23/8
	91.169.59.23/8
	90.169.59.23/8
	89.169.59.23/8
	88.169.59.23/8
	87.169.59.23/8
	86.169.59.23/8
	85.169.59.23/8
	84.169.59.23/8
	83.169.59.23/8
	82.169.59.23/8
	81.169.59.23/8
	80.169.59.23/8
	98.149.119.31/8
	97.149.119.31/8
	96.149.119.31/8
	95.149.119.31/8
	108.44.145.45/8
	194.169.211.71/8
	99.235.120.69/8
	142.147.59.156/8
	84.105.168.109/8
	81.220.50.23/8
	76.174.196.6/8
	97.127.231.224/8
	73.73.74.74/8
	70.93.151.114/8
	31.60.132.58/8
	101.32.89.214/8
	177.228.75.20/8
	70.126.63.108/8
	173.17.116.204/16
	45.158.77.29/8
	73.51.221.61/8
	31.60.132.58/8
	101.32.89.214/8
	69.18.23.140/8
	51.89.104.34/8
	164.132.207.52/8
	141.98.213.253/8
	47.37.76.114/8
	72.239.116.151/8
	51.89.104.34/8
	68.118.121.56/8
	67.172.58.227/8
	24.37.0.98/16
	24.150.0.137/16
	24.150.0.137/8
	207.244.251.241/16
	207.244.251.241/8
	207.244.251.241
	172.67.141.38/16
	17.57.146.69/16
	94.158.148.33/16
	195.230.115.24/16
	195.230.115.24/8
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
PIHOLE_BAN_IPs=( $( filter_ip_address_array "${PIHOLE_BAN_IPs[@]}" ) )

if [[ $IS_PIHOLE == 'true' ]]; then
	sudo fail2ban-client set pihole-dns banip ${PIHOLE_BAN_IPs[@]}
	sudo fail2ban-client set pihole-dns-1-block banip ${PIHOLE_BAN_IPs[@]}
fi

sudo fail2ban-client set ctp-dns-1-block banip ${PIHOLE_BAN_IPs[@]}

for ip in ${PIHOLE_BAN_IPs[@]}
do
	iptables -N BAN-IPS
	iptables -A INPUT -s $ip -p tcp -j DROP
	iptables -A INPUT -s $ip -p udp -j DROP
done
#	122.248.234.0/24
#	63.143.0.0/16

declare -a UPTIME_IGNORE_IPs=(
	122.248.234.23/24
	63.143.42.248/24
)
declare -a UNI_IGNORE_IPs
UNI_IGNORE_IP=(
	192.168.44.29/16
	102.168.44.250
	192.168.44.29
	17.130.53.174
	158.105.192.35
	9.123.168.192
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

declare -a TMobileIPs
T_MobileIPs=(
$(curl https://raw.githubusercontent.com/cbuijs/accomplist/master/chris/mobile.tmobile.list)
$(curl https://raw.githubusercontent.com/cbuijs/accomplist/master/chris/mobile.tmobileus.list)
$(curl https://raw.githubusercontent.com/cbuijs/accomplist/master/chris/white.tmobileus.ip.list)
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
	${T_MobileIPs[@]}
	35.192.105.158
	35.232.120.211
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
INGORE_IP_ADRESSES=$(bash $PROG/grepify.sh $(echo "${DNS_IGNORE_IPs[@]}"))

sudo lastb -a | grep -oE "$IP_REGEX" | grep -v "${INGORE_IP_ADRESSES}" | xargs sudo fail2ban-client set sshd banip

if [[ -n "$IS_PIHOLE" ]]; then
	PIHOLE_F2B_REGEX=`grep 'failregex' /etc/fail2ban/filter.d/pihole-dns-1-block.conf | awk -F= '{print $2}' | cut -d '<' -f -1`

	grep -E "$PIHOLE_F2B_REGEX" /var/log/pihole.log | grepip --exclude-reserved --only-matching | grep -v "${INGORE_IP_ADRESSES}" | xargs sudo fail2ban-client set pihole-dns-1-block banip
	grep -E "$PIHOLE_F2B_REGEX" /var/log/pihole.log | grepip --exclude-reserved --only-matching | grep -v "${INGORE_IP_ADRESSES}" | xargs sudo fail2ban-client set sshd banip
fi

declare -a JAIL_PIHOLEs
JAIL_PIHOLEs=(
	pihole-dns-1-block
	pihole-dns
)

declare -a JAILs
JAILs=(
	$( [[ -n "$IS_PIHOLE" ]] && ${JAIL_PIHOLEs[@]} )
	ctp-dns-1-block
	sshd
	nginx-http-auth
)
sudo bash $PROG/get_bad_hosts.sh > /tmp/bad_ips.txt
cat  /tmp/bad_ips.txt | grep -v "${INGORE_IP_ADRESSES}" | xargs sudo fail2ban-client set pihole-dns-1-block banip
for jail in "${JAILs[@]}"
do
	sudo fail2ban-client $jail start
	sudo fail2ban-client set $jail banip ${PIHOLE_BAN_IPs[@]}
done

for jail in "${JAILs[@]}"
do
	sudo fail2ban-client $jail start
	sudo fail2ban-client set $jail addignoreip ${DNS_IGNORE_IPs[@]}
	sudo fail2ban-client set $jail unbanip ${DNS_IGNORE_IPs[@]}
done
sudo iptables-save
