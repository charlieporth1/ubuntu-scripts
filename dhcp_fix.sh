sysctl -w net.ipv6.conf.all.forwarding=1
sysctl -w net.ipv4.ip_forward=1

sudo ip link set wlan0 down
sudo ip addr flush wlan0
sudo ip link set wlan0 up
sudo ip link set eth0 down
sudo ip addr flush eth0
sudo ip link set eth0 up
sudo dhclient -r
sudo dhclient
#sudo ifconfig eth0 192.168.44.250 up
