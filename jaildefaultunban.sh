#fail2ban-client set YOURJAILNAMEHERE unbanip IPADDRESSHERE
#sudo iptables -L -n
fail2ban-client status 
fail2ban-client set sshd unbanip 192.168.1.250
fail2ban-client set sshd unbanip 127.0.0.1
fail2ban-client set sshd unbanip 192.168.1.200
fail2ban-client set sshd unbanip 192.168.1.91
fail2ban-client set sshd unbanip otih-otih.us.to
fail2ban-client set sshd unbanip 73.94.98.78




