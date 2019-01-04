#!/usr/bin/parallel --shebang-wrap --pipe /bin/bash
#weekly
#other server 
#sudo bash /mnt/HDD/Programs/copy-to-new-server.sh
#sudo systemctl enable rc-local
#this is used for low memory devices
curl -fsS --retry 3 https://hc-ping.com/18542605-64ed-400a-b3ff-e2845da0d44e
export back=/mnt/HDD/Backup/
export hdd=/mnt/HDD/
export prog=/mnt/HDD/Programs
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
#backup
sudo rm -rf $back/Website/Weekly/www.zip | parallel -Jcluster
sudo zip -r9 $back/Website/Weekly/www.zip /var/www/* | parallel -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
sudo rm -rf $back/usrbin/.zip | parallel -Jcluster
sudo zip -r9 $back/usrbin.zip  /usr/bin  | parallel -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
sudo rm -rf $back/usrlocale.zip  | parallel -Jcluster
sudo zip -r9 $back/usrlocale.zip  /usr/locale & | parallel -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
sudo rm -rf $back/usrshare.zip | parallel -Jcluster
sudo zip -r9 $back/usrshare.zip  /usr/share & | parallel -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
sudo rm -rf $back/usrsrc.zip | parallel -Jcluster
sudo zip -r9 $back/usrsrc.zip  /usr/src & | parallel -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
sudo rm -rf $back/usrgames.zip | parallel -Jcluster
sudo zip -r9 $back/usrgames.zip  /usr/games & | parallel -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
sudo rm -rf $back/usrinclude.zip | parallel -Jcluster
sudo zip -r9 $back/usrinclude.zip  /usr/include & | parallel -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
sudo rm -rf  $hack/usrbin.zip | parallel -Jcluster
sudo zip -r9 $back/usrsbin.zip  /usr/sbin & | parallel -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
sudo rm -rf $back/usrlib.zip | parallel -Jcluster
sudo zip -r9 $back/usrlib.zip  /usr/lib & | parallel -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
sudo rm -rf $back/usrlocal.zip | parallel -Jcluster
sudo zip -rf $back/usrlocal.zip /usr/local/ & | parallel -Jcluster
sudo cp -rf /home/ubuntu/.bash* $back  
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
sudo cp -rf /home/ubuntu/.bash* /mnt/HDD/Programs/   



#sudo rm -r /mnt/HDD/HACK/*
#cd /mnt/HDD/HACK
#sudo git clone https://github.com/hak5/bashbunny-payloads.git
#sudo git clone https://github.com/offensive-security/exploit-database.git
#sudo git clone https://github.com/offensive-security/exploit-database-papers.git
#sudo git clone git@github.com:offensive-security/exploit-database-bin-sploits.git
#emails
sudo cp -rf /opt/*.sh $prog
#sudo bash /mnt/HDD/Programs/email-virus-report.sh
sudo bash $prog/copy-to-new-server.sh
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
cp -rf /usr/bin/mikrotik $prog

echo done with that
#GitAutoUpdate
#sudo gdrive update -r -p 1sscS0H_MzZP9nvBMQ3cUpoIug5aNDDCY /mnt/HDD/HACK
#sudo bash /mnt/HDD/Programs/GitChangedWeekly.sh
sudo bash $prog/GitChangedWeekly-better.sh
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
sudo bash /mnt/HDD/cockpit/updatecock.sh
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
sudo bash $prog/toGithub.sh
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
sudo bash $prog/Gdrive-Website-Change-UPLOAD-best.sh
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
cd /mnt/HDD/HACK && sudo bash $prog/gitUpdateRecurive.sh 
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches

#Matanice 
sudo freshclam
sudo npm cache clean --force | parallel -Jcluster
bleachbit --list | grep -E "[a-z]+\.[a-z]+" | xargs bleachbit --clean | parallel -Jcluster
sudo $prog/Cleanup.sh | parallel -Jcluster
sudo geoipupdate
#sudo bash /mnt/HDD/Programs//Bash-History-Clear-first-part-forloop.sh
#sudo /etc/init.d/nscd reload    # nscd
sudo bash /mnt/HDD/Programs//pipfix.sh | parallel -Jcluster
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches

#Updates 
sudo bash $prog//update.sh 

sudo ntpdate -u 192.168.1.200
sudo timedatectl set-ntp on

#AV
sudo freshclam | parallel -Jcluster
sudo mv /mnt/HDD/virus.txt /mnt/HDD/VirusssReports/virus$(date +"%Y-%m-%d").txt 
sudo clamscan -r / --exclude-dir="/mnt/HDD/Virus/|/mnt/HDD/HACK/|/mnt/HDD/Hack/|/mnt/HDD/MPIhack" | grep FOUND >> /mnt/HDD/virus.txt  | parallel -Jcluster 
#sudo timeout  300  "sudo clamscan --remove=yes -i -r /  --exclude-dir=/mnt/HDD/Virus/" | parallel -Jcluster
sudo clamscan --remove=yes -i -r /  --exclude-dir="/mnt/HDD/Virus/|/mnt/HDD/HACK/|/mnt/HDD/Hack/|/mnt/HDD/MPIhack" | parallel -Jcluster
bash /mnt/HDD/Programs/email-virus-report.sh 
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches

#reboot kernel and linux
#kexec-reboot --reboot
curl -fsS --retry 3 https://hc-ping.com/ab2fe292-6e5b-4f3b-adfb-319a5e08fa45

sudo reboot
