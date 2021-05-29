#!/bin/bash

cpunum=$(cat /proc/cpuinfo | awk '/^processor/{print $3}' | wc -l)

#sudo tune2fs -o journal_data_writeback /dev/sdb1
echo -1 > /sys/module/usbcore/parameters/autosuspend
cpuMax=$(cat /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_max_freq | sed -n '1p') 

for ((i=0; i <=$cpunum; i++)) do

	echo 1 > /sys/devices/system/cpu/cpu$i/online echo performance > /sys/devices/system/cpu/cpu$i/cpufreq/scaling_governor
	echo "$cpuMax" > /sys/devices/system/cpu/cpu$i/cpufreq/scaling_setspeed 
	echo "$cpuMax" > /sys/devices/system/cpu/cpu$i/cpufreq/scaling_max_freq 
	echo "$cpuMax" > /sys/devices/system/cpu/cpu$i/cpufreq/scaling_min_freq 
done
