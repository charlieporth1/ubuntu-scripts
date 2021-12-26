ping 10.128.0.9
ifconfig
wget https://raw.githubusercontent.com/Nyr/wireguard-install/master/wireguard-install.sh
ping 1.1.1.1
sudo wg-quick down wg0-client
ping 1.1.1.1
sudo iptables
sudo nano /etc/wireguard/wg0-client.conf
sudo wg-quick up wg0-client
ping 1.1.1.1
sudo iptables
sudo wg-quick down wg0-client
sudo nano /etc/wireguard/wg0-client.conf
sudo wg-quick down wg0-client
sudo wg-quick up wg0-client
ping 1.1.1.1
sudo wg-quick down wg0-client
sudo nano /etc/wireguard/wg0-client.conf
sudo nano /etc/wireguard/wg0
sudo nano /etc/wireguard/wg0-client.conf
sudo nano /etc/wireguard/wg0-client.conf
sudo wg-quick up wg0-client
ping 10.128.0.9
ping 10.66.66.1
ssh 10.66.66.1
nano ~/.ssh/config 
ssh 10.66.66.1
nano ~/.ssh/config 
ssh 10.66.66.1
rm -rf ~/.ssh/c
ssh 10.66.66.1
rm -rf ~/.ssh/master-*
ssh 10.66.66.1
nano ~/.ssh/config 
ping 100.71.239.28
ssh 10.66.66.1
ssh 10.66.66.1
sudo wg-quick down wg0-client
sudo wg-quick up wg0-client
sudo wg-quick down wg0-client
ping 10.66.66.1
ping 10.66.66.1
sudo wg-quick down wg0-client
sudo wg-quick up wg0-client
nano ~/.ssh/config 
nano /etc/ssh/ssh_config
nano ~/.ssh/config 
ping 10.66.66.1
ssh 10.66.66.1
nano ~/.ssh/config 
ping 10.66.66.1
ifconfig
ping 10.66.66.2
ping 10.66.66.1
nano ~/.ssh/config 
sudo wg-quick down wg0-client
ping 35.192.105.158
sudo crontab -e
*/10 6-23   *   *   *       bash $PROG/server-online-check.sh gcp.ctptech.dev 
 bash $PROG/server-online-check.sh gcp.ctptech.dev 
ping gcp.ctptech.dev
ping gcp.ctptech.dev
ssh 35.192.105.158
ssh gcp.ctptech.dev
sudo wg-quick up wg0-client
ping 10.128.0.9
ping 10.66.66.2
ping 10.66.66.1
ping 10.66.66.1
sudo nano /etc/wireguard/wg0-client
sudo nano /etc/wireguard/wg0-client.conf
sudo nano /etc/wireguard/wg0-client.conf
sudo wg-quick upn wg0-client
sudo wg-quick up wg0-client
sudo wg-quick down wg0-client
sudo wg-quick up wg0-client
ping 10.128.0.9
ping 10.128.0.9 -I wg0-client
sudo wg-quick  up wg0
sudo wg-quick  up wg0
wget https://raw.githubusercontent.com/Nyr/wireguard-install/master/wireguard-install.sh
sudo wg-quick down wg0-client
https://raw.githubusercontent.com/Nyr/wireguard-install/master/wireguard-install.sh
wget https://raw.githubusercontent.com/Nyr/wireguard-install/master/wireguard-install.sh
ifconfig
sudo apt search pia
sudo apt search pia
sudo apt search private-internet
wget https://www.privateinternetaccess.com/installer/x/download_installer_linux
wget https://www.privateinternetaccess.com/installer/download_installer_linux_beta
tar -xvf download_installer_linux_beta 
chmod +x ./download_installer_linux_beta 
./download_installer_linux_beta 
chmod +x pia-linux-3.2-06857.run 
./pia-linux-3.2-06857.run 
wget https://github.com/pia-foss/manual-connections/archive/refs/tags/v2.0.0.tar.gz
tar -vxf v2.0.0.tar.gz 
cd manual-connections-2.0.0/
ls
./run_setup.sh 
sudo ./run_setup.sh 
nano   ./port_forwarding.sh
ifconfig
curl -LO https://raw.githubusercontent.com/SomajitDey/tunnel/main/tunnel
cd ..
curl -LO https://raw.githubusercontent.com/SomajitDey/tunnel/main/tunnel
chmod +x ./tunnel
./tunnel -c install
tunnel 
tunnel -h
cat /proc/sys/net/ipv4/conf/ppp0/forwarding 
iptables -t nat -A PREROUTING -p tcp -i ppp0 --dport 8001 -j DNAT --to-destination 192.168.1.200:8080
iptables -A FORWARD -p tcp -d 192.168.1.200 --dport 8080 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A FORWARD -p udp -d 192.168.44.243 --dport 13231 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
sudo iptables -t nat -A PREROUTING -p udp -i ppp0 --dport 13231 -j DNAT --to-destination 192.168.44.243:13231
sudo nmap -sU -T4 192.168.44.250 -p 13231
sudo nmap -sU -T4 192.168.44.243 -p 13231
sudo nmap -sU -T4 192.168.44.250 -p 13231
sudo iptables -t nat -A PREROUTING -p udp -i ppp0 --dport 13231 -j DNAT --to-destination 192.168.44.243:13231
ifconfig
sudo iptables -t nat -D PREROUTING -p udp -i ppp0 --dport 13231 -j DNAT --to-destination 192.168.44.243:13231
sudo iptables -D FORWARD -p udp -d 192.168.44.243 --dport 13231 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A FORWARD -p udp -d 192.168.44.243 --dport 13231 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -t nat -A PREROUTING -p tcp --dport 8001 -j DNAT --to-destination
sudo iptables -t nat -A PREROUTING -p tcp --dport 13231  -j DNAT --to-destination  192.168.44.243:13231
sudo iptables -t nat -A PREROUTING -p udp --dport 13231  -j DNAT --to-destination  192.168.44.243:13231
sudo nmap -sU -T4 192.168.44.250 -p 13231
sudo nmap -sU -T4 192.168.12.250 -p 13231
sudo nmap -sU -T4 192.168.44.250 -p 13231
yours_wan_ip=$(bash /home/ubuntuserver/Programs/get_ext_ip.sh --current-ip)
echo $yours_wan_ip
yours_wan_ip=$(bash /home/ubuntuserver/Programs/get_ext_ip.sh --current-ip)
echo $yours_wan_ip
sudo ip route
yours_wan_ip=174.53.130.17
sudo iptables -A PREROUTING  -p tcp -m tcp -d $yours_wan_ip --dport 8001 -j DNAT --to-destination 192.168.1.200:8080
sudo iptables -A PREROUTING  -p tcp -m tcp -d $yours_wan_ip --dport 13231 -j DNAT --to-destination 192.168.44.243:13231
sudo iptables -A PREROUTING  -p udp -m udp -d $yours_wan_ip --dport 13231 -j DNAT --to-destination 192.168.44.243:13231
sudo iptables -t nat  -A PREROUTING  -p udp -m udp -d $yours_wan_ip --dport 13231 -j DNAT --to-destination 192.168.44.243:13231
sudo iptables -A FORWARD -m state -p udp -d 192.168.44.243 --dport 13231 --state NEW,ESTABLISHED,RELATED -j ACCEPT
sudo iptables -t nat -A POSTROUTING -t nat -p udp -m udp -s 192.168.44.243 --sport 13231 -j SNAT --to-source $yours_wan_ip
sudo nmap -sU -T4 192.168.12.250 -p 13231
sudo nmap -sU -T4 192.168.44.250 -p 13231
sudo nmap -sU -T4 $yours_wan_ipubuntuserver -p 13231
sudo iptables -t nat -D POSTROUTING -t nat -p udp -m udp -s 192.168.44.243 --sport 13231 -j SNAT --to-source $yours_wan_ip
sudo iptables -D FORWARD -m state -p udp -d 192.168.44.243 --dport 13231 --state NEW,ESTABLISHED,RELATED -j ACCEPT
sudo iptables -t nat  -D PREROUTING  -p udp -m udp -d $yours_wan_ip --dport 13231 -j DNAT --to-destination 192.168.44.243:13231
sudo iptables -t nat -D POSTROUTING -t nat -p udp -m udp -s 192.168.44.243 --sport 13231 -j SNAT --to-source $yours_wan_ip
sudo nano $PROG/port_forwarding.sh
sudo chmod +x $PROG/port_forwarding.sh
sudo $PROG/port_forwarding.sh
sudo ip 
ifconfig
sudo wg-quick down pia
sudo $PROG/port_forwarding.sh
sudo $PROG/port_forwarding.sh 192.168.44.243 13231
sudo nmap -sU -T4 192.168.44.250 -p 13231
sudo nmap -sU -T4 $yours_wan_ipubuntuserver -p 13231
cp -rf /home/ubuntuserver/Programs/port_forwarding.sh /home/ubuntuserver/Programs/port_forwarding_1.sh
sudo nano /home/ubuntuserver/Programs/port_forwarding_1.sh
sudo $PROG/port_forwarding.sh -r 192.168.44.243 13231
sudo $PROG/port_forwarding.sh  192.168.44.243 13231 192.168.44.250
sudo nano /home/ubuntuserver/Programs/port_forwarding_1.sh
sudo nano  /home/ubuntuserver/Programs/port_forwarding.sh 
sudo $PROG/port_forwarding.sh  192.168.44.243 13231 13231 192.168.44.250
sudo nmap -sU -T4 192.168.44.250 -p 13231
 wg genkey > server_privatekey
wg pubkey < server_privatekey > server_publickey_client1
cat server_publickey_client1
sudo wg-quick up wg1-client
sudo wg-quick up wg0-client
ping 192.168.44.1
ping 1.1.1.1
ping 10.128.0.9
history | grep nmap
 sudo nmap -sU -T4 192.168.44.243 -p 13231
ifconfig
ping 1.1.1.1
sudo wg-quick up wg0
sudo ./wireguard-install.sh 
sudo bash ./wireguard-install.sh 
ping 1.1.1.1
ifconfig
sudo wg-quick down wg0-client
sudo nano /etc/rc.local
ping 1.1.1.1
ssh 
te1.tunnelin.com:54768
te1.tunnelin.com -p 54768 
ssh te1.tunnelin.com -p 54768 
te1.tunnelin.com:54768
wget https://mullvad.net/download/app/deb/latest/
wget https://mullvad.net/media/app/MullvadVPN-2021.6_amd64.deb
tar -vxf MullvadVPN-2021.6_amd64.deb 
sudo dpkg -i MullvadVPN-2021.6_amd64.deb 
systemctl status mullvad-vpn
systemctl status mullvad-daemon
mullvad
mullvad account
mullvad account set 1309 7710 9536 4462
mullvad account set "1309 7710 9536 4462"
mullvad 
mullvad connect
ifconfig
mullvad connect
mullvad connect ?
mullvad connect --help
mullvad connect -w 
ifconfig
bash /home/ubuntuserver/Programs/get_ext_ip.sh 
nano /home/ubuntuserver/Programs/get_ext_ip.sh 
exit
sudo apt install docker.io; Cudo
sudo apt install docker.io;sudo apt purge docøker.io
y
y
sudoø apt install -y coøntainerd
sudoø apt install -y coøntainerd
sudoø apt install -y coøntainerd
sudoø apt install -y coøntainerd
sudoø apt install -y coønt
sudoø apt install -y coøntaøinerd
sudoø apt install -y coøntaøin
sudoø apt i purge  0 y oøntaøin
sudoø apt i purge  0 -øntaøin
sudo apt purge 0y con
sudo apt purge -y containerd
bash /home/ubuntuserver/Programs/get_ext_ip.sh 
bash /home/ubuntuserver/Programs/get_ext_ip.sh --currebt-ip
bash /home/ubuntuserver/Programs/get_ext_ip.sh --current-ip
ifconfig
mullvad connect
mullvad connect
bash /home/ubuntuserver/Programs/get_ext_ip.sh --currebt-ip

nc -l 5555
ifconfig
sudo ip add
piactl 
piactl allowlan
piactl alloøset allowlan
piactl alloøset allowlan
piactl aset allowlan
piact aset allowlan
piactl sset allowlan
piactl sst allowlan
piactl set allowlan
piactl set allowlan tøue
piactl set allowlan tørue
piactl set allowlan tøuòe
piactl set allowlan tøurue
piactl set allowlan ture
piactl set allowlan true
piactl set allowlan tøue
piactl set allowlan tpia
piactl 
ifconifg
udo mu
mullvad ødown
mullvad ødisconnect
mullvad disconnect
mullvad disconnect
mullvad disconnect
exit
ifconfig
pia
piactl 
piactl set requestportforward 500
piactl set requestportforward 500 trie
piactl  requestportforward 500 
piactl set  requestportforward 500
piactl set  requestportforward 500 
ifconfig
nmap -T4 192.168.44.250
nmap -T4 -sU 192.168.44.250 -p 4500,500
sudo nmap -T4 -sU 192.168.44.250 -p 4500,500
exit
ping -I eth0 10.128.0.9
ping -I eth2 10.128.0.9
ping -I eth2 10.128.0.9 -a
ping -I ethI 10.128.0.9 -a
ping -I eth1 10.128.0.9 -a
ping -I eth0 10.128.0.9 -a
nmap -T4 -sU 192.168.44.250 -p 4500,500
sudo nmap -T4 -sU 192.168.44.250 -p 4500,500
sudo iptables
sudo iptables -S
sudo apt install strongswan
sudo sud
sudo su
ping 10.128.0.9 -I eth0
ping 10.128.0.9 -I eth0 -a
htop
ping 192.168.44.1
ping 192.168.44.243
ping 192.168.42.1
ssh admin@192.168.42.1
ping 192.168.42.1
ssh admin@192.168.42.1
ping 192.168.42.1
ping -a 192.168.42.1
ping 192.168.42.1
dig dns.google
dig dns.google -t aaaa
ifconfig eth0
ping6 dns.google -I eth0
ifconfig eth0
ping6 dns.google -I eth0
ping6 dns.google -I eth0 -a
ifconfig
ping6 dns.google -I eth0 -a
last
ping6 dns.google -I eth0 -a
ping6 dns.google -I eth0
ifconfg eth0
ifconfig eth0
pihole -up
ping6 dns.google -I eth0 -a
ping6 dns.google -I eth0 -a
ping6 dns.google -a -I 2001:470:1f11:5ba:230:18ff:feb0:7ef
ping6 dns.google -I eth0 -a
ping6 dns.google -a -I 2001:470:1f11:5ba:230:18ff:feb0:7ef
ping6 dns.google -a -I 2001:470:1f10:5ba:230:18ff:feb0:7ef
ping6 dns.google -a -I 2001:470:1f11:5ba:230:18ff:feb0:7ef
ping6 dns.google -a -I eth0
ping6 dns.google -a -I 2001:470:1f10:5ba:230:18ff:feb0:7ef
ping6 dns.google -a -I eth0
ping6 dns.google -a -I 2001:470:1f10:5ba:230:18ff:feb0:7ef
sudo crontab -e
sudo nano /etc/rc.local
ping6 dns.google -a -I 2001:470:1f10:5ba:230:18ff:feb0:7ef
sudo su
ping6 dns.google -a -I 2001:470:1f10:5ba:230:18ff:feb0:7ef
ifconfig
mullvad
mullvad tunnel
mullvad tunnel wireguard 
mullvad tunnel wireguard key 
mullvad tunnel wireguard key regenerate 
pihole -w www.paypal.com
sudo wget https://support.vyprvpn.com/hc/article_attachments/360052622052/ca.vyprvpn.com.crt -O /etc/openvpn/ca.vyprvpn.com.crt
scp /etc/openvpn/ca.vyprvpn.com.crt 192.168.44.243
scp /etc/openvpn/ca.vyprvpn.com.crt admin@192.168.44.243:/
sudo apt install openvpn -y
wget https://support.vyprvpn.com/hc/article_attachments/360052617332/Vypr_OpenVPN_20200320.zip
unzip Vypr_OpenVPN_20200320.zip 
sudo openvpn --config GF_OpenVPN_20200320/USA\ \-\ Chicago.ovpn
n GF_OpenVPN_20200320/USA\ \-\ Chicago.ovpn
nano GF_OpenVPN_20200320/USA\ \-\ Chicago.ovpn
sudo openvpn --config GF_OpenVPN_20200320/OpenVPN256/USA\ -\ Chicago.ovpn
ifconfig
ping www.google.com
ping4 www.google.com
ip
ifconfig
sudo nmap -T4 10.2.2.175
bash /home/ubuntuserver/Programs/get_ext_ip.sh
bash /home/ubuntuserver/Programs/get_ext_ip.sh --current-ip
nmap -T4 208.91.71.234
nmap -T4 -Pn 208.91.71.234
sudo openvpn --config GF_OpenVPN_20200320/OpenVPN256/USA\ -\ Chicago.ovpn
sudo ip route
ifconnifg
ifconfig
sudo ip tunnel
sudo ip route del tun1
sudo ip add del dev tun1
sudo ip tunnel
sudo ip tunnel -a
sudo ip tunnel a
sudo ip tunnel all
sudo ip tunnel
sudo ip add
sudo ip 
sudo ip tuntap
sudo ip tuntap del tun1
sudo ip tuntap del tun0
sudo ip tuntap del dev tun0 
sudo ip tuntap del ?
sudo ip tuntap help
sudo ip tuntap del dev tun0
sudo ip tuntap del dev tun0 
sudo ip tuntap del dev tun1
sudo openvpn --config GF_OpenVPN_20200320/OpenVPN256/USA\ -\ Chicago.ovpn
htop
ifconfig
nmap -T4 -sU home.ctptech.dev -p 500
sudo nmap -T4 -sU home.ctptech.dev -p 500
sudo nmap -T2 -sU home.ctptech.dev -p 500
sudo nmap -T2 -sU 174.53.130.17 -p 500
sudo nmap -T4 -sU 174.53.130.17 -p 500
sudo nmap -T4 -sU 174.53.130.17 -p 22
sudo nmap -T4 -sU 174.53.130.17 -p 53
sudo nmap -T4 -sU 174.53.130.17 -p 853
sudo nmap -T4 -sU 174.53.130.17 -p 784
sudo nmap -T4 -sU 174.53.130.17 -p 500
sudo nmap -T4 -sU 174.53.130.17 -p 784
bash /home/ubuntuserver/Programs/get_ext_ip.sh --current-ip
sudo ip
sudo ip route
nmap -T4 -Pn 208.91.71.234
sudo nmap -T4 -sU 208.91.71.234
sudo nmap -T4 -sU 208.91.71.234 -p 4500,500
bash /home/ubuntuserver/Programs/get_ext_ip.sh --current-ip
bash /home/ubuntuserver/Programs/get_ext_ip.sh --current-ip
ping 208.91.71.234
nmap -T4 208.91.71.234
ssh 208.91.71.234
ping eth0 10.128.0.9
ping -I  eth0 10.128.0.9
ping -I  eth0 10.128.0.9 -a
ping -I eth2 10.128.0.9 -a
ping -I eth2 10.128.0.9 -a
screen /dev/serial/by-id/usb-Prolific_Technology_Inc._USB-Serial_Controller_D-if00-port0 
screen -r
screen -d
screen -k
screen -D
screen -D
screen -d
screen -x
screen -J
screen -R
screen -q
screen -D
screen /dev/serial/by-id/usb-FTDI_FT232R_USB_UART_A402IXRQ-if00-port0 
screen /dev/serial/by-id/usb-FTDI_FT232R_USB_UART_A402IXRQ-if00-port0 115200
screen /dev/serial/by-id/usb-FTDI_FT232R_USB_UART_A402IXRQ-if00-port0 115200
screen /dev/serial/by-id/usb-FTDI_FT232R_USB_UART_A402IXRQ-if00-port0 115200
screen /dev/serial/by-id/usb-FTDI_FT232R_USB_UART_A402IXRQ-if00-port0 115200
screen /dev/serial/by-id/usb-FTDI_FT232R_USB_UART_A402IXRQ-if00-port0 115200
screen /dev/serial/by-id/usb-FTDI_FT232R_USB_UART_A402IXRQ-if00-port0 115200
screen /dev/serial/by-id/usb-FTDI_FT232R_USB_UART_A402IXRQ-if00-port0 115200
killall screen
killall screen
screen /dev/serial/by-id/usb-FTDI_FT232R_USB_UART_A402IXRQ-if00-port0 115200
ping dns.google
sudo nano /etc/resolv.conf
ping dns.google
ping5 dns.google
ping6 dns.google
dig 1.1.1.1
dig @1.1.1.1
ifconfig
ping 192.168.44.1
ping 192.168.44.2
ping 192.168.12.1
dig 1.1.1.1
ping dns.google
systemctl status systemd-resolvconf
systemctl status systemd-resolvconf
systemctl status systemd-resolved.service 
sudo nano /etc/systemd/resolved.conf
FIRST_NAME_SERVER=`grep nameserver $DNS_FILE | sed -n '1p'`
DNS_FILE=/etc/resolv.conf
DNS_SERVER=169.254.169.254
FIRST_NAME_SERVER=`grep nameserver $DNS_FILE | sed -n '1p'`
 DNS_SERVER=192.168.44.1
sed -i "s/$FIRST_NAME_SERVER/nameserver $DNS_SERVER\n nameserver192.168.12.1\n nameserver 192.168.44.243/g" $DNS_FILE
sudo sed -i "s/$FIRST_NAME_SERVER/nameserver $DNS_SERVER\n nameserver192.168.12.1\n nameserver 192.168.44.243/g" $DNS_FILE
sudo nano $DNS_FILE 
FIRST_NAME_SERVER=`grep nameserver $DNS_FILE | sed -n '1p'`
  sed -i "s/$FIRST_NAME_SERVER/nameserver $DNS_SERVER\nnameserver 192.168.12.1\nnameserver 192.168.44.243/g" $DNS_FILE
sudo  sed -i "s/$FIRST_NAME_SERVER/nameserver $DNS_SERVER\nnameserver 192.168.12.1\nnameserver 192.168.44.243/g" $DNS_FILE
sudo nano $DNS_FILE 
cd Pihole-Slave-Install/
sudo git stash && sudo git pull
x
ping 1.1.1.1 -a
ifconfig
ping 1.1.1.1 -a
sudo reboot
ping 1.1.1.1 -a
ping 1.1.1.1 -a
iperf 
iperf -s
iperf -c 192.168.44.99
iperf -c 192.168.44.99 --help
iperf -c 192.168.44.99 -B 192.168.42.250
iperf -c 192.168.44.99 -B 192.168.42.250
killall iperf
iperf -c 192.168.44.99 -B 192.168.42.250:5001
iperf -c 192.168.44.99 -B 192.168.44.100:5001
iperf -c 192.168.44.99 -B 192.168.44.100:5001
whle true; do iperf -c 192.168.44.99 -B 192.168.44.100:5001 ;done
while true; do iperf -c 192.168.44.99 -B 192.168.44.100:5001 ;done
cd Pihole-Slave-Install/
sudo git stash && sudo git pull
ifconfig
ping6 dns.google -I eth0
ping6 dns.google -I eth0 -c 100 -i 200
cat /proc/cpuinfo | grep aes
cat /proc/cpuinfo
ifconfig
ifconfig
htop
cat /proc/cpuinfo
ifconfig
NetTechScience99#ifconfig=
sudo apt-get update && sudo apt-get install tailscale
systemctl status ctp-dns
