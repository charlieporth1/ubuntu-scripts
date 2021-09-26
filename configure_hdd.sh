#!/bin/bash
sudo hdparm -B255 /dev/sda
hdparm -a256 /dev/sda
sudo tune2fs -o journal_data_writeback /dev/sda1
systemctl start cachefilesd
systemctl disable ondemand
sudo mount -t ext4 /dev/sdc /mnt/swap/
#sudo swapon /mnt/swap/swapfile
#sudo /home/*/smartagent/smagent.sh start
export hddnum=($(sudo ls /dev/sd*)) 

for ((a=0; a <= ${#hddnum[@]}; a++))
do
        sudo hdparm -B255 /dev/${hddnum[$a]}
        hdparm -a256 /dev/${hddnum[$a]}
        hdparm -a512 /dev/${hddnum[$a]}
        hdparm -M 254 /dev/${hddnum[$a]}

        sudo /etc/init.d/xinetd restart

        hdparm -W /dev/${hddnum[$a]}
        sudo tune2fs -o journal_data_writeback /dev/${hddnum[$a]}
        echo cfq > /sys/block/${hddnum[$a]}/queue/scheduler
        echo 100240 > /sys/block/${hddnum[$a]}/queue/iosched/fifo_expire_async
        echo 512 > /sys/block/${hddnum[$a]}/queue/iosched/fifo_expire_sync
        echo 80 > /sys/block/${hddnum[$a]}/queue/iosched/slice_async
        echo 1 > /sys/block/${hddnum[$a]}/queue/iosched/low_latency
        echo 6 > /sys/block/${hddnum[$a]}/queue/iosched/quantum
        echo 5 > /sys/block/${hddnum[$a]}/queue/iosched/slice_async_rq
        echo 3 > /sys/block/${hddnum[$a]}/queue/iosched/slice_idle
        echo 1024 > /sys/block/${hddnum[$a]}/queue/iosched/slice_sync
        hdparm -q -M 254 /dev/${hddnum[$a]}
        hdparm -m16 --yes-i-know-what-i-am-doing /dev/${hddnum[$a]}
        hdparm -c1 /dev/${hddnum[$a]}
        hdparm -c1 /dev/${hddnum[$a]}
	echo "cfq" > /sys/block/${hddnum[$a]}/queue/scheduler

done
