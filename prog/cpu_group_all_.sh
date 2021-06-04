#!/bin/bash
sudo cgcreate -g cpu:/cpulimited
sudo cgset -r cpu.shares=128 cpulimited

sudo cgcreate -g cpu:/lesscpulimited
sudo cgset -r cpu.shares=512 lesscpulimited
#sudo cgexec -g cpu:lesscpulimited fail2ban-server
#
#sudo cgexec -g cpu:cpulimited fail2ban-server
