#!/usr/bin/parallel --shebang-wrap --pipe /bin/bash
#weekly
#backup
sudo rm -rf /mnt/HDD/Backup/Website/Weekly/www.zip
sudo zip -r9 /mnt/HDD/Backup/Website/Weekly/www.zip /var/www/*
sudo echo 3 > /proc/sys/vm/drop_caches
sudo rm -rf /mnt/HDD/Backup/usrbin/.zip
sudo zip -r9 /mnt/HDD/Backup/usrbin.zip  /usr/bin 
sudo echo 3 > /proc/sys/vm/drop_caches
sudo rm -rf /mnt/HDD/Backup/usrlocale.zip
sudo zip -r9 /mnt/HDD/Backup/usrlocale.zip  /usr/locale &
sudo echo 3 > /proc/sys/vm/drop_caches
sudo rm -rf /mnt/HDD/Backup/usrshare.zip
sudo zip -r9 /mnt/HDD/Backup/usrshare.zip  /usr/share &
sudo echo 3 > /proc/sys/vm/drop_caches
sudo rm -rf /mnt/HDD/Backup/usrsrc.zip
sudo zip -r9 /mnt/HDD/Backup/usrsrc.zip  /usr/src &
sudo echo 3 > /proc/sys/vm/drop_caches
sudo rm -rf /mnt/HDD/Backup/usrgames.zip
sudo zip -r9 /mnt/HDD/Backup/usrgames.zip  /usr/games &
sudo echo 3 > /proc/sys/vm/drop_caches
sudo rm -rf /mnt/HDD/Backup/usrinclude.zip
sudo zip -r9 /mnt/HDD/Backup/usrinclude.zip  /usr/include &
sudo echo 3 > /proc/sys/vm/drop_caches
sudo rm -rf /mnt/HDD/Backup/usrbin.zip
sudo zip -r9 /mnt/HDD/Backup/usrsbin.zip  /usr/sbin &
sudo echo 3 > /proc/sys/vm/drop_caches
sudo rm -rf /mnt/HDD/Backup/usrlib.zip
sudo zip -r9 /mnt/HDD/Backup/usrlib.zip  /usr/lib &
sudo echo 3 > /proc/sys/vm/drop_caches
sudo rm -rf /mnt/HDD/Backup/usrlocal.zip
sudo zip -r9 /mnt/HDD/Backup/usrlocal.zip /usr/local/ &
sudo cp /home/ubuntu/.bashrc /mnt/HDD/Backup/ 
sudo echo 3 > /proc/sys/vm/drop_caches



#sudo rm -r /mnt/HDD/HACK/*
#cd /mnt/HDD/HACK
#sudo git clone https://github.com/hak5/bashbunny-payloads.git
#sudo git clone https://github.com/offensive-security/exploit-database.git
#sudo git clone https://github.com/offensive-security/exploit-database-papers.git
#sudo git clone git@github.com:offensive-security/exploit-database-bin-sploits.git

echo done with that

#GitAutoUpdate
#sudo gdrive update -r -p 1sscS0H_MzZP9nvBMQ3cUpoIug5aNDDCY /mnt/HDD/HACK
sudo bash /mnt/HDD/Programs/GitChangedWeekly.sh

#Matanice 
sudo npm cache clean --force
bleachbit --list | grep -E "[a-z]+\.[a-z]+" | xargs bleachbit --clean
sudo /mnt/HDD/Programs/Cleanup.sh
#sudo bash /mnt/HDD/Programs//Bash-History-Clear-first-part-forloop.sh
sudo bash /mnt/HDD/Programs//pipfix.sh 

#Updates 
sudo bash /mnt/HDD/Programs/update.sh

#AV
sudo freshclam
sudo mv /mnt/HDD/virus.txt /mnt/HDD/VirusssReports/virus$(date +"%Y-%m-%d").txt
sudo clamscan -r / --exclude-dir="/mnt/HDD/Virus/|/mnt/HDD/HACK/|/mnt/HDD/Hack/|/mnt/HDD/MPIhack" | grep FOUND >> /mnt/HDD/virus.txt 
#sudo timeout  300  "sudo clamscan --remove=yes -i -r /  --exclude-dir=/mnt/HDD/Virus/"
sudo clamscan --remove=yes -i -r /  --exclude-dir="/mnt/HDD/Virus/|/mnt/HDD/HACK/|/mnt/HDD/Hack/|/mnt/HDD/MPIhack"
bash /mnt/HDD/Programs//email-virus-report.sh 
