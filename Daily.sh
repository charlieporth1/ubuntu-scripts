
#!/usr/bin/parallel --shebang-wrap --pipe /bin/bash
#Daily

#BACKUP
sudo rm -rf /mnt/HDD/Backup/Website/Daily/www.zip | parallel -j128 -Jcluster
sudo zip -r9 /mnt/HDD/Backup/Website/Daily/www.zip /var/www/* | parallel -j128 -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo zip -r9 /mnt/HDD/Backup/ /iptables.sh
sudo echo 3 > /proc/sys/vm/drop_caches 
sudo zip -r9 /mnt/HDD/Backup/iptables/ /iptables/*
sudo cp /etc/rc.lcoal /mnt/HDD/Backup/ | parallel -j128 -Jcluster
sudo cp /mnt/HDD/.bashrc /mnt/HDD/Backup/ 
sudo rm -rf /mnt/HDD/Backup/etc.zip | parallel -j128 -Jcluster
sudo zip -r9 /mnt/HDD/Backup/etc.zip /etc/ | parallel -j128 -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo rm -rf /mnt/HDD/Backup/ssh.zip 
sudo zip -r9 /mnt/HDD//Backup/ssh.zip /etc/ssh/ | parallel -j128 -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo cp /home/ubuntu/.bashrc /mnt/HDD/Backup/ 
sudo cp /home/ubuntu/.bash_exports /mnt/HDD/Backup/ 
sudo cp /home/ubuntu/.bash_aliases /mnt/HDD/Backup/ 
sudo cp /home/ubuntu/.nanorc /mnt/HDD/Backup/ 
sudo cp /home/ubuntu/.bash_func /mnt/HDD/Backup/ 

sudo echo 3 > /proc/sys/vm/drop_caches

#updates 
#sudo apt-get upgrade  --yes

#sudo apt-get dist-upgrade  --yes


#AV
sudo freshclam

#sudo mv /mnt/HDD/virus.txt /mnt/HDD/VirusssReports/virus$(date +"%Y-%m-%d").txt
#sudo clamscan -r / --exclude-dir=/mnt/HDD/Virus/| grep FOUND >> /mnt/HDD/virus.txt 
#sudo timeout  300  "sudo clamscan --remove=yes -i -r /"

#dir change gdrive upload 
#sudo bash /mnt/HDD/Programs//Gdrive-Website-Change-UPLOAD-better.sh
#Git change
sudo bash /mnt/HDD/Programs/toGithub.sh
sudo bash /mnt/HDD/Programs//Gdrive-Website-Change-UPLOAD-best.sh
#sudo bash /mnt/HDD/Programs/Gdrive-Website-Change-UPLOAD.sh

#cleanup 
sudo bash /mnt/HDD/Programs/Cleanup.sh

#FireWall/Cybersecrity
sudo fail2ban-server
sudo bash /iptables/iptables*.sh
sudo bash /mnt/HDD/Programs//jaildefaultunban.sh 
#sudo ufw limit OpenSSH 

## update where files are
sudo updatedb | parallel -j128 -Jcluster
