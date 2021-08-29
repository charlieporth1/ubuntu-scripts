#!/bin/bash
source /etc/environment
sudo bash $PROG/create_ban_ignore_ip_list.sh
sudo bash $PROG/cpu_group_all_.sh

sudo cgexec -g cpu:fourthcpulimied -g memory:512MBRam /bin/bash $PROG/block-china.sh
sleep 10s
sudo cgexec -g cpu:fourthcpulimied -g memory:512MBRam /bin/bash $PROG/ban_abuse.sh
sleep 10s
sudo cgexec -g cpu:fourthcpulimied -g memory:512MBRam /bin/bash $PROG/ban_abuse_list.sh
sleep 10s
sudo cgexec -g cpu:fourthcpulimied -g memory:512MBRam /bin/bash $PROG/ban_countries.sh
#sudo cgexec -g cpu:fourthcpulimied -g memory:512MBRam /bin/bash $PROG/ban_abuse{,countries,_list}.sh
sleep 10s
# This should always come after because it will unblock
sudo cgexec -g cpu:fourthcpulimied -g memory:512MBRam /bin/bash $PROG/set_fail2ban-defaults.sh
