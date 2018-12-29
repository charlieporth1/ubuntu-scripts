
sudo zip -r9 /mnt/HDD/Backup/Website/Hourly/www.zip /var/www/* | parallel -j128 -Jcluster --verbose
