#!/usr/bin/parallel --shebang-wrap --pipe /bin/bash
#Daily
curl -fsS --retry 3 https://hc-ping.com/7089e144-cdcd-4c58-9817-cac606b83ab0
source /mnt/HDD/Programs//memoryClean.sh 
export hdd=/mnt/HDD/
export back=/mnt/HDD/Backup/
export prog=/mnt/HDD/Programs/
sudo systemctl enable rc-local
cleanMemory
#BACKUP
sudo rm -rf $hdd/Backup/Website/Daily/www.zip | parallel -Jcluster
sudo zip -r9 $hdd/Backup/Website/Daily/www.zip /var/www/* | parallel -Jcluster
#sudo zip -r9 $hdd/Backup/ /iptables.sh
#sudo echo 3 > /proc/sys/vm/drop_caches 
#sudo zip -r9 /mnt/HDD/Backup/iptables/ /iptables/*
sudo cp /etc/rc.lcoal $hdd/Backup/ | parallel -Jcluster
sudo cp /etc/rc.lcoal $prog | parallel -Jcluster
sudo cp /mnt/HDD/.bashrc /mnt/HDD/Backup/ 
sudo rm -rf $hdd/Backup/etc.zip | parallel -Jcluster
sudo zip -r9 $hdd/Backup/etc.zip /etc/ | parallel -Jcluster
cleanMemory
sudo rm -rf $hdd/Backup/ssh.zip 
sudo zip -r9 $hdd/Backup/ssh.zip /etc/ssh/ | parallel -Jcluster
sudo cp /home/ubuntuserver/.bashrc $back
sudo cp /home/ubuntuserver/.bash_exports $back
sudo cp /home/ubuntuserver/.bash_aliases $back 
sudo cp /home/ubuntuserver/.nanorc $back

cleanMemory

sudo bash /mnt/HDD/Programs//fromGithub.sh
cleanMemory
#sudo apt-get dist-upgrade  --yes

#sudo bash /mnt/HDD/Programs/copy-to-new-server.sh
#AV

#sudo mv /mnt/HDD/virus.txt /mnt/HDD/VirusssReports/virus$(date +"%Y-%m-%d").txt
#sudo clamscan -r / --exclude-dir=/mnt/HDD/Virus/| grep FOUND >> /mnt/HDD/virus.txt 
#sudo timeout  300  "sudo clamscan --remove=yes -i -r /"

#dir change gdrive upload 
#sudo bash /mnt/HDD/Programs//Gdrive-Website-Change-UPLOAD-better.sh
#Git change
if [ ! -d /mnt/HDD/Programs/.save/ ]; then 
	mkdir /mnt/HDD/Programs/.save/
fi
mv /mnt/HDD/Programs/*.save* /mnt/HDD/Programs/.save/ 
sudo bash /mnt/HDD/Programs/toGithub.sh
sudo bash /mnt/HDD/Programs//Gdrive-Website-Change-UPLOAD-best.sh
cleanMemory

#sudo bash /mnt/HDD/Programs/Gdrive-Website-Change-UPLOAD.sh

sudo cp -rf /opt/*.sh /mnt/HDD/Programs/
#cleanup 
sudo bash /mnt/HDD/Programs/Cleanup.sh
cleanMemory
#updates 

sudo yes | sudo apt-get update
sudo bash  $prog/localGitAuto
#cd /mnt/HDD/workspace/GET_FOLLOWERS/twitter-bot-for-increased-growth/ 
#sudo python app.py 

#FireWall/Cybersecrity
cpulimit -l 15 sudo fail2ban-server
#sudo bash /iptables/iptables*.sh
sudo bash /mnt/HDD/Programs/jaildefaultunban.sh 
#sudo ufw limit OpenSSH 

## update where files are
sudo updatedb | parallel -Jcluster
cleanMemory
curl -fsS --retry 3 https://hc-ping.com/6f5df9c2-9ded-4707-b527-0550a2270fa4
sleep 20
disown -a && exit 0

