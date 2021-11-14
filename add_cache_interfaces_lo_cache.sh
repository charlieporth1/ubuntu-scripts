modprobe dummy veth dummy
broadcast=0.0.0.0
CACHE_DEV=lo_cache
IP=192.168.127.10
sudo ifconfig lo:0 127.0.0.9 netmask $nm broadcast 255.0.0.0 up
sudo ip link add name $CACHE_DEV type dummy
sudo ifconfig $CACHE_DEV 192.168.127.10 netmask 255.0.0.0 broadcast 192.168.127.10 up
sudo ifconfig $CACHE_DEV mtu 65535
sudo ifconfig $CACHE_DEV txqueuelen 90000000

HOST_TO_WRITE="$IP cache.local cache0.local $CACHE_DEV.local"
[[ -z `grep -o "$HOST_TO_WRITE" /etc/hosts` ]] && echo "$HOST_TO_WRITE" | sudo tee -a /etc/hosts

sudo sysctl -w net.ipv4.conf.$CACHE_DEV.log_martians=0
sudo sysctl -w net.ipv4.conf.$CACHE_DEV.accept_local=1
sudo sysctl -w net.ipv4.conf.$CACHE_DEV.send_redirects=0
sudo sysctl -w net.ipv6.conf.$CACHE_DEV.disable_ipv6=0
sudo sysctl -w net.ipv4.conf.$CACHE_DEV.arp_filter=0
sudo sysctl -w net.ipv4.conf.$CACHE_DEV.arp_ignore=1

sudo ip -6 addr add 2001:0db8:0:f101::aa99/64 dev $CACHE_DEV
