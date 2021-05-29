#!/bin/bash
sudo cgcreate -g cpu:/cpulimited
sudo cgset -r cpu.shares=128 cpulimited
#sudo cgexec -g cpu:lesscpulimited fail2ban-server
#
#sudo cgexec -g cpu:cpulimited fail2ban-server
