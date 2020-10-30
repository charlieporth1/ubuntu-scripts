#!/bin/bash
#cleanup
sudo apt-get autoremove --yes
#sudo apt-get autoremove --purge --yes
sudo rm -rf /tmp/*
sudo apt-get clean
sudo rm -rf /home/*/.glide/*
sudo rm -rf /home/*/.nvm/*
sudo rm -rf /home/*/.npm/_cacache/*
#sudo rm -rf /home/*/
sudo ucaresystem-core
sudo rm  -rf /var/cache/apt/archives/*
suod rm -rf /home/*/.cache/*
sudo rm -rv /home/*/.local/share/trash/*
sudo rm -rf /var/cache/apt-xapian-index/*
sudo rm -rf /home/*/.local/share/evolution/calendar/trash/*
sudo rm -rf /home/*/.local/share/evolution/mail/trash/*
sudo rm -rf /home/*/.local/share/evolution/tasks/trash/*
sudo rm -rf /home/*/.local/share/evolution/memos/trash/*
sudo rm -rf /home/*/.local/share/evolution/addressbook/trash/*
sudo rm -rf /var/crash/*
sudo rm -rf /var/mail/root
sudo rm -rf /home/*/.config/chromium
cpulimit -l 30 | sudo bleachbit --list | grep -E "[a-z]+\.[a-z]+" | xargs bleachbit --clean
sudo npm cache clean --force
#sudo bash /mnt/HDD/Programs//pipfix.sh 
sudo dpkg --configure -a
journalctl --vacuum-size=25M
