#!/bin/bash
chmod +x /home/charlieporth1_gmail_com/Programs/*.{sh,bash,py,rb,bin,go}
chmod 777 $PROG/*.{sh,bash,py,perl}
declare -a FILES
FILES=(
"$PROG/alert_user.sh"
"$PROG/phoneone.sh"
"$PROG/date-compare.sh"
)
#everyone exe ro root
export USER=charlieporth1_gmail_com
for FILE in ${FILES[@]}
do
	sudo chown $USER:everyone $FILE
	chmod g=x $FILE
	chmod u=rw $FILE
done
#ROOT ONLY
declare -a FILE_ROOT_ONLY
FILE_ROOT_ONLY=(
	"$PROG/pihole-db-sql-changes.sh"
	"$PROG/remove-all-yt-ad-urls.sh"
	"$PROG/pm.stale-dns-chck.sh"
	"$PROG/port-listener.sh"
	"$PROG/remove_common.sh"
	"$PROG/pihole-backup.sh"
	"$PROG/blocklist-updater,sh"
	"$PROG/allow-youtube-but-not-youtube-ads.sh"
	"$PROG/.allow-youtube.env.sh"
	"$PROG/block-yt-regex.sh"
	"$PROG/youtube-ads.sh"
	"$PROG/white-regex-yt.sh"
	"$PROG/make_redirect_shorter.sh"
	"$PROG/cert_manager.sh"
	"$PROG/add_interface.sh"
	"$PROG/domains_filter.sh"
	"$PROG/dblock.sh"
	"$PROG/dns-stale-restart.sh"
	"$HOLE/youtube_regex_urls.txt"
)
for FILE in ${FILE_ROOT_ONLY[@]}
do
	sudo chown $USER:everyone $FILE
	chmod g=x $FILE
	chmod u=rw $FILE
done
# SERVICES
sudo chmod 0644 $PROG/*.service
sudo chmod 0644 /etc/systemd/system/*.service
DEFAULT_HOME=${ADMIN_HOME:-/home/charlieporth1_gmail_com}
touch $DEFAULT_HOME/.ssh/authorized_keys
#chmod g-w $DEFAULT_HOME
chmod -R 700 $DEFAULT_HOME/.ssh
chmod 600 $DEFAULT_HOME/.ssh/authorized_keys
sudo chmod 777 $DEFAULT_HOME/ble.sh/out/ble.sh
#find $DEFAULT_HOME -type d -print0 | xargs -0 chmod 0775
#find $DEFAULT_HOME -type f -print0 | xargs -0 chmod 0664
#sudo find $DEFAULT_HOME -type f -exec chmod 0664 {} +
#sudo find $DEFAULT_HOME -type d -exec chmod 0775 {} +
rm -f /dev/null; mknod -m 666 /dev/null c 1 3

CHALLENGE_DIR=$WWW/.well-known/{acme-challenge,pki-validation}
rm -rf $CHALLENGE_DIR
mkdir -p $CHALLENGE_DIR
