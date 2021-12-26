#!/bin/bash
source $PROG/all-scripts-exports.sh
what_system
# REMOVE APT LOCK
bash $PROG/apt-fix.sh
yes | apt -y update
yes | apt -y upgrade
yes | apt -y full-upgrade
yes | apt -y dist-upgrade
yes | apt -y autoremove
yes | apt -y autoclean

# CONFIG
bash $PROG/update-pihole-config.sh
bash $PROG/geoip_updater.sh
bash $PROG/update.unbound-config.sh

# MISC
geoipupdate
pihole-updatelists  --update
gcloud components update

python2 -m pip install --upgrade pip
python3 -m pip install --upgrade pip

sudo snap refresh
sudo snap install --classic go
sudo snap refresh --classic go

GO111MODULE=on
go get -u -v github.com/AdguardTeam/dnsproxy
go get -u -v github.com/ameshkov/dnscrypt
go get -u -v github.com/folbricht/routedns/cmd/routedns
go get -u -v github.com/DNSCrypt/dnscrypt-proxy/dnscrypt-proxy
go get -u -v github.com/projectdiscovery/shuffledns/cmd/shuffledns
go get -u -v github.com/natesales/q
go get -u -v github.com/gonejack/hsize
go get -u -v github.com/maxmind/mmdbinspect/cmd/mmdbinspect
go get -u -v github.com/maxmind/geoipupdate/v4/cmd/geoipupdate

sudo go get -v -u github.com/folbricht/routedns/cmd/routedns
sudo go get -v -u github.com/gonejack/hsize
VP=q_0.4.1_linux_amd64.deb
wget https://github.com/natesales/q/releases/download/v0.4.1/$VP -O ~/$VP
dpkg -i ~/$VP
#bfg_release=`curl --silent "https://api.github.com/repos/rtyley/bfg-repo-cleaner/tags" | jq -r '.[0].name'`
#wget -O /tmp/bfg.jar https://repo1.maven.org/maven2/com/madgag/bfg/$bfg_release/bfg-$bfg_release.jar

wget -O /tmp/dnscrypt.tar.gz  https://github.com/ameshkov/dnscrypt/releases/latest/download/dnscrypt-linux-amd64-` curl --silent "https://api.github.com/repos/ameshkov/dnscrypt/tags" | jq -r '.[0].name'`.tar.gz
wget https://github.com/DNSCrypt/encrypted-dns-server/releases/download/0.9.1/encrypted-dns_0.9.1_amd64.deb
sudo dpkg -i encrypted-dns_0.9.1_amd64.deb
tar -xvf /tmp/dnscrypt.tar.gz -C /tmp
cp -rf /tmp/linux-amd64/dnscrypt /usr/local/bin


if [[ -f /home/charlieporth1_gmail_com/ble.sh/out/ble.sh ]]; then
	bash /home/charlieporth1_gmail_com/ble.sh/out/ble.sh --update
fi


if [[ "$IS_GCP" == 'true' ]]; then
	curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
	sudo apt install -y linux-tools-gcp-edge linux-image-gcp-edge linux-headers-gcp-edge
elif [[ "$IS_AWS" == 'true' ]]; then
	sudo apt install -y linux-tools-aws-edge linux-image-aws-edge linux-headers-aws-edge
else
	sudo apt install -y linux-tools-edge linux-image-edge linux-headers-edge
fi

if [[ "$HOSTNAME" != "ctp-vpn" ]] then
	(yes | gcloud beta compute ssh --zone $GCLOUD_ZONE $MASTER_MACHINE --project $GCLOUD_PROJECT)&
fi


sudo update-ca-certificates
sudo update-alternatives --remove iptables /usr/sbin/iptables-legacy
sudo update-alternatives --remove iptables-save /usr/sbin/iptables-legacy-save
sudo update-alternatives --remove iptables-restore /usr/sbin/iptables-legacy-restore
sudo update-alternatives --remove ip6tables /usr/sbin/ip6tables-legacy
sudo update-alternatives --remove ip6tables-save /usr/sbin/ip6tables-legacy-save
sudo update-alternatives --remove ip6tables-restore /usr/sbin/ip6tables-legacy-restore
sudo update-alternatives --remove traceroute /usr/bin/traceroute

sudo bash /home/charlieporth1_gmail_com/Pihole-Slave-Install/setup/other_bin_installs.sh
