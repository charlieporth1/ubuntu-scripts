#!/bin/bash
source $PROG/all-scripts-exports.sh
source $PROG/ban_ip_conf.sh
CONCURRENT
FILE_NAME='ban_ignore_ip_list'
DEFUALT_FILE=/tmp/$FILE_NAME.txt
IP_SET_LISTS=$(sudo ipset list  | grep -E Name:* | awk '{print $2}')

if ! [[ -f $DEFUALT_FILE ]]; then
        bash $PROG/create_ban_ignore_ip_list.sh
fi

mapfile -t DNS_IGNORE_IPs < $DEFUALT_FILE
mapfile -t INGNORE_IP_SUBNETs < $INGNORE_IP_SUBNET
mapfile -t TMOBILE_IGNORE_IPs < $INGNORE_IP_TMOBILE


declare -a JAIL_PIHOLEs
JAIL_PIHOLEs=(
        pihole-dns-1-block
        pihole-dns
)

declare -a JAILs
JAILs=(
        $( [[ -n "$IS_PIHOLE" ]] && echo ${JAIL_PIHOLEs[@]} )
        ctp-dns-1-block
        sshd
        nginx-http-auth
)


create_ip-set-allow dns-list allow
for ip in "${DNS_IGNORE_IPs[@]}"
do
	ipset add $IPSET_BK_NAME $ip
done

create_ip-set-allow tmobile-list allow
for ip in "${TMOBILE_IGNORE_IPs[@]}"
do
	ipset add $IPSET_BK_NAME $ip
done

create_ip-set-allow subnet-list allow
for ip in "${INGNORE_IP_SUBNETs[@]}"
do
	ipset add $IPSET_BK_NAME $ip
done

for jail in "${JAILs[@]}"
do
        sudo fail2ban-client $jail start

        echo ${DNS_IGNORE_IPs[@]} | xargs sudo fail2ban-client set $jail addignoreip
	echo ${DNS_IGNORE_IPs[@]} | xargs sudo fail2ban-client set $jail unbanip

        echo ${TMOBILE_IGNORE_IPs[@]} | xargs sudo fail2ban-client set $jail addignoreip
	echo ${TMOBILE_IGNORE_IPs[@]} | xargs sudo fail2ban-client set $jail unbanip

        echo ${INGNORE_IP_SUBNETs[@]} | xargs sudo fail2ban-client set $jail addignoreip
	echo ${INGNORE_IP_SUBNETs[@]} | xargs sudo fail2ban-client set $jail unbanip


done

for ip_subnet in "${INGNORE_IP_SUBNETs[@]}"
do
	sudo ipset del subnet-block-blklst-pihole $ip_subnet 2>/dev/null
	for ip_set_list in $IP_SET_LISTS
	do
		sudo ipset del $ip_set_list $ip_addr 2>/dev/null
	done
done

for ip_addr in "${TMOBILE_IGNORE_IPs[@]}"
do
	sudo ipset del subnet-block-blklst-pihole $ip_addr 2>/dev/null
	for ip_set_list in $IP_SET_LISTS
	do
		sudo ipset del $ip_set_list $ip_addr 2>/dev/null
	done
done

for ip_addr in "${DNS_IGNORE_IPs[@]}"
do
	sudo ipset del subnet-block-blklst-pihole $ip_addr 2>/dev/null
	for ip_set_list in $IP_SET_LISTS
	do
		sudo ipset del $ip_set_list $ip_addr 2>/dev/null
	done
done

sudo ipset del subnet-block-blklst-pihole 67.172.0.0/16
sudo ipset del subnet-block-blklst-pihole 35.192.0.0/11
sudo ipset del subnet-block-blklst-pihole 35.232.0.0/18
sudo ipset del subnet-block-blklst-pihole 35.232.64.0/19
sudo ipset del subnet-block-blklst-pihole 35.232.120.128/26
sudo ipset del subnet-block-blklst-pihole 35.232.120.0/25
sudo ipset del subnet-block-blklst-pihole 35.232.96.0/20
sudo ipset del subnet-block-blklst-pihole 35.232.120.0/25
sudo ipset del subnet-block-blklst-pihole 35.232.112.0/21
sudo ipset del subnet-block-blklst-pihole 35.232.120.192/28
sudo ipset del subnet-block-blklst-pihole 35.232.120.211
sudo ipset del subnet-block-blklst-pihole 35.192.105.158

sudo ipset del subnet-block-blklst-pihole $(dig -t a +short gcp.ctptech.dev | xargs )
sudo ipset del subnet-block-blklst-pihole $(dig -t aaaa +short gcp.ctptech.dev | xargs )

sudo ipset del subnet-block-blklst-pihole $(dig -t a +short aws.ctptech.dev | xargs )
sudo ipset del subnet-block-blklst-pihole $(dig -t aaaa +short aws.ctptech.dev | xargs )

sudo ipset del subnet-block-blklst-pihole $(dig -t a +short home.ctptech.dev | xargs)
sudo ipset del subnet-block-blklst-pihole $(dig -t aaaa +short home.ctptech.dev | xargs)

sudo ipset del subnet-block-blklst-pihole $(dig -t a +short aws.ctptech.dev | xargs )
sudo ipset del subnet-block-blklst-pihole $(dig -t aaaa +short aws.ctptech.dev | xargs )

sudo ipset del subnet-block-blklst-pihole $(dig -t a +short dns.ctptech.dev | xargs)
sudo ipset del subnet-block-blklst-pihole $(dig -t aaaa +short dns.ctptech.dev | xargs)

sudo ipset del subnet-block-blklst-pihole $(dig -t a +short dns.i.ctptech.dev | xargs )
sudo ipset del subnet-block-blklst-pihole $(dig -t aaaa +short dns.i.ctptech.dev | xargs )


save_ip-tables
