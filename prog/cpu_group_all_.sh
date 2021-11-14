#!/bin/bash
CPU_CORE_COUNT=`cat /proc/stat | grep cpu | grep -E 'cpu[0-9]+' | wc -l`
CPU_CORE_COUNT_HALF=$(( $CPU_CORE_COUNT / 2 ))

sudo cgcreate -g cpu:/eightth_cpulimited
sudo cgset -r cpu.shares=64 eightth_cpulimited

sudo cgcreate -g cpu:/cpulimited
sudo cgset -r cpu.shares=128 cpulimited

sudo cgcreate -g cpu:/fourthcpulimied
sudo cgset -r cpu.shares=256 fourthcpulimied

sudo cgcreate -g cpu:/14thcpulimied
sudo cgset -r cpu.shares=256 14thcpulimied

sudo cgcreate -g cpu:/38thspulimied
sudo cgset -r cpu.shares=384 38thspulimied

sudo cgcreate -g cpu:/cpulimitedhalf
sudo cgset -r cpu.shares=512 cpulimitedhalf

sudo cgcreate -g cpu:/cpulimited34ths
sudo cgset -r cpu.shares=750 cpulimited34ths

sudo cgcreate -g memory:/2GBRam
sudo cgcreate -g memory:/1GBRam
sudo cgcreate -g memory:/750MBRam
sudo cgcreate -g memory:/512MBRam
sudo cgcreate -g memory:/384MBRam
sudo cgcreate -g memory:/256MBRam
sudo cgcreate -g memory:/128MBRam
sudo cgcreate -g memory:/64MBRam

bytes=$(( 1024 * 1024 ))

echo $(( 2048 * $bytes )) | sudo tee /sys/fs/cgroup/memory/2GBRam/memory.limit_in_bytes #2 GB RAM
echo $(( 2049 * $bytes )) | sudo tee /sys/fs/cgroup/memory/2GBRam/memory.memsw.limit_in_bytes #2GB swap, only works if you have swap

echo $(( 1024 * $bytes )) | sudo tee /sys/fs/cgroup/memory/1GBRam/memory.limit_in_bytes #2 GB RAM
echo $(( 1024 * $bytes )) | sudo tee /sys/fs/cgroup/memory/1GBRam/memory.memsw.limit_in_bytes #2GB swap, only works if you have swap

echo $(( 750 * $bytes )) | sudo tee /sys/fs/cgroup/memory/512MBRam/memory.limit_in_bytes #2 GB RAM
echo $(( 750 * $bytes )) | sudo tee /sys/fs/cgroup/memory/512MBRam/memory.memsw.limit_in_bytes #2GB swap, only works if you have swap

echo $(( 512 * $bytes )) | sudo tee /sys/fs/cgroup/memory/512MBRam/memory.limit_in_bytes #2 GB RAM
echo $(( 512 * $bytes )) | sudo tee /sys/fs/cgroup/memory/512MBRam/memory.memsw.limit_in_bytes #2GB swap, only works if you have swap

echo $(( 256 * $bytes )) | sudo tee /sys/fs/cgroup/memory/256MBRam/memory.limit_in_bytes #2 GB RAM
echo $(( 256 * $bytes )) | sudo tee /sys/fs/cgroup/memory/256MBRam/memory.memsw.limit_in_bytes #2GB swap, only works if you have swap

echo $(( 384 * $bytes )) | sudo tee /sys/fs/cgroup/memory/384MBRam/memory.limit_in_bytes #2 GB RAM
echo $(( 384 * $bytes )) | sudo tee /sys/fs/cgroup/memory/384MBRam/memory.memsw.limit_in_bytes #2GB swap, only works if you have swap

echo $(( 128 * $bytes )) | sudo tee /sys/fs/cgroup/memory/128MBRam/memory.limit_in_bytes #2 GB RAM
echo $(( 128 * $bytes )) | sudo tee /sys/fs/cgroup/memory/128MBRam/memory.memsw.limit_in_bytes #2GB swap, only works if you have swap

echo $(( 64 * $bytes )) | sudo tee /sys/fs/cgroup/memory/64MBRam/memory.limit_in_bytes #2 GB RAM
echo $(( 64 * $bytes )) | sudo tee /sys/fs/cgroup/memory/64MBRam/memory.memsw.limit_in_bytes #2GB swap, only works if you have swap



