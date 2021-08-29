#!/bin/bash
source $PROG/all-scripts-exports.sh
# REMOVE APT LOCK
if [[ -f /var/lib/dpkg/lock ]]; then
        rm /var/lib/apt/lists/lock
        rm /var/cache/apt/archives/lock
        rm /var/lib/dpkg/lock*
fi
# UPDATE APT
yes | sudo dpkg --configure -a
yes | apt -y update
yes | apt -y --fix-broken install
yes | apt -y upgrade
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

sudo snap install --classic go
sudo snap refresh --classic go

GO111MODULE=on
go get -v -u github.com/AdguardTeam/dnsproxy
go get -v -u github.com/ameshkov/dnscrypt
go get -u -v github.com/folbricht/routedns/cmd/routedns
sudo /snap/bin/go get -v -u github.com/folbricht/routedns/cmd/routedns
go get -u -v github.com/natesales/q
VP=q_0.4.1_linux_amd64.deb
wget https://github.com/natesales/q/releases/download/v0.4.1/$VP -O ~/$VP
dpkg -i ~/$VP
#bfg_release=`curl --silent "https://api.github.com/repos/rtyley/bfg-repo-cleaner/tags" | jq -r '.[0].name'`
#wget -O /tmp/bfg.jar https://repo1.maven.org/maven2/com/madgag/bfg/$bfg_release/bfg-$bfg_release.jar
wget -O /tmp/dnscrypt.tar.gz  https://github.com/ameshkov/dnscrypt/releases/latest/download/dnscrypt-linux-amd64-` curl --silent "https://api.github.com/repos/ameshkov/dnscrypt/tags" | jq -r '.[0].name'`.tar.gz
tar -xvf /tmp/dnscrypt.tar.gz -C /tmp
cp -rf /tmp/linux-amd64/dnscrypt /usr/local/bin
curl -sSL 'https://github.com/ipinfo/cli/releases/download/ipinfo-1.1.0/deb.sh' | bash
curl -sSL 'https://raw.githubusercontent.com/ipinfo/cli/master/grepip/deb.sh' | bash
curl -sSL "https://raw.githubusercontent.com/ipinfo/cli/master/ipinfo/deb.sh" | bash
curl -sSL "https://raw.githubusercontent.com/ipinfo/cli/master/range2cidr/deb.sh" | bash
curl -sSL "https://raw.githubusercontent.com/ipinfo/cli/master/cidr2range/deb.sh" | bash
curl -sSL https://raw.githubusercontent.com/ahnick/encpass.sh/master/encpass.sh  | sudo tee /usr/local/bin/encpass.sh &
& sudo chmod 777 /usr/local/bin/encpass.sh
if [[ -f /home/charlieporth1_gmail_com/ble.sh/out/ble.sh ]]; then
	bash /home/charlieporth1_gmail_com/ble.sh/out/ble.sh --update
fi
sudo update-ca-certificates
wget https://raw.githubusercontent.com/yubiuser/pihole_adlist_tool/master/pihole_adlist_tool -O /usr/local/bin/pihole_adlist_tool

if [[ "$IS_GCP" == 'true' ]]; then
	sudo apt install -y linux-tools-gcp-edge linux-image-gcp-edge linux-headers-gcp-edge
elif [[ "$IS_AWS" == 'true' ]]; then
	sudo apt install -y linux-tools-aws-edge linux-image-aws-edge linux-headers-aws-edge
else
	sudo apt install -y linux-tools-edge linux-image-edge linux-headers-edge
fi
