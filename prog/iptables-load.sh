#!/bin/bash
source /etc/environment
sudo bash $PROG/create_ban_ignore_ip_list.sh
sudo bash $PROG/cpu_group_all_.sh
sudo netfilter-persistent start

#sudo cgexec -g cpu:fourthcpulimied -g memory:512MBRam /bin/bash $PROG/block-china.sh
#sleep 10s
sudo cgexec -g cpu:fourthcpulimied -g memory:512MBRam /bin/bash $PROG/ban_abuse.sh >/dev/null
sleep 10s
sudo cgexec -g cpu:fourthcpulimied -g memory:512MBRam /bin/bash $PROG/ban_abuse_list.sh > /dev/null
sleep 10s
sudo cgexec -g cpu:fourthcpulimied -g memory:512MBRam /bin/bash $PROG/ban_countries.sh > /dev/null
#sudo cgexec -g cpu:fourthcpulimied -g memory:512MBRam /bin/bash $PROG/ban_abuse{,countries,_list}.sh
sleep 10s
# This should always come after because it will unblock
sudo cgexec -g cpu:fourthcpulimied -g memory:512MBRam /bin/bash $PROG/set_fail2ban-defaults.sh > /dev/null

sudo netfilter-persistent start
sudo netfilter-persistent save
