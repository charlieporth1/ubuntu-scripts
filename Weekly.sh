#!/usr/bin/parallel --shebang-wrap --pipe /bin/bash
#weekly
#other server 
#sudo bash /mnt/HDD/Programs/copy-to-new-server.sh
#sudo systemctl enable rc-local

#backup
sudo rm -rf /mnt/HDD/Backup/Website/Weekly/www.zip | parallel -j128 -Jcluster
sudo zip -r9 /mnt/HDD/Backup/Website/Weekly/www.zip /var/www/* | parallel -j128 -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches 
sudo rm -rf /mnt/HDD/Backup/usrbin/.zip | parallel -j128 -Jcluster
sudo zip -r9 /mnt/HDD/Backup/usrbin.zip  /usr/bin  | parallel -j128 -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo rm -rf /mnt/HDD/Backup/usrlocale.zip  | parallel -j128 -Jcluster
sudo zip -r9 /mnt/HDD/Backup/usrlocale.zip  /usr/locale & | parallel -j128 -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo rm -rf /mnt/HDD/Backup/usrshare.zip | parallel -j128 -Jcluster
sudo zip -r9 /mnt/HDD/Backup/usrshare.zip  /usr/share & | parallel -j128 -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo rm -rf /mnt/HDD/Backup/usrsrc.zip | parallel -j128 -Jcluster
sudo zip -r9 /mnt/HDD/Backup/usrsrc.zip  /usr/src & | parallel -j128 -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo rm -rf /mnt/HDD/Backup/usrgames.zip | parallel -j128 -Jcluster
sudo zip -r9 /mnt/HDD/Backup/usrgames.zip  /usr/games & | parallel -j128 -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches  
sudo rm -rf /mnt/HDD/Backup/usrinclude.zip | parallel -j128 -Jcluster
sudo zip -r9 /mnt/HDD/Backup/usrinclude.zip  /usr/include & | parallel -j128 -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo rm -rf /mnt/HDD/Backup/usrbin.zip | parallel -j128 -Jcluster
sudo zip -r9 /mnt/HDD/Backup/usrsbin.zip  /usr/sbin & | parallel -j128 -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo rm -rf /mnt/HDD/Backup/usrlib.zip | parallel -j128 -Jcluster
sudo zip -r9 /mnt/HDD/Backup/usrlib.zip  /usr/lib & | parallel -j128 -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo rm -rf /mnt/HDD/Backup/usrlocal.zip | parallel -j128 -Jcluster
sudo zip -r9 /mnt/HDD/Backup/usrlocal.zip /usr/local/ & | parallel -j128 -Jcluster
sudo cp -rf /home/ubuntu/.bash* /mnt/HDD/Backup/   
sudo echo 3 > /proc/sys/vm/drop_caches
sudo cp -rf /home/ubuntu/.bash* /mnt/HDD/Programs/   
sudo echo 3 > /proc/sys/vm/drop_caches



#sudo rm -r /mnt/HDD/HACK/*
#cd /mnt/HDD/HACK
#sudo git clone https://github.com/hak5/bashbunny-payloads.git
#sudo git clone https://github.com/offensive-security/exploit-database.git
#sudo git clone https://github.com/offensive-security/exploit-database-papers.git
#sudo git clone git@github.com:offensive-security/exploit-database-bin-sploits.git
#emails
sudo cp -rf /opt/*.sh /mnt/HDD/Programs/
sudo bash /mnt/HDD/Programs/email-virus-report.sh
sudo bash /mnt/HDD/Programs/copy-to-new-server.sh
cp -rf /usr/bin/mikrotik /mnt/HDD/Programs

echo done with that
#GitAutoUpdate
#sudo gdrive update -r -p 1sscS0H_MzZP9nvBMQ3cUpoIug5aNDDCY /mnt/HDD/HACK
#sudo bash /mnt/HDD/Programs/GitChangedWeekly.sh
sudo bash /mnt/HDD/Programs//GitChangedWeekly-better.sh
sudo bash /mnt/HDD/cockpit/updatecock.sh
sudo bash /mnt/HDD/Programs/toGithub.sh
sudo bash /mnt/HDD/Programs/Gdrive-Website-Change-UPLOAD-best.sh

#Matanice 
sudo freshclam
sudo npm cache clean --force | parallel -j128 -Jcluster
bleachbit --list | grep -E "[a-z]+\.[a-z]+" | xargs bleachbit --clean | parallel -j128 -Jcluster
sudo /mnt/HDD/Programs/Cleanup.sh | parallel -j128 -Jcluster
sudo geoipupdate
#sudo bash /mnt/HDD/Programs//Bash-History-Clear-first-part-forloop.sh
#sudo /etc/init.d/nscd reload    # nscd
sudo bash /mnt/HDD/Programs//pipfix.sh | parallel -j128 -Jcluster

#Updates 
sudo bash /mnt/HDD/Programs/update.sh 

sudo ntpdate -u 192.168.1.91
sudo timedatectl set-ntp on

#AV
sudo freshclam | parallel -j128 -Jcluster
sudo mv /mnt/HDD/virus.txt /mnt/HDD/VirusssReports/virus$(date +"%Y-%m-%d").txt 
sudo clamscan -r / --exclude-dir="/mnt/HDD/Virus/|/mnt/HDD/HACK/|/mnt/HDD/Hack/|/mnt/HDD/MPIhack" | grep FOUND >> /mnt/HDD/virus.txt  | parallel -j128 -Jcluster 
#sudo timeout  300  "sudo clamscan --remove=yes -i -r /  --exclude-dir=/mnt/HDD/Virus/" | parallel -j128 -Jcluster
sudo clamscan --remove=yes -i -r /  --exclude-dir="/mnt/HDD/Virus/|/mnt/HDD/HACK/|/mnt/HDD/Hack/|/mnt/HDD/MPIhack" | parallel -j128 -Jcluster
bash /mnt/HDD/Programs//email-virus-report.sh 

#reboot kernel and linux
#kexec-reboot --reboot
