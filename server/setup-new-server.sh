#!/bin/bash
#ssh banner
if [ ! -z "$(cat /etc/ssh/sshd_config | grep -o '#Banner /etc/issue.net')" ]; then
sudo sed -i.bak -e  's#\#Banner /etc/issue.net##g' /etc/ssh/sshd_config
echo "Banner /etc/issue.net" >> /etc/ssh/sshd_config
echo "Match Host tegra-ubuntu,192.168.1.250,192.168.1.251" >> /etc/ssh/sshd_config
echo "		Banner none" >> /etc/ssh/sshd_config
echo "Match all" >> /etc/ssh/sshd_config 
fi
if [ ! -z "$(cat /etc/ssh/sshd_config | grep -o '#Banner none')" ]; then
sudo sed -i.bak -e  's/#Banner none//g' /etc/ssh/sshd_config
echo "Banner /etc/issue.net" >> /etc/ssh/sshd_config
echo "Match Host tegra-ubuntu,192.168.1.250,192.168.1.251" >> /etc/ssh/sshd_config
echo "		Banner none" >> /etc/ssh/sshd_config
echo "Match all" >> /etc/ssh/sshd_config 
fi

#ssh_config
if [ -z "$(cat /etc/ssh/ssh_config | grep -o 'tegra-ubuntu')" ]; then
echo "Host tegra-ubuntu 				" >> /etc/ssh/ssh_config
echo "       User ubuntu				" >> /etc/ssh/ssh_config
echo "       Hostname 192.168.1.251		" >> /etc/ssh/ssh_config
echo "       Port 22				" >> /etc/ssh/ssh_config
echo "       IdentityFile /home/*/.ssh/id_rsa	" >> /etc/ssh/ssh_config
echo "       Ciphers arcfour " >> /etc/ssh/ssh_config
echo "       Compression no			" >> /etc/ssh/ssh_config
echo "       MACs  hmac-md5-96			" >> /etc/ssh/ssh_config
#        PasswordAuthentication no		
echo "       PreferredAuthentications publickey	" >> /etc/ssh/ssh_config
echo "       ForwardX11 no  			" >> /etc/ssh/ssh_config
echo "       PubKeyAuthentication yes		" >> /etc/ssh/ssh_config
fi
#sshd_config 
if [ -z "$(cat /etc/ssh/sshd_config | grep -o 'MaxStartups -1')" ]; then
echo "MaxStartups -1" >> /etc/ssh/sshd_config
fi
if [ -z "$(cat /etc/ssh/sshd_config | grep -o 'MaxSessions -1')" ]; then
echo "MaxSessions -1" >> /etc/ssh/sshd_config
fi
if [ !  -z "$(cat /etc/ssh/sshd_config | grep -o '\#PermitRootLogin prohibit-password')" ]; then
sudo sed  -i.bak -e 's/#PermitRootLogin prohibit-password/PermitRootLogin prohibit-password/g' /etc/ssh/sshd_config
fi
if [ ! -z "$(cat /etc/ssh/sshd_config | grep -o '\#PermitRootLogin no')" ]; then
sudo sed  -i.bak -e 's/#PermitRootLogin no/PermitRootLogin prohibit-password' /etc/ssh/sshd_config
fi
if [ ! -z "$(cat /etc/ssh/sshd_config | grep -o '\#MaxAuthTries')" ]; then
sudo sed  -i.bak -e 's/#MaxAuthTries/MaxAuthTries' /etc/ssh/sshd_config
fi
if [ ! -z "$(cat /etc/ssh/sshd_config | grep -o '\#PasswordAuthentication yes')" ]; then
sudo sed  -i.bak -e 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
fi
if [ ! -z "$(cat /etc/ssh/sshd_config | grep -o '\#PermitEmptyPasswords no')" ]; then
sudo sed  -i.bak -e 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/g' /etc/ssh/sshd_config
fi
if [ ! -z "$(cat /etc/ssh/sshd_config | grep -o '\#PrintMotd yes')" ]; then
sudo sed  -i.bak -e 's/#PrintMotd yes/PrintMotd yes' /etc/ssh/sshd_config
fi
#/etc/bash.bashrc
if [ -z "$(cat /etc/bash.bashrc | grep -o 'bash /opt/phoneone.sh')" ]; then
echo "bash /opt/phoneone.sh" >> /etc/bash.bashrc
fi

if [ -z "$(cat /etc/network/interfaces | grep -o 'auto lo')" ]; then
echo "\# This file describes the network interfaces available on your system" >> /etc/network/interfaces
echo "\# and how to activate them. For more information, see interfaces(5)." >> /etc/network/interfaces
echo "" 							 >> /etc/network/interfaces
echo "\# The loopback network interface" >> /etc/network/interfaces
echo "auto lo" >> /etc/network/interfaces
echo "iface lo inet loopback" >> /etc/network/interfaces
fi

export dns="dns-nameservers 1.1.1.1 8.8.8.8 8.8.4.4 9.9.9.9"
export ethdev="$(ifconfig | awk '{print $1}' | grep -v 'docker\|inet\|lo\|inet6\|UP\|RX\|TX\|collisions:*\|virbr0')"
if [ -z "$(cat /etc/network/interfaces | grep -o 'auto $ethdev')" ]; then
export masterip="$(ssh tegra-ubuntu cat /etc/ssh/ssh_config | grep -A 1  $HOSTNAME | grep -oE  '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b')"
echo "" >> /etc/network/interfaces
echo "auto $ethdev" >> /etc/network/interfaces
echo "iface $ethdev inet static" >> /etc/network/interfaces
echo "			address $masterip" >> /etc/network/interfaces
echo "			 netmask 255.255.255.0" >> /etc/network/interfaces
echo "			gateway 192.168.1.1" >> /etc/network/interfaces
echo "			$dns" >> /etc/network/interfaces
fi
export host=$HOSTNAME
if [ -z "$(cat /etc/network/interfaces | grep -o '$dns')" ]; then
export oldDns="$(cat /etc/network/interfaces | grep 'dns')"
sudo sed  -i.bak -e 's/$oldDns/$dns' /etc/ssh/sshd_config
#echo "$dns"  >> /etc/network/interfaces
fi
if [ -z "$(cat /etc/sysctl.conf | grep -o 'net.core.rmem_default = 10000000')" ]; then 
###############################################################################
########################## NETWORK SPEED TWEAKS ###############################
###############################################################################

echo "net.core.rmem_default = 10000000" >> /etc/sysctl.conf
echo "net.core.wmem_default = 10000000" >> /etc/sysctl.conf
echo "net.core.rmem_max = 16777216" >> /etc/sysctl.conf
echo "net.core.wmem_max = 16777216" >> /etc/sysctl.conf
# If you have a lot of memory set max 54MB buffer (56623104) for 10GE network.
# net.core.rmem_max = 56623104
# net.core.wmem_max = 56623104
# net.core.rmem_default = 56623104
# net.core.wmem_default = 56623104
echo "net.core.optmem_max = 40960" >> /etc/sysctl.conf
echo "net.ipv4.tcp_rmem = 4096 87380 10000000" >> /etc/sysctl.conf
echo "net.ipv4.tcp_wmem = 4096 65536 10000000" >> /etc/sysctl.conf
# Setting 10GE capable host to consume a maximum of 32M-64M per socket ensures
# parallel streams work well and do not consume a majority of system resources.
# Set max 32MB buffer (33554432) for 10GE network.
# net.core.rmem_max = 33554432
# net.core.wmem_max = 33554432
# net.core.rmem_default = 33554432
# net.core.wmem_default = 33554432
# net.core.optmem_max = 40960
# net.ipv4.tcp_rmem = 4096 87380 33554432
# net.ipv4.tcp_wmem = 4096 65536 33554432
# Increase Linux auto-tuning TCP buffer limits.
# Set max to 16MB buffer (16777216) for 1GE network.
#net.core.rmem_max = 16777216
#net.core.wmem_max = 16777216
#net.core.rmem_default = 16777216
#net.core.wmem_default = 16777216
#net.core.optmem_max = 40960
#net.ipv4.tcp_rmem = 4096 87380 16777216
#net.ipv4.tcp_wmem = 4096 65536 16777216

# Enable TCP Fast Open (RFC7413) to send and accept data in the opening
# SYN-packet. It will not do any troubles with not supported hosts
# but it will do guaranteed speedup handshake for supported ones.
echo "net.ipv4.tcp_fastopen = 1" >> /etc/sysctl.conf

# Set UDP parameters. Adjust them for your network.
echo "net.ipv4.udp_mem = 8388608 12582912 16777216" >> /etc/sysctl.conf
echo "net.ipv4.udp_rmem_min = 65536" >> /etc/sysctl.conf
echo "net.ipv4.udp_wmem_min = 65536" >> /etc/sysctl.conf
# 0 - Rate halving based; a smooth and conservative response, results in halved
# cwnd and ssthresh after one RTT. 1 - Very conservative response; not
# recommended because even though being valid, it interacts poorly with the
# rest of Linux TCP, halves cwnd and ssthresh immediately.
# 2 - Aggressive response; undoes congestion control measures that are now
# known to be unnecessary (ignoring the possibility of a lost retransmission
# that would require TCP to be more cautious), cwnd and ssthresh are restored
# to the values prior timeout. Default is 0.
# Also on some distribution this tunable is deprecated.
echo "net.ipv4.tcp_frto_response = 2" >> /etc/sysctl.conf
# Enable(0)/disable(1) the PreQueue entirely. Allow tcp/ip stack prefer
# low latency instead of high throughput. Try option 1 in slow Wi-Fi networks.
# IBM recommend set it to 0.
echo "net.ipv4.tcp_low_latency = 0" >> /etc/sysctl.conf
# ECN allows end-to-end notification of network congestion without dropping
# packets. It is nice as concept in RFC but in the real life we have a lot of
# crapy network hardware so disable it.
echo "net.ipv4.tcp_ecn = 0" >> /etc/sysctl.conf
 # Enables Forward Acknowledgment which works with Selective Acknowledgment.
# Intel recommends to turn in always on.
echo "net.ipv4.tcp_fack = 1" >> /etc/sysctl.conf
# Increase TCP queue length in order to reduce a performance spike with
# relation to timestamps generation.
echo "net.ipv4.neigh.default.proxy_qlen = 96" >> /etc/sysctl.conf
echo "net.ipv4.neigh.default.unres_qlen = 6" >> /etc/sysctl.conf

# Enable a fix for RFC1337 - time-wait assassination hazards in TCP.
echo "net.ipv4.tcp_rfc1337 = 1" >> /etc/sysctl.conf

# This will ensure that immediately subsequent connections use the new values.
echo "net.ipv4.route.flush = 1" >> /etc/sysctl.conf
echo "net.ipv6.route.flush = 1" >> /etc/sysctl.conf

# Set 1 if you want to disable Path MTU discovery - a technique to determine
# the largest Maximum Transfer Unit possible on your path.
echo "net.ipv4.ip_no_pmtu_disc = 0" >> /etc/sysctl.conf

# Use Selective ACK which can be used to signify that specific packets are
# missing - therefore helping fast recovery.
echo "net.ipv4.tcp_sack = 1" >> /etc/sysctl.conf

# Do not allow the arp table to become bigger than this
echo "net.ipv4.neigh.default.gc_thresh3 = 4096" >> /etc/sysctl.conf

# Tell the gc when to become aggressive with arp table cleaning.
echo "net.ipv4.neigh.default.gc_thresh2 = 2048" >> /etc/sysctl.conf

# Adjust where the gc will leave arp table alone.
echo "net.ipv4.neigh.default.gc_thresh1 = 1024" >> /etc/sysctl.conf

# Adjust to arp table gc to clean-up more often
echo "net.ipv4.neigh.default.gc_interval = 30" >> /etc/sysctl.conf

# Limit orphans because each orphan can eat up to 16M of unswappable memory.
echo "net.ipv4.tcp_max_orphans = 32384" >> /etc/sysctl.conf
echo "net.ipv4.tcp_orphan_retries = 0" >> /etc/sysctl.conf

# Increase the maximum memory used to reassemble IP fragments.
echo "net.ipv4.ipfrag_high_thresh = 589824" >> /etc/sysctl.conf
echo "net.ipv4.ipfrag_low_thresh = 524288" >> /etc/sysctl.conf

# Increase size of RPC datagram queue length.
echo "net.unix.max_dgram_qlen = 512" >> /etc/sysctl.conf

# For servers with tcp-heavy workloads, enable <fq> queue management scheduler.
# Highly recommended for CentOS7/Debian8 hosts.
echo "net.core.default_qdisc = fq" >> /etc/sysctl.conf

# If you are using Jumbo Frames, also set this tunable.
# net.ipv4.tcp_mtu_probing = 1

# Set max number of queued connections on a socket. The default value usually
# is too low. Raise this value substantially to support bursts of request.
echo "net.core.somaxconn = 8192" >> /etc/sysctl.conf

# Try to reuse time-wait connections.
# But don't recycle them (recycle can break clients behind NAT).
echo "net.ipv4.tcp_tw_recycle = 0" >> /etc/sysctl.conf
echo "net.ipv4.tcp_tw_reuse = 1" >> /etc/sysctl.conf

# Avoid falling back to slow start after a connection goes idle.
# Keep it 0 usually.
echo "net.ipv4.tcp_slow_start_after_idle = 0" >> /etc/sysctl.conf

# Enable TCP window scaling for high-throughput blazing fast TCP performance.
echo "net.ipv4.tcp_window_scaling = 1" >> /etc/sysctl.conf

# Decrease the time default value for tcp_fin_timeout connection.
echo "net.ipv4.tcp_fin_timeout = 10" >> /etc/sysctl.conf

# Decrease the time default value for connections to keep alive.
echo "net.ipv4.tcp_keepalive_time = 512" >> /etc/sysctl.conf
echo "net.ipv4.tcp_keepalive_probes = 10" >> /etc/sysctl.conf
echo "net.ipv4.tcp_keepalive_intvl = 32" >> /etc/sysctl.conf

# Turn on the tcp_timestamps. More accurate timestamp make TCP congestion
# control algorithms work better and are recommended for fast networks.
echo "net.ipv4.tcp_timestamps = 1" >> /etc/sysctl.conf

# Increase number of incoming connections backlog. Try up to 262144.
echo "net.core.netdev_max_backlog = 16384" >> /etc/sysctl.conf

# Set max number half open SYN requests to keep in memory.
echo "net.ipv4.tcp_max_syn_backlog = 8192" >> /etc/sysctl.conf

# Do not cache ssthresh from previous connection.
echo "net.ipv4.tcp_no_metrics_save = 1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_moderate_rcvbuf = 1" >> /etc/sysctl.conf

# Explicitly set htcp or cubic as the congestion control. To get a list of
# congestion control algorithms that are available in your kernel run:
# command $sysctl net.ipv4.tcp_available_congestion_control and to find algo
# that can be loaded run $grep TCP_CONG /boot/config-$(uname -r).
# also read this - http://fasterdata.es.net/host-tuning/linux/
echo "net.ipv4.tcp_congestion_control = cubic" >> /etc/sysctl.conf

###############################################################################
######################### MEMORY SUBSYSTEM OPTIONS ############################
###############################################################################

# If we have lots of memory we will avoid of using swap.
# We want swappiness to be as close to zero as possible.
echo "vm.swappiness = 35" >> /etc/sysctl.conf

# Tell Linux that we want it to prefer inode/dentry cache to other caches.
# Higher priority to inode caching helps to avoid disk seeks for inode loading.
echo "vm.vfs_cache_pressure = 50" >> /etc/sysctl.conf

# To avoid long IO stalls for write cache in a real life situation with
# different workloads we typically want to limit the kernel dirty cache size.
# Rule of thumb: <dirty_background_ratio> = 1/4 to 1/2 of the <dirty_ratio>.
echo "vm.dirty_background_ratio = 5" >> /etc/sysctl.conf
echo "vm.dirty_ratio = 10" >> /etc/sysctl.conf

# Set the 50% of available memory overcommit policy.
echo "vm.overcommit_ratio = 50" >> /etc/sysctl.conf
echo "vm.overcommit_memory = 0" >> /etc/sysctl.conf

# But if you run out of memory use next settings that don't do overcommit and
# the total address space will be <swap>+<ram>*<overcommit_ratio>/100.
# vm.overcommit_ratio = 100
# vm.overcommit_memory = 2
# And more. If you run Docker or Redis and have some memory troubles try this:
# vm.overcommit_memory = 1
# vm.overcommit_ratio = 50

# Specifies the minimum virtual address that a process is allowed to mmap.
# It avoids "kernel NULL pointer dereference" defects.
echo "vm.mmap_min_addr = 4096" >> /etc/sysctl.conf

# Keep at least 128MB of free RAM space available. When set to its default
# value it is possible to encounter memory exhaustion symptoms when free memory
# should in fact be available. Setting <vm.min_free_kbytes> to 5-6% of the
# total physical memory but no more than 2GB can prevent this problem.
echo "vm.min_free_kbytes = 131072" >> /etc/sysctl.conf

# RED HAT DOES NOT RECOMMEND TUNNING THIS PARAMETER!
# Specifies the number of centiseconds (hundredths of a second) dirty data
# remains in the page cache before it is eligible to be written back to disk.
# vm.dirty_expire_centisecs = 6000

# RED HAT DOES NOT RECOMMEND TUNNING THIS PARAMETER!
# Specifies the length of the interval between kernel flusher threads waking
# and writing eligible data to disk.
# vm.dirty_writeback_centisecs = 6000

# =========================================================================== #
#           FILE:  sysctl-boilerplate.conf                                    #
#          USAGE:  edit parameters and put them into /etc/sysctl.conf         #
#                                                                             #
#    DESCRIPTION:  This is a boilerplate of /etc/sysctl.conf kernel config    #
#                  adopted for server use with any modern Linux distribution. #
#                  This file contains some basic tweaks for different kernel  #
#                  parameters which can increase performance, responsiveness  #
#                  and network throughput in the high-load scenario for web   #
#                  server, streaming or storage server, e.t.c.                #
#                                                                             #
#   REQUIREMENTS:  /dev/brain, /dev/hands                                     #
#          NOTES:  YOU MUST ADJUST ALL THESE PARAMETERS FOR YOUR SITUATION!   #
#                  Also do not change the value of any kernel parameter on a  #
#                  system where it is already set higher than listed as       #
#                  minimum requirement in this boilerplate.                   #
#         AUTHOR:  Stanislav "systematicat" Kotivetc, <@systematicat>         #
#        COMPANY:  Hire me! I am a cool dude!                                 #
#        VERSION:  1.0                                                        #
#        CREATED:  09.01.2017 - 17:15                                         #
#      COPYRIGHT:  2017 Stanislav "systematicat" Kotivetc                     #
#        LICENSE:  WTFPL v2                                                   #
# =========================================================================== #

###############################################################################
########################## GENERAL SYSTEM OPTIONS #############################
###############################################################################

# Controls the System Request debugging functionality of the kernel.
# In most of the situations you do not need Magic SysRq.
echo "kernel.sysrq = 0" >> /etc/sysctl.conf

# Controls whether core dumps will append the PID to the core filename.
# Useful when you for example debugging multi-threaded applications.
echo "kernel.core_uses_pid = 1" >> /etc/sysctl.conf

# Set amount of PIDs that can run simultaneously in separate memory spaces.
echo "kernel.pid_max = 65535" >> /etc/sysctl.conf

# Set content of /proc/<pid>/maps and smaps files are only visible to
# readers that are allowed to ptrace() the process. Usually it is useless.
# kernel.maps_protect = 1

# Enable ExecShield protection. Usually doesn't work in Ubuntu because it uses
# hardware NX when the CPU supports it or uses NX emulation in the kernel
# equivalent of the Red Hat Exec Shield patch.
# kernel.exec-shield = 1

# Enable random placement of virtual memory regions protection.
# Address Space Layout Randomization can help defeat certain types of buffer
# overflow attacks. Setting parameter 2 will randomize the positions of
# the stack, VDSO page, shared memory regions, and the data segment.
echo "kernel.randomize_va_space = 2" >> /etc/sysctl.conf

# Controls the default max size of queue and default max size of message.
# I use these values from IBM DB2 user manual most of the time.
echo "kernel.msgmnb = 65535" >> /etc/sysctl.conf
echo "kernel.msgmax = 65535" >> /etc/sysctl.conf

# Set the system wide maximum number of shared memory segments.
# value = 256*<total_memory_in_GB>. But Oracle and IBM recommends 4096.
echo "kernel.shmmni = 4096" >> /etc/sysctl.conf

# Define the maximum size in bytes of a single shared memory segment that a
# Linux process can allocate in its virtual address space.
# value = <total_memory_in_bytes>.
echo "kernel.shmmax = 17179869184" >> /etc/sysctl.conf

# Sets the total amount of shared memory pages that can be used system wide.
# Hence, SHMALL should always be at least 2*<shmmax>/<PAGE_SIZE>.
# To find the default PAGE_SIZE run command $getconf PAGE_SIZE.
echo "kernel.shmall = 8388608" >> /etc/sysctl.conf

# Setting Semaphores.
# <SEMMSL> = Oracle recommends at least 250.
# <SEMMNS> = <SEMMSL>*<SEMMNI> Oracle recommends SEMMSL to be at least 32000.
# <SEMOPM> = Oracle recommends to set SEMOPM to a minimum value of 100
# <SEMMNI> = <total_memory_in_GB>*256 but Oracle set SEMMNI at least 128.
# Syntax is kernel.sem = <SEMMSL> <SEMMNS> <SEMOPM> <SEMMNI>
echo "kernel.sem = 250 1024000 100 4096" >> /etc/sysctl.conf

# Set number of message queue identifiers.
# value = 1024*<total_memory_in_GB>.
echo "kernel.msgmni = 16384" >> /etc/sysctl.conf

# This toggle indicates whether restrictions are placed on exposing kernel
# addresses via /proc and other interfaces.
echo "kernel.kptr_restrict = 1" >> /etc/sysctl.conf

# 0 - (default) - traditional behaviour. Any process which has changed
# privilege levels or is execute only will not be dumped.
# 1 - (debug only) - all processes dump core when possible. The core dump is
# owned by the current user and no security is applied.
# 2 - (suidsafe) - any binary which normally not be dumped is dumped readable
# by root only. End user can remove such a dump but not access it directly.
echo "fs.suid_dumpable = 0" >> /etc/sysctl.conf

# Increase size of file handles and inode cache.
# value = <_PHYS_PAGES>*<PAGE_SIZE>/1024/10.
# Find values = $getconf _PHYS_PAGES and $getconf PAGE_SIZE.
echo "fs.file-max = 785928" >> /etc/sysctl.conf

fi
