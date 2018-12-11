
#!/usr/bin/parallel --shebang-wrap --pipe /bin/bash
#Daily
alias pingCmd="curl -fsS --retry 3"

pingCmd https://hc-ping.com/7089e144-cdcd-4c58-9817-cac606b83ab0
curl -fsS --retry 3 https://hc-ping.com/7089e144-cdcd-4c58-9817-cac606b83ab0

export hdd=/mnt/HDD/
export back=/mnt/HDD/Backup/
export prog=/mnt/HDD/Programs/
sudo systemctl enable rc-local
alias cleanMem="sudo echo 3 > /proc/sys/vm/drop_caches && sudo echo 2 > /proc/sys/vm/drop_caches && sudo echo 1 > /proc/sys/vm/drop_caches "
#BACKUP
sudo rm -rf $hdd/Backup/Website/Daily/www.zip | parallel -j128 -Jcluster
sudo zip -r9 $hdd/Backup/Website/Daily/www.zip /var/www/* | parallel -j128 -Jcluster
#sudo zip -r9 $hdd/Backup/ /iptables.sh
#sudo echo 3 > /proc/sys/vm/drop_caches 
#sudo zip -r9 /mnt/HDD/Backup/iptables/ /iptables/*
sudo cp /etc/rc.lcoal $hdd/Backup/ | parallel -j128 -Jcluster
sudo cp /mnt/HDD/.bashrc /mnt/HDD/Backup/ 
sudo rm -rf $hdd/Backup/etc.zip | parallel -j128 -Jcluster
sudo zip -r9 $hdd/Backup/etc.zip /etc/ | parallel -j128 -Jcluster
cleanMem
sudo rm -rf $hdd/Backup/ssh.zip 
sudo zip -r9 $hdd/Backup/ssh.zip /etc/ssh/ | parallel -j128 -Jcluster
sudo cp /home/ubuntu/.bashrc $back
sudo cp /home/ubuntu/.bash_exports $back
sudo cp /home/ubuntu/.bash_aliases $back 
sudo cp /home/ubuntu/.nanorc $back

sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches

#updates 
#sudo apt-get upgrade  --yes
sudo bash /mnt/HDD/Programs//fromGithub.sh
cleanMem
#sudo apt-get dist-upgrade  --yes

#sudo bash /mnt/HDD/Programs/copy-to-new-server.sh
#AV

#sudo mv /mnt/HDD/virus.txt /mnt/HDD/VirusssReports/virus$(date +"%Y-%m-%d").txt
#sudo clamscan -r / --exclude-dir=/mnt/HDD/Virus/| grep FOUND >> /mnt/HDD/virus.txt 
#sudo timeout  300  "sudo clamscan --remove=yes -i -r /"

#dir change gdrive upload 
#sudo bash /mnt/HDD/Programs//Gdrive-Website-Change-UPLOAD-better.sh
#Git change
sudo bash /mnt/HDD/Programs/toGithub.sh
sudo bash /mnt/HDD/Programs//Gdrive-Website-Change-UPLOAD-best.sh
cleanMem
#sudo bash /mnt/HDD/Programs/Gdrive-Website-Change-UPLOAD.sh

sudo cp -rf /opt/*.sh /mnt/HDD/Programs/
#cleanup 
sudo bash /mnt/HDD/Programs/Cleanup.sh
cleanMem
#updates 
sudo yes | sudo apt-get update

#cd /mnt/HDD/workspace/GET_FOLLOWERS/twitter-bot-for-increased-growth/ 
#sudo python app.py 

#FireWall/Cybersecrity
cpulimit -l 15 sudo fail2ban-server
sudo bash /iptables/iptables*.sh
sudo bash /mnt/HDD/Programs//jaildefaultunban.sh 
#sudo ufw limit OpenSSH 

## update where files are
sudo updatedb | parallel -j128 -Jcluster
pingCmd https://cronitor.link/1CbIol/complete
