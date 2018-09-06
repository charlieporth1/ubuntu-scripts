#Matanice 
sudo npm cache clean --force
bleachbit --list | grep -E "[a-z]+\.[a-z]+" | xargs bleachbit --clean
sudo /home/*Programs/Cleanup.sh
#sudo bash /mnt/HDD/Programs//Bash-History-Clear-first-part-forloop.sh
sudo bash /home/*/Programs//pipfix.sh 

#Updates 
sudo bash /mnt/HDD/Programs/update.sh
sudo bash /mnt/HDD/cockpit/updatcock.sh

#copy to master node
scp /home/*/Programs/* ubuntu@192.168.1.250:/mnt/HDD/Programs/serverbashandcron/


#AV
sudo freshclam
sudo mv /home/*/virus.txt /home/*/VirusssReports/virus$(date +"%Y-%m-%d").txt
sudo clamscan -r / --exclude-dir="/mnt/HDD/Virus/|/mnt/HDD/HACK/|/mnt/HDD/Hack/|/mnt/HDD/MPIhack" | grep FOUND >> /mnt/HDD/virus.txt 
#sudo timeout  300  "sudo clamscan --remove=yes -i -r /  --exclude-dir=/mnt/HDD/Virus/"
sudo clamscan --remove=yes -i -r /  --exclude-dir="/mnt/HDD/Virus/|/mnt/HDD/HACK/|/mnt/HDD/Hack/|/mnt/HDD/MPIhack"
bash /home/*/Programs//email-virus-report.sh 

sleep 100
sudo reboot
