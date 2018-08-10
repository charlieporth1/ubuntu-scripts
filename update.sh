#!/bin/bash
#update
sudo yes | sudo apt -y --fix-broken install
npm i npm
sudo apt-get -y update
sudo apt-get -y dist-upgrade --yes
sudo apt-get -y upgrade --yes
sudo npm update
sudo npm upgrade
gcloud components update

pip install --upgrade -y pip
sudo gem update 

