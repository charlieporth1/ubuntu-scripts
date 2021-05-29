#!/bin/bash
#update
curl -fsS --retry 3 https://hc-ping.com/000c2945-1556-4313-ab3a-f00d3449f3a0
bash /mnt/HDD/Programs//fixdpkg-apt.sh
bash /mnt/HDD/Programs//fixdpkg-apt.sh
npm i npm
sudo apt -y update
sudo apt -y dist-upgrade --yes
sudo apt -y upgrade --yes

sudo apt --with-new-pkgs -y upgrade
sudo npm update
sudo npm upgrade
gcloud components update

pip install --upgrade -y pip
sudo gem update 
sudo gem install fastlane
sudo gem install spaceship
pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
bundle install
curl -fsS --retry 3 https://hc-ping.com/000c2945-1556-4313-ab3a-f00d3449f3a0
pip install google-cloud-language
