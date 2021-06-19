# Create the ipset list
ipset -N china hash:net
ipset -N russia hash:net

# remove any old list that might exist from previous runs of this script
rm /tmp/cn.zone

# Pull the latest IP set for China
wget -P . http://www.ipdeny.com/ipblocks/data/countries/cn.zone -O /tmp/cn.zone
wget -P . http://www.ipdeny.com/ipblocks/data/countries/ru.zone -O /tmp/ru.zone

# Add each IP address from the downloaded list into the ipset 'china'
function create_ip-set() {
	CONTRY="$1"
	declare -gx IPSET_BK_NAME=blacklist-$COUNTRY
	sudo ipset create $IPSET_BK_NAME hash:net hashsize 4096
	sudo iptables -I INPUT -m set --match-set $IPSET_BK_NAME src -j DROP -w
	sudo iptables -I FORWARD -m set --match-set $IPSET_BK_NAME src -j DROP -w

}
create_ip-set china
for i in $(cat /tmp/cn.zone )
do
	ipset add $IPSET_BK_NAME $i
	sleep 1s
done
create_ip-set russia
for i in $(cat /tmp/ru.zone )
do
	ipset add russia $i
	sleep 1s
	# --destination-port 22,443,8443,53,853,1443,4443,80,784,1784 
done
# Restore iptables
#sudo iptables-save | sudo tee /etc/iptables.firewall.rules
#/sbin/iptables-restore < /etc/iptables.firewall.rules
sudo iptables-save
