#!/bin/bash
source $PROG/ban_ip_conf.sh
CONCURRENT

sudo lastb -a | grepip -o | grep -v "${INGORE_IP_ADRESSES}" | find-ip-block > /tmp/ban_abuse_ips_ssh.list

jail=sshd
cat /tmp/ban_abuse_ips_ssh.list | xargs sudo fail2ban-client set $jail banip

create_ip-set ssh-log abuse
run_ip-set-block-file /tmp/ban_abuse_ips_ssh.list
