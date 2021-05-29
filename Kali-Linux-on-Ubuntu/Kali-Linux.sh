#!/bin/bash
#########################################################################
# Installation Kali-linux T00ls 0n Ubuntu                                #
# Created by :                                                          #
#| ___|| || | | |    _ __ ___ | || |  _ __   __| |(_)/ _ \___ /| |   (_)#
#|___ \| || |_| |   | '_ ` _ \| || |_| '_ \ / _` || | | | ||_ \| |   | |#
# ___) |__   _| |___| | | | | |__   _| | | | (_| || | |_| |__) | |___| |#
#|____/   |_| |_____|_| |_| |_|  |_| |_| |_|\__,_|/ |\___/____/|_____|_|#
#                                               |__/                    #   
#########################################################################

f_installer(){
  clear
sudo echo "deb http://http.kali.org/ /kali main contrib non-free
deb http://http.kali.org/ /wheezy main contrib non-free
deb http://http.kali.org/kali kali-dev main contrib non-free
deb http://http.kali.org/kali kali-dev main/debian-installer
deb-src http://http.kali.org/kali kali-dev main contrib non-free
deb http://http.kali.org/kali kali main contrib non-free
deb http://http.kali.org/kali kali main/debian-installer
deb-src http://http.kali.org/kali kali main contrib non-free
deb http://security.kali.org/kali-security kali/updates main contrib non-free
deb-src http://security.kali.org/kali-security kali/updates main contrib non-free" >> /etc/apt/sources.list && sudo apt-get update
echo "System telah update"
echo "Sekarang kita akan mengatasi gpg key error yang terjadi diatas"
gpg --keyserver keyserver.ubuntu.com --recv ED444FF07D8D0BF6 && gpg --export --armor 7D8D0BF6 | sudo apt-key add - && sudo apt-get update
}
if [ "$(id -u)" != "0" ]; then
	echo -e "\e[1;32mThis script must be run as root.\e[0m" 1>&2
	exit 1
else
	f_installer
fi
