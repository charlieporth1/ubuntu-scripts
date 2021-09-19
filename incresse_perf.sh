#!/bin/bash
bash $PROG/modprobes.sh

if [[ ! -d /mnt/cache ]];then
        mkdir /mnt/cache
fi

if [[ ! -d /mnt/archive-disk-1 ]]; then
	 mkdir /mnt/archive-disk-1
fi

if [[ "$HOSTNAME" == 'ctp-vpn' ]]; then
	blockdev --setra 32384 /dev/sda
	blockdev --setra 32384 /dev/disk/by-id/google-ctp-vpn-cache-and-tmp-and-ramdisk
	blockdev --setra 32384 /dev/disk/by-id/google-archive-disk-1
	hdparm -B 254 /dev/sda
	hdparm -B 254 /dev/disk/by-id/google-ctp-vpn-cache-and-tmp-and-ramdisk
	hdparm -B 254 /dev/disk/by-id/google-archive-disk-1
	mount -t ext4 /dev/disk/by-id/google-archive-disk-1 /mnt/archive-disk-1
	mount -t ext4 /dev/disk/by-id/google-persistent-disk-1 /mnt/archive-disk-1
	mount -t ext4 /dev/disk/by-id/google-ctp-vpn-cache-and-tmp-and-ramdisk /mnt/cache
fi
fstrim -av &

#PERFEROFMACE
echo madvise | sudo tee /sys/kernel/mm/transparent_hugepage/enabled
echo 2 > /sys/module/tcp_cubic/parameters/hystart_detect
echo 1 > /proc/sys/net/ipv4/ip_forward
echo 10000 > /proc/sys/net/ipv4/tcp_comp_sack_delay_ns
echo 25 > /proc/sys/kernel/watchdog_thresh
#echo 1 > /proc/sys/kernel/sysrq
#echo x > /proc/sysrq-trigger


sysctl -w net.ipv6.conf.all.disable_ipv6=0
sysctl -w net.ipv6.conf.lo.disable_ipv6=0
if [[ `ifconfig ens4 | grep -o ens4` ]]; then
	sysctl -w net.ipv6.conf.ens4.disable_ipv6=0
	sysctl -w net.ipv4.conf.wg0.send_redirects=0
	sysctl -w net.ipv4.conf.wg0.rp_filter=0
fi
if [[ `ifconfig ens5 | grep -o ens5` ]]; then
	sysctl -w net.ipv6.conf.ens5.disable_ipv6=0
	sysctl -w net.ipv4.conf.wg0.send_redirects=0
	sysctl -w net.ipv4.conf.wg0.rp_filter=0
fi
if [[ `ifconfig wg0 | grep -o wg0` ]]; then
	sysctl -w net.ipv6.conf.wg0.disable_ipv6=0
	sysctl -w net.ipv4.conf.wg0.send_redirects=0
	sysctl -w net.ipv4.conf.wg0.rp_filter=0
fi

sysctl -w net.ipv6.conf.all.forwarding=1
sysctl -w net.ipv4.ip_forward=1

sysctl -w net.ipv4.tcp_congestion_control=htcp
sysctl -w net.ipv4.tcp_congestion_control=bbr
sysctl -w net.ipv4.tcp_notsent_lowat=16384
sysctl -w net.ipv4.tcp_fastopen=3
sysctl -w net.ipv4.tcp_window_scaling=1
sysctl -w net.ipv4.tcp_max_orphans=16384
sysctl -w net.ipv4.tcp_orphan_retries=4
sysctl -w net.ipv4.tcp_tw_recycle=0
sysctl -w net.ipv4.tcp_tw_reuse=1
sysctl -w net.core.default_qdisc=fq

sysctl -w net.ipv4.ip_nonlocal_bind=1
sysctl -w net.ipv4.tcp_rfc1337=1
sysctl -w net.ipv4.tcp_fin_timeout=15
sysctl -w net.ipv4.tcp_keepalive_time = 300
sysctl -w net.ipv4.tcp_keepalive_probes = 5
sysctl -w net.ipv4.tcp_keepalive_intvl = 15
sysctl -w net.ipv4.tcp_low_latency=1
sysctl -w net.ipv4.tcp_sack=1
sysctl -w net.ipv4.tcp_timestamps=0
sysctl -w net.ipv4.tcp_mtu_probing=1
sysctl -w net.ipv4.tcp_reordering=3
#sysctl -w

swapon /swapfile
if [[ -f /swapfile1 ]]; then
         swapon /swapfile1
fi

if [[ -f /mnt/HDD/swapfile ]]; then
         swapon /mnt/HDD/swapfile
fi

if [[ -f /mnt/cache/swapfile ]]; then
         swapon /mnt/sdb/swapfile
fi

if [[ -f /mnt/archive-disk-1/swapfile ]]; then
         swapon /mnt/archive-disk-1/swapfile
fi

(
for letter in {a..f}
do
        for number in {0..9}
        do
                drive=sd$letter$number
		drive_path=/dev/$drive
                #fsck.ext4 -y $drive_path
                if [[ -f $drive ]]; then
			blockdev --setra 32384 $drive_path
			hdparm -B 254 $drive_path
			# https://access.redhat.com/solutions/5427
			# https://www.cloudbees.com/blog/linux-io-scheduler-tuning
			echo "noop" > /sys/block/$drive/queue/scheduler
			sleep 2s
			echo "cfq" > /sys/block/$drive/queue/scheduler
			sleep 2s
			echo "deadline" > /sys/block/$drive/queue/scheduler
			sleep 2s
			echo "mq-deadline" > /sys/block/$drive/queue/scheduler
                fi
        done
done
)&
