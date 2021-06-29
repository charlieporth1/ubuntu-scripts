iptables-save > /root/firewall_rules.backup
iptables -F
iptables -X
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -L

# RESTORE 
#iptables-restore < /root/firewall_rules.backup
