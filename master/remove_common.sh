#!/bin/bash
echo "starting remove common"
declare -a remove_list

remove_list=(
".amp"
"media-amazon\.com"
"#"
"!!"
"###"
)
pihole --regex -d '(^|.)((yandex|qq|tencent).(net|com|org|dev|io|sh|cn|ru)|qq|local|localhost|query|sl|(^.$))' \
        '(^|.)(jujxeeerdcnm.intranet|w|aolrlgqh.intranet|((.)?)intranet)' '(^|.)(jujxeeerdcnm.ntranet|w|aolrlgqh.ntranet|((.)?)intranet)'
export REGEX_EXCLUDE=`$PROG/grepify.sh ${remove_list[@]}`      # result: key1\| key2\| key3\|
echo $REGEX_EXCLUDE
parallel -j4 --lb echo "{}" :::: \
<(pihole --regex -l | grep --line-buffer "$REGEX_EXCLUDE" | awk '{print $2}') | parallel -P 1 -j 4 --xargs -m --lb --no-run-if-empty pihole --regex -d
#	for arg in `pihole --white-regex -l | grep  --line-buffer "$item" | awk "{print $2}" `; do pihole --white-regex -d "$arg";done
#	for arg in `pihole --regex -l | grep  --line-buffer "$item" | awk "{print $2}" `; do pihole --regex -d "$arg";done
sleep 1.5s
pihole --regex -d "google" "-" "\-" "up" "\.co$" "\.com$" "\.io$" "\.go$" '(.*;querytype=any|.*;querytype=ptr|.*;querytype=rsig|.*;querytype=ds)' \
 "cdn[a-z,1-9]*\.[a-z,1-9]*\.(com|de|net|org|eu)$"  "\#" "\.mn$" "\.ws" "\.nm$"  \
"\.ga$" ".ak$" "\.ka$" "\.us$" "\.ma$" "\.tx$" "\.ca$" "\.ar$" "\.mi$" "\.cu$" "\.de$" "\.to$" "\.la$"  \
"\.pr$" "\.nz$" "\.cd$" "\.fl$" "\.dc$" "\.jp$" "\.uk$" "\.nh" "\.vm$" "\.al$" "\.bk$" "\.fr$" "\.ma" "\.nv$"  \
"\.gr$" "\.or$" "\.wa$"  "\.nb$" "\.hi$" "\.hw$" "\.sw$" "\.kr$" "\.mk$"  "\.sh$" "\.bh$" "\.mx$" "\.us$" \
"\.hr$" "\.fm$" "\.id$" "\.kw$" "net$" "gov$" "com$" "org$" "\.cc$" "^static\." "gov$" "mil$" \
"(^(((([-,_,a-z,1-9]*)\.)*)partner(s?)(\w?((net(z(werk)))*|(prog(gram(m)))*|(link(s))*))([-,_,a-z,1-9]*)\.)((([-,_,a-z,1-9]*)\.)*)(([a-z]*))$)"  \
"(^(((([-,_,a-z,1-9]*)\.)*)ad([-,_,a-z,1-9]*)\.)((([-,_,a-z,1-9]*)\.)*)(([a-z]*))$)" "\.it$" "\.in$" "\.sh$" \
"^(.+[_.-])?amp(project)?\." "\.nato$" "^static\." "suggestqueries.google.com" "^shop((ping)*)\." "\.gov$" "\.me$" \
'cdn[a-z,1-9]*\.[a-z,1-9]*\.(com|de|net|org|eu)$' '\.gl$' '\.cz$' '^([a-z0-9.]+(ads|captive|cloudservices|logs).roku.com$' \
"(^|\.)youtubei\.googleapis\.com$"  "(^|.)geo[-.]?" "^(ad)[a-z,1-9]*\." "media-amazon\.com" "^[a-z]{7,15}$" \
"\.mil$" '\.tv$' '\.tw$' '\.py$' '\.qa$' '\.ss$' '\.mu$' '\.ms$' '\.nc$' '\.mo$' '\.mm$' '\.cat$' \
'\.na$' '\.pw$' '\.ps$' '\.pt$' '\.rw$' '\.kn$' '\.kp$' '\.it$' '^static\.' '(.*;querytype=any|.*;querytype=ptr|.*;querytype=rsig|.*;querytype=ds)' \
'(((\w*)\.)*((\w+[^you](?=tube))|\w*[^you]tube([-,_,a-z,1-9]*))\.((([-,_,a-z,1-9]*)\.)*)(([a-z]*)))' \
'(.+|\.|)doubleclick\.net$' '(^|\.)samsungelectronics\.com$' '(^|\.)samsungcloudsolution\.net$' '(^|\.)samsungcloudsolution\.com$' '(^|\.)samsungcloudcdn\.com$' '(\.|^)()\.com' \
'\.' '^\.$' '$' '^[a-z].([0-9]+|ad[^d]|click|coun(t|ter)|tra[ck](k|ker|king))' '(^|.)((yandex|qq|tencent).(net|com|org|dev|io|sh|cn|ru)|qq|local|localhost|query|sl|(^.$))' \
'([a-z0-9.]{0,4})(.)ad' '([a-z0-9.]{0,4})(.)ad([a-z0-9.]{0,4})[0-9]?' '[a-z0-9](.)?ad[a-z0-9.][0-9]?' 'ad([a-z0-9.]{0,4})'\
'(^|.)((yandex|qq|tencent).(net|com|org|dev|io|sh|cn|ru)|qq|local|localhost|query|sl|(^.$)|cn-geo1.uber.com|metadata.google.internal|((.)?)in-addr.arpa)' \
'(^|.)((yandex|qq|tencent).(net|com|org|dev|io|sh|cn|ru)|qq|local|localhost|query|sl|(^.$))' \
        '(^|.)(jujxeeerdcnm.intranet|w|aolrlgqh.intranet|((.)?)intranet)' \
        '(^|.)(jujxeeerdcnm.ntranet|w|aolrlgqh.ntranet|((.)?)intranet)' \
'(^|\.)(jujxeeerdcnm\.intranet|\w|aolrlgqh\.intranet|((\.)?)intranet|od\.lk|www\.gbnews\.uk|ocdn\.eu|www\.foxtel\.com\.au|gdl\.singbox\.sg|\.sg|socks\.live\.bigo\.sg)' \
        '(^|.)((yandex|qq|tencent).(net|com|org|dev|io|sh|cn|ru)|qq|local|localhost|query|sl|(^.$)|cn-geo1.uber.com|metadata.google.internal|((.)?)in-addr.arpa)' \
'^[a-z]{7,15}$' '^[a-z].([0-9]+|ad[^d]|click|coun(t|ter)|tra[ck](k|ker|king))' 'to'

sleep 1.5s

pihole -b -d appspot.com sc-cdn.net developers.google.com suggestqueries.google.com
sleep 1.5s
pihole -w googlevideo.com appspot.com gvt1.com gvt2.com suggestqueries.google.com www.google.com google.com developers.google.com
sleep 0.5s
pihole -w -d ssl.google-analytics.com app-measurement.com static.doubleclick.net ad.doubleclick.net realtor.com
#pihole -w -d device-metrics-us-2.amazon.com device-metrics-us.amazon.com mads.amazon-adsystem.com s.amazon-adsystem.com app-measurement.com \
#aax-us-east.amazon-adsystem.com ssl.google-analytics.com
sleep 0.5s
#pihole -b aan.amazon-adsystem.com aax-us-pdx.amazon-adsystem.com aax.amazon-adsystem.com app-measurement.com device-metrics-us-2.amazon.com device-metrics-us.amazon.com \
#mads.amazon-adsystem.com s.amazon-adsystem.com aax-us-east.amazon-adsystem.com ssl.google-analytics.com
pihole -b ssl.google-analytics.com app-measurement.com static.doubleclick.net ad.doubleclick.net imasdk.googleapis.com

D='''
sleep 1.5s
RM_LIST="rate-limited-proxy\|googlevideo\|cache.google.com"
echo "starting remove blacklist"
pihole -b -l | grep --line-buffer "$RM_LIST" | awk '{print $2}' | parallel -P 1 -j4 --xargs -m -m --lb --no-run-if-empty pihole -b -d
sleep 1.5s
echo "starting remove whitelist"
pihole -w -l | grep --line-buffer "$RM_LIST" | awk '{print $2}' | parallel -P 1 -j4 --xargs -m --lb \
	--no-run-if-empty pihole -w -d
sleep 1.5s
'''

# https://stackoverflow.com/questions/10346816/using-grep-to-search-for-a-string-that-has-a-dot-in-it
REGEX_REMOVE_COMMON_LIST="(.|^)\|(^|.)\|(.)?\|(^.$)\|(.)"
pihole --regex -l | grep --line-buffer "$REGEX_REMOVE_COMMON_LIST" | awk '{print $2}' | parallel -P 1 -j4 --xargs -m --lb --no-run-if-empty pihole --regex -d
sleep 1.5s
pihole --regex -l | grep --line-buffer "$REGEX_REMOVE_COMMON_LIST" | awk '{print $2}' | parallel -P 1 -j4 --xargs -m --lb --no-run-if-empty pihole --regex -d
sleep 1.5s
pihole --regex -l | grep --line-buffer "$REGEX_REMOVE_COMMON_LIST" | awk '{print $2}' | parallel -P 1 -j4 --xargs -m --lb --no-run-if-empty pihole --regex -d
sleep 1.5s
pihole --regex -l | grep --line-buffer "$REGEX_REMOVE_COMMON_LIST" | awk '{print $2}' | parallel -P 1 -j4 --xargs -m --lb --no-run-if-empty pihole --regex -d
pihole -w playatoms-pa.googleapis.com
