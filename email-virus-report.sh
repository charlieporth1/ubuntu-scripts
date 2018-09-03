#bash
#uuencode /mnt/HDD/virus.txt | sendemail -f ServerVirusReport@gmail.com -t charlieporth1@gmail.com -u subject -m "Virus Report from server" -s smtp.gmail.com:587 -o tls=yes -xu chtiporth@gmail.com -xp sciencerocks 
# echo Virus Report | mutt -s Virus Report from server -a /mnt/HDD/virus.txt -- charlieporth1@gmail.com
sendemail -f $USER@otih-oith.us.to -t charlieporth1@gmail.com -m "Virus Report from server" -a  /mnt/HDD/virus.txt -s smtp.gmail.com:587 -o tls=yes -xu chtiporth@gmail.com -xp sciencerocks 
#sendemail -f $USER@otih-oith.us.to -t 19523341587@txt.att.net -m "Virus Report from server" -a  /mnt/HDD/virus.txt -s smtp.gmail.com:587 -o tls=yes -xu chtiporth@gmail.com -xp sciencerocks 
sendemail -f $USER@otih-oith.us.to -t 9523341587@mms.att.net  -m "Virus Report from server" -a  /mnt/HDD/virus.txt -s smtp.gmail.com:587 -o tls=yes -xu chtiporth@gmail.com -xp sciencerocks 
echo done
