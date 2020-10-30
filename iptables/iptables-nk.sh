#Bash
#NK (North-Korea) 


# Free IP2Location Firewall List by Country
# Source: http://www.ip2location.com/free/visitor-blocker
iptables -A INPUT -s 57.73.224.0/19 -j DROP
iptables -A INPUT -s 175.45.176.0/22 -j DROP

