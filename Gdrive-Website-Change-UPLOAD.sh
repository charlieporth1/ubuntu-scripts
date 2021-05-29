
DIR_TO_CHECK='/var/www/*'

OLD_STAT_FILE='/home/ubuntu/old_stat.txt'
 
if [ -e $OLD_STAT_FILE ]
then
        OLD_STAT=`cat $OLD_STAT_FILE`
echo files didnt change
else
        OLD_STAT="nothing"
fi
 
NEW_STAT=`stat -t $DIR_TO_CHECK`
 
if [ "$OLD_STAT" != "$NEW_STAT" ]

then
        echo 'Directory has changed. Do something!'
        # do whatever you want to do with the directory.
        # update the OLD_STAT_FILE
        echo $NEW_STAT > $OLD_STAT_FILE
       

#gdrive update -r -p 0ByHcdvstAy65cS04bXlFX3h5d3c /var/www/
sudo rclone delete -v Gdrive:www
sudo rclone copy -v /var/www/ Gdrive:www
fi
