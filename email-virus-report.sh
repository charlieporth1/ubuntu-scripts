#bash
#uuencode /mnt/HDD/virus.txt | sendemail -f ServerVirusReport@gmail.com -t charlieporth1@gmail.com -u subject -m "Virus Report from server" -s smtp.gmail.com:587 -o tls=yes -xu chtiporth@gmail.com -xp sciencerocks 
# echo Virus Report | mutt -s Virus Report from server -a /mnt/HDD/virus.txt -- charlieporth1@gmail.com
. /usr/bin/cred.sh
if [[ $HOSTNAME == "tegra-ubuntu" ]] ;then
sendemail -f $USER@otih-oith.us.to -t $email -m "Virus Report from server: $HOSTNAME" -a  /mnt/HDD/virus.txt -s smtp.gmail.com:587 -o tls=yes -xu $usr -xp $passwd
#sendemail -f $USER@otih-oith.us.to -t $phonee  -m "Virus Report from server" -a  /mnt/HDD/virus.txt -s smtp.gmail.com:587 -o tls=yes -xu $usr  -xp  $passwd
curl -fsS --retry 3 https://hc-ping.com/c27c4ea1-0e4e-47e0-984a-49ad555b5a0b
else 
sendemail -f $USER@otih-oith.us.to -t $email -m "Virus Report from server: $HOSTNAME" -a  /home/*/virus.txt -s smtp.gmail.com:587 -o tls=yes -xu $usr -xp $passwd
curl -fsS --retry 3 https://hc-ping.com/f05ad477-787d-4cea-ab22-11d2ef52329e
fi
echo done
