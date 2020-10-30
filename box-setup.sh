#!/bin/bash
#######################################
# Penetration testing toolset
#######################################
apt-get update
apt-get upgrade -y

#apt-get install whois -y
#apt-get install curl -y
#apt-get install wget -y
#apt-get install git -y
#apt-get install nano -y
#apt-get install ruby -y
#apt-get install python -y
#apt-get install winbind -y
#apt-get install git gcc make libpcap-dev -y
#apt-get install python-lxml python-netaddr python-m2crypto python-cherrypy3 python-mako python-requests python-bs4 -y
#apt-get install python-pip
#dpkg-reconfigure locales

INSTALL_PATH="/pte"
#mkdir $INSTALL_PATH

######################################
# Information Gathering/Enumeration :
######################################

#Recon-ng:
#Recon-ng is a full-featured Web Reconnaissance framework written in Python.
#Web : https://bitbucket.org/LaNMaSteR53/recon-ng
#cd $INSTALL_PATH
#URL="https://LaNMaSteR53@bitbucket.org/LaNMaSteR53/recon-ng.git"
#git clone $URL
#cd $INSTALL_PATH/recon-ng
#pip install -r REQUIREMENTS

#Spiderfoot:
#Reconnaissance. Threat intelligence. Perimeter Monitoring
#Web : http://www.spiderfoot.net/
#cd $INSTALL_PATH
#URL="http://www.spiderfoot.net/files/spiderfoot-2.12.0-src.tar.gz"
#wget $URL
#tar xvfz spiderfoot-2.12.0-src.tar.gz
#rm -f spiderfoot-2.12.0-src.tar.gz

#SSLScrape :
#A scanning tool for scaping hostnames from SSL certificates.
#Web: https://github.com/cheetz/sslScrape
#pip2.7 install --upgrade urllib3
#pip2.7 uninstall requests
#pip2.7 install requests
#cd $INSTALL_PATH
#URL="https://github.com/cheetz/sslScrape.git"
#git clone $URL

#Censys subdomain finder :
#This is a tool to enumerate subdomains using the Certificate Transparency logs stored by Censys. It should return any subdomain who has ever been issued a SSL certificate by a public CA.
#Web: https://github.com/christophetd/censys-subdomain-finder
#https://censys.io/
#cd $INSTALL_PATH
#URL="https://github.com/christophetd/censys-subdomain-finder.git"
#git clone $URL
#cd $INSTALL_PATH/censys-subdomain-finder
#pip2.7 install -r requirements.txt

#HostileSubBruteforcer:
#This app will bruteforce for exisiting subdomains and provide the following information:
#IP address,Host
#if the 3rd party host has been properly setup. (for example if site.example.com is poiting to a nonexisiting Heroku subdomain, it'll alert you) -> Currently only works with AWS, Github, Heroku, shopify, tumblr and squarespace.
#Web: https://github.com/nahamsec/HostileSubBruteforcer
#cd $INSTALL_PATH
#URL="https://github.com/nahamsec/HostileSubBruteforcer.git"
#git clone $URL

#Discover:
#For use with Kali Linux. Custom bash scripts used to automate various pentesting tasks.
#Web: https://github.com/leebaird/discover
#git clone https://github.com/leebaird/discover /opt/discover/

#Gitrob:
#Gitrob is a tool to help find potentially sensitive files pushed to public repositories on Github.
#Web: https://github.com/michenriksen/gitrob
#echo "export GOPATH=$HOME/go" >> /root/.profile
#source /root/.profile
#URL="github.com/michenriksen/gitrob"
#go get github.com/michenriksen/gitrob
#export GITROB_ACCESS_TOKEN=

#git-all-secrets:
#A tool to capture all the git secrets by leveraging multiple open source git searching tools
#Web: https://github.com/anshumanbh/git-all-secrets


#Scanning
#******************
#Shodan :
#Shodan is the world's first search engine for Internet-connected devices.
#https://cli.shodan.io/
#easy_install shodan
#shodan init YOUR_API_KEY

#Masscan:
#TCP port scanner, spews SYN packets asynchronously, scanning entire Internet in under 5 minutes.
#Web: https://github.com/robertdavidgraham/masscan
#cd $INSTALL_PATH
#apt-get install gcc make libpcap-dev -y
#URL="https://github.com/robertdavidgraham/masscan"
#git clone $URL
#cd $INSTALL_PATH/masscan
#make -j
#cp $INSTALL_PATH/masscan/bin/masscan /usr/local/bin/
#cd $INSTALL_PATH/
#rm -rf $INSTALL_PATH/masscan

#Nmap :
#Nmap ("Network Mapper") is a free and open source (license) utility for network discovery and security auditing. 
#apt-get install nmap -y

#EyeWitness:
#EyeWitness is designed to take screenshots of websites, provide some server header info, and identify default credentials if possible. 
#Web: https://github.com/FortyNorthSecurity/EyeWitness
#cd $INSTALL_PATH
#URL="https://github.com/FortyNorthSecurity/EyeWitness.git"
#git clone $URL
#pip2.7 install rdpy
#cd $INSTALL_PATH/EyeWitness/setup
#./setup