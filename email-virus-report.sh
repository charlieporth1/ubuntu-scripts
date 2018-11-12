#bash
#uuencode /mnt/HDD/virus.txt | sendemail -f ServerVirusReport@gmail.com -t charlieporth1@gmail.com -u subject -m "Virus Report from server" -s smtp.gmail.com:587 -o tls=yes -xu chtiporth@gmail.com -xp sciencerocks 
# echo Virus Report | mutt -s Virus Report from server -a /mnt/HDD/virus.txt -- charlieporth1@gmail.com
. /usr/bin/cred.sh
sendemail -f $USER@otih-oith.us.to -t $email -m "Virus Report from server $HOSTNAME" -a  /mnt/HDD/virus.txt -s smtp.gmail.com:587 -o tls=yes -xu $usr -xp $passwd
sendemail -f $USER@otih-oith.us.to -t $email -m "Virus Report from server $HOSTNAME" -a  /home/*/virus.txt -s smtp.gmail.com:587 -o tls=yes -xu $usr -xp $passwd
sendemail -f $USER@otih-oith.us.to -t $phonee  -m "Virus Report from server" -a  /mnt/HDD/virus.txt -s smtp.gmail.com:587 -o tls=yes -xu $usr  -xp  $passwd
echo done
