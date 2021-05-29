#!/bin/bash
#https://scoutapm.com/blog/restricting-process-cpu-usage-using-nice-cpulimit-and-cgroups
sudo cgcreate -g cpu:/cpulimited

sudo cgset -r cpu.shares=128 cpulimited

sudo cgset -r cpu.shares=128 cpulimited
sudo cgexec -g cpu:cpulimited bash $PROG/start-youtube-trail.sh

#sudo cgexec -g cpu:cpulimited /usr/local/bin/matho-primes 0 9999999999 > /dev/null &
#sudo cgexec -g cpu:lesscpulimited /usr/local/bin/matho-primes 0 9999999999 > /dev/null &
