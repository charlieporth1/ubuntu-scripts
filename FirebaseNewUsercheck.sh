if [ -f  /mnt/HDD/StartupPrivate/accounts-new.csv  ]; then
mv  /mnt/HDD/StartupPrivate/accounts-new.csv /mnt/HDD/StartupPrivate/accounts-old.csv
fi
sleep 10
 firebase auth:export --project   studioso-6b7f3 /mnt/HDD/StartupPrivate/accounts-new.csv --format=csv 
if [ -f  /mnt/HDD/StartupPrivate/change.csv  ]; then
rm -rf  /mnt/HDD/StartupPrivate/change.csv
fi
sleep 10
daff --output /mnt/HDD/StartupPrivate/change.csv /mnt/HDD/StartupPrivate/mnt/HDD/StartupPrivate/accounts-old.csv /mnt/HDD/StartupPrivate/accounts-new.csv 
sleep 3
#sendemail -f $USER@otih-oith.us.to -t o.salazar@studiosoapp.com -m "New user report from server" -a  /mnt/HDD/StartupPrivate/change.csv -s smtp.gmail.com:587 -o tls=yes -xu chtiporth@gmail.com -xp sciencerocks
