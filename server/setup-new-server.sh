#!/bin/bash
#ssh banner
sudo sed -e -i 's/#Banner /etc/issue.net/Banner /etc/issue.net/g' /etc/ssh/sshd_config
sudo sed -e -i 's/#Banner none/Banner /etc/issue.net/g' /etc/ssh/sshd_config
if [ ! -z "$(cat /etc/ssh/ssh_config | grep -o \#Banner /etc/issue.net)" ]; then
echo Banner /etc/issue.net >> /etc/ssh/sshd_config
fi
if [ ! -z "$(cat /etc/ssh/ssh_config | grep -o \#Banner none)" ]; then
echo Banner /etc/issue.net >> /etc/ssh/sshd_config
fi

#ssh_config
if [ -z "$(cat /etc/ssh/ssh_config | grep -o 'tegra-ubuntu')" ]; then
echo "Host tegra-ubuntu 				" >> /etc/ssh/ssh_config
echo "       User ubuntu				" >> /etc/ssh/ssh_config
echo "       Hostname 192.168.1.251		" >> /etc/ssh/ssh_config
echo "       Port 22				" >> /etc/ssh/ssh_config
echo "       IdentityFile /home/*/.ssh/id_rsa	" >> /etc/ssh/ssh_config
echo "       Ciphers rijndael-cbc@lysator.liu.se " >> /etc/ssh/ssh_config
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

if [ -z "$(cat /etc/network/interface | grep -o 'auto lo')" ]; then
echo "\# This file describes the network interfaces available on your system" >> /etc/network/interfaces
echo "\# and how to activate them. For more information, see interfaces(5)"." >> /etc/network/interfaces
echo "" 							 >> /etc/network/interfaces
echo "\# The loopback network interface" >> /etc/network/interfaces
echo "auto lo" >> /etc/network/interfaces
echo "iface lo inet loopback" >> /etc/network/interfaces
fi

export dns="dns-nameservers 1.1.1.1 8.8.8.8 8.8.4.4 9.9.9.9"
export ethdev="$(ifconfig | awk '{print $1}' | grep -v 'docker\|inet\|lo\|inet6\|UP\|RX\|TX\|collisions:*\|virbr0')"
if [ -z "$(cat /etc/network/interfaces | grep -o 'auto $ethdev')" ]; then
export masterip="$(ssh tegra-ubuntu cat /etc/ssh/ssh_config | grep -A 1  $HOSTNAME | grep -oE  "\b([0-9]{1,3}\.)"{3}[0-9]{1,3}\b")"
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
