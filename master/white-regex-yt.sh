#!/bin/bash
# pihole -q r5.sn-uhvcpax0n5-vgql.googlevideo.com
#cat $HOLE/youtube_regex_urls.txt | parallel --colsep '\n' --lb --xargs -j1 -m pihole --white-regex
#parallel -j16 echo "{}" :::: $HOLE/youtube_regex_urls.txt | parallel -j1 --colsep "\n" --xargs -m --lb --no-run-if-empty pihole --white-regex
[[ "$ENV" == "PROD" ]] && REDIRECT=/dev/null || REDIRECT=/dev/stdout
(
	source /etc/profile.d/bash-exports-global.sh
	source /etc/environment
	HOLE=/etc/pihole
	[[ -f $PROG/dblock.sh ]] && bash $PROG/dblock.sh
	cat $HOLE/youtube_regex_urls.txt | parallel --lb --xargs -j4 -P1 -m pihole --white-regex
#	bash $PROG/make_redirect_shorter.sh "REMOVE"
	cat $HOLE/youtube_regex_urls.txt | parallel --lb --xargs -j1 -m pihole --regex -d > /dev/null


	pihole -b -d youtubei.googleapis.com


	pihole -w youtube-ui.l.google.com manifest.googlevideo.com redirector.googlevideo.com \
	p47-buy.itunes-apple.com.akadns.net a1818.dscg2.akamai.net suggestqueries.google.com \
	appspot.com photos-ugc.l.googleusercontent.com \
        growth-pa.googleapis.com youtubei.googleapis.com people-pa.googleapis.com geller-pa.googleapis.com \
	gstatic.com youtube.com tv.youtube.com music.youtube.com gstaticadssl.l.google.com

	pihole -b -d youtube-ui.l.google.com manifest.googlevideo.com redirector.googlevideo.com youtubei.googleapis.com geller-pa.googleapis.com youtubei.googleapis.com
	pihole --white-regex -d '^r([0-9]{1,2})---sn-([a-z0-9\-_\.]{4,22})(|-[a-z0-9]{2,6})\.googlevideo\.com$' \
       		'^r([0-9]{1,2})\.sn-([a-z0-9\-_\.]{4,22})(|-[a-z0-9]{2,6})\.googlevideo\.com$' \
        	'^r([0-9]{1,2})\.sn-([a-za-z0-9\.-]{4,28})\.googlevideo\.com$' \
        	'^r([0-9]{1,2})---sn-([a-za-z0-9\.-]{4,28})\.googlevideo\.com$'

#	 (pihole restartdns reload-lists)&
)&>$REDIRECT
#>/dev/null
#(
#   source $PROG/populae-log.sh
#                        FILL_HOLE
#)&
