#Matanice 
sudo npm cache clean --force
bleachbit --list | grep -E "[a-z]+\.[a-z]+" | xargs bleachbit --clean
sudo /home/*/Programs/Cleanup.sh
#sudo bash /mnt/HDD/Programs//Bash-History-Clear-first-part-forloop.sh

sudo bash /home/*/Programs//pipfix.sh 

#Updates 
if [-f /var/lib/dpkg/lock ]; then
sudo rm -rf /var/lib/dpkg/lock
sudo rm -rf  /var/cache//apt/archives/lock 
fi
sudo bash /home/*/Programs/update.sh
sudo bash /home/*/cockpit/updatcock.sh
sudo bash /home/*/Programs/installnewserver.sh
sudo geoipupdate

#copy from master node
#scp /home/*/Programs/* ubuntu@192.168.1.250:/mnt/HDD/Programs/serverbashandcron/
sudo cp -rf /home/*/Programs/phoneone.sh /opt/
sudo cp -rf /home/*/Programs/serveronline.sh /opt/
sudo cp -rf /home/*/Programs/rc.local /etc/rc.local
sudo cp -rf /home/*/Programs/cred.x /usr/sbin/
sudo cp -rf /home/*/Programs/cred.sh /usr/bin/
sudo chmod 777 /opt/phoneone.sh
sudo chmod 777 /opt/serveronline.sh
sudo chmod 777 /etc/rc.local
sudo chmod 777 /usr/sbin/cred.x
sudo chmod 777 /usr/bin/cred.sh

#AV
sudo freshclam
mkdir /home/*/VirusssReports/
sudo mv /home/*/virus.txt /home/*/VirusssReports/virus$(date +"%Y-%m-%d").txt
sudo clamscan -r /  | grep FOUND >> /home/*/virus.txt 
#sudo timeout  300  "sudo clamscan --remove=yes -i -r /  --exclude-dir=/mnt/HDD/Virus/"
sudo clamscan --remove=yes -i -r /  
bash /home/*/Programs//email-virus-report.sh 

sleep 100
sudo reboot
