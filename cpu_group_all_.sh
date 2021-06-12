#!/bin/bash
sudo cgcreate -g cpu:/cpulimited
sudo cgset -r cpu.shares=128 cpulimited

sudo cgcreate -g cpu:/lesscpulimited
sudo cgset -r cpu.shares=512 lesscpulimited

sudo cgcreate -g memory:/2gbram
echo $(( 2048 * 1024 * 1024 )) | sudo tee /sys/fs/cgroup/memory/cgTeams/memory.limit_in_bytes #2 GB RAM
echo $(( 2049 * 1024 * 1024 )) | sudo tee /sys/fs/cgroup/memory/cgTeams/memory.memsw.limit_in_bytes #2GB swap, only works if you have swap

sudo cgexec -g memory:2gbram teams 

#sudo cgexec -g cpu:lesscpulimited fail2ban-server
#
#sudo cgexec -g cpu:cpulimited fail2ban-server
