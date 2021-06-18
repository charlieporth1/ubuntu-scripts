#!/bin/bash

TIMEOUT=3
TRIES=2

declare -a SMALL_DOMAINS_LIST
SMALL_DOMAINS_LIST=(
	dns.ctptech.dev
	master.dns.ctptech.dev
	vpn.ctptech.dev
	www.ctptech.dev
	ctptech.dev
	www.google.com
	android.googleapis.com
	cdn-content.ampproject.org
	3p.ampproject.net
	cdn.ampproject.org
	ssl.gstatic.com
	www.gstatic.com
	fonts.gstatic.com
	messages.google.com
	youtube.com
	tv.youtube.com
	assistant.google.com
	assistant.googleapis.com
	music.youtube.com
	apis.google.com
	cdn.optimizely.com
	ogs.google.com
	ajax.googleapis.com
	fonts.gstatic.com
	aa.google.com
	recaptcha.net
	cdnjs.cloudflare.com
	stackpath.bootstrapcdn.com
	fonts.googleapis.com
	safebrowsing.googleapis.com
	r3.o.lencr.org
	gstaticadssl.l.google.com
	maxcdn.bootstrapcdn.com
	mail.google.com
	gravatar.com
	www.gravatar.com
)
declare -a GOOGLE
GOOGLE=(
	l.google.com
	chat.google.com
	inbox.google.com
	mail.google.com
	suggestqueries.l.google.com
	suggestqueries.google.com
	android.clients.google.com
	drive.google.com
	domains.google.com
	clients4.google.com
	sb-ssl.google.com
	clients2.google.com
	clients3.google.com
	messages.google.com
	cloudconsole-pa.clients6.google.com
	ssh.cloud.google.com
	chat-pa.clients6.google.com
	duo.google.com
	android.clients.google.com
	www3.l.google.com
	myaccount.google.com
	chrome.google.com
	sb.l.google.com
	clients.l.google.com
	instantmessaging-pa.googleapis.com
	android.l.google.com
	docs.google.com
	calendar.google.com
	accounts.google.com
	play.google.com
	photos.google.com
)
declare -a GOOGLEAPIS
GOOGLEAPIS=(
	www.googleapis.com
	play.googleapis.com
	android.googleapis.com
	embeddedassistant.googleapis.com
	androidtvlauncherxfe-pa.googleapis.com
	fcm.googleapis.com
	cryptauthenrollment.googleapis.com
	clientservices.googleapis.com
	playatoms-pa.googleapis.com
	chromesyncpasswords-pa.googleapis.co
	oauthaccountmanager.googleapis.com
	fcmconnection.googleapis.com
	oauthaccountmanager.googleapis.com
	embeddedassistant.googleapis.com
	android.googleapis.com
	clientservices.googleapis.com
	telephonyspamprotect-pa.googleapis.com
	instantmessaging-pa.googleapis.com
	myphonenumbers-pa.googleapis.com
	notifications-pa.googleapis.com
	peoplestack-pa.googleapis.com
	telephonyspamprotect-pa.googleapis.com
	androidwearcloudsync-pa.googleapis.com
	content-autofill.googleapis.com
	discover-pa.googleapis.com
	people-pa.googleapis.com
	firebaseinstallations.googleapis.com
	play.googleapis.com
)

declare -a BLOCK_DOMAINS
BLOCK_DOMAINS=(
	app-measurement.com
	googleads.g.doubleclick.net
	www.googleadservices.com
	ssl.google-analytics.com
)

declare -a OTHER_GOOGLE
OTHER_GOOGLE=(
	mail-attachment.googleusercontent.com
	yt3.ggpht.com
	yt1.ggpht.com
	yt2.ggpht.com
	yt.ggpht.com
	photos-ugc.l.googleusercontent.com
	googlehosted.l.googleusercontent.com
	lh3.googleusercontent.com
	play-lh.googleusercontent.com
	www.googleoptimize.com
	www.recaptcha.net
	cdn3.optimizely.com
	cdn2.optimizely.com
	cdn1.optimizely.com
	i.ytimg.com
	i2.ytimg.com
	i3.ytimg.com
	i4.ytimg.com
	s.youtube.com
	encrypted-tbn0.gstatic.com
	www.gstatic.com
	ssl.gstatic.com
	dns.google
	cdn-content.ampproject.org
	gmail.com
	www.gmail.com
)

declare -a EXTRA_DOMAINS_LIST
EXTRA_DOMAINS_LIST=(
	${OTHER_GOOGLE[@]}
	${BLOCK_DOMAINS[@]}
	${GOOGLEAPIS[@]}
	${GOOGLE[@]}
	gcp.ctptech.dev
	aws.ctptech.dev
	home.ctptech.dev
	ace.ctptech.dev
	tv.ctptech.dev
	www.gravatar.com
	ajax.aspnetcdn.com
	ajax.cloudflare.com
	cdnjs.cloudflare.com
	www.linkedin.com
	contacts.zoho.com
	downloads.zohocdn.com
	slack-imgs.com
	jsdelivr.net
	ca.slack-edge.com
	cdn.sstatic.net
	app.snapchat.com
	github.com
	www.github.com
	slack.com
	www.figma.com
	edgeapi.slack.com
	adguard.dns
	one.one.one.one
	cf-st.sc-cdn.net
	gcp.api.snapchat.com
	us-central1-gcp.api.snapchat.com
	stackoverflow.com
	js.zohocdn.com
	css.zohocdn.com
	facebook.com
	apple.com
	twitter.com
	fbi.gov
	cia.gov
	nsa.gov
	stackoverflow.com
)

INTERFACE_COUNT=`ifconfig | grep -o 'lo[0-9]' | grep -o '[0-9]' | sort -r | sed -n '1p'`

if [[ "$INTERFACE_COUNT" != "8" ]] && [[ -n "$INTERFACE_COUNT" ]]; then
	echo "INTERFACE_COUNT :: $INTERFACE_COUNT != 8"
	echo "Interface not counted"
	set -e
	exit 1
fi
counterForInterfaceCycling=0
function COUNTER() {
	declare -g counterForInterfaceCycling=$(( $counterForInterfaceCycling + 1 ))
	if [[ $counterForInterfaceCycling -ge $INTERFACE_COUNT ]]; then
		declare -g counterForInterfaceCycling=0
	fi
	echo $counterForInterfaceCycling
}
function INIT_POP_TEST_FULL() {
	[[ "$1" == "SMALL" ]] && local SMALL=true || local SMALL=false
	dig www.google.com @pihole.local +timeout=$TIMEOUT +tries=$TRIES +dnssec > /dev/null 2>&1
	local WITH_LIST1=`[[ $SMALL == false ]] && echo ${EXTRA_DOMAINS_LIST[@]} || echo ''`
	declare -a DOMAINS=(
		${SMALL_DOMAINS_LIST[@]}
		$WITH_LIST1
	)
	echo ${#SMALL_DOMAINS_LIST[@]}
	echo ${#EXTRA_DOMAINS_LIST[@]}
	echo ${#DOMAINS[@]}
	local interval=8
	for c in `seq 0 $interval ${#DOMAINS[@]}`
	do
	(
			local i=`COUNTER`
			local e=$(($c+$interval))
		dig ${DOMAINS[@]:$c:$e} @pihole$i.local +timeout=$TIMEOUT +tries=$TRIES +dnssec
	)&>/dev/null
	done
}
export -f INIT_POP_TEST_FULL

function INIT_POP_TEST() {
	dig www.google.com @pihole.local +timeout=$TIMEOUT +tries=$TIRES +dnssec > /dev/null 2>&1
	dig www.google.com @pihole.local +timeout=3 +tries=2 +dnssec > /dev/null 2>1
}
export -f INIT_POP_TEST

function FILL_LOG() {
	INIT_POP_TEST_FULL
	echo "FILED LOG"
}
export -f FILL_LOG

function FILL_HOLE() {
	FILL_LOG
}
export -f FILL_HOLE

function INIT_TEST() {
	INIT_POP_TEST
}
export -f INIT_TEST

function INIT_TEST_SMALL() {
	INIT_POP_TEST_FULL SMALL
}
export -f INIT_TEST_SMALL

function INIT_TEST_BIG() {
	INIT_POP_TEST_FULL
}
export -f INIT_TEST_BIG

