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
export REGEX_EXCLUDE=`$PROG/grepify.sh ${remove_list[@]}`      # result: key1\| key2\| key3\|
echo $REGEX_EXCLUDE
parallel -j4 --lb echo "{}" :::: \
<(pihole --regex -l | grep --line-buffer "$REGEX_EXCLUDE" | awk '{print $2}') | parallel -P 1 -j1 --xargs -m --lb --no-run-if-empty pihole --regex -d
#	for arg in `pihole --white-regex -l | grep  --line-buffer "$item" | awk "{print $2}" `; do pihole --white-regex -d "$arg";done
#	for arg in `pihole --regex -l | grep  --line-buffer "$item" | awk "{print $2}" `; do pihole --regex -d "$arg";done
sleep 1.5s
pihole --regex -d "google" "-" "\-" "up" "\.co$" "\.com$" "\.io$" "\.go$" \
 "cdn[a-z,1-9]*\.[a-z,1-9]*\.(com|de|net|org|eu)$"  "\#" "\.mn$" "\.ws" "\.nm$"  \
"\.ga$" ".ak$" "\.ka$" "\.us$" "\.ma$" "\.tx$" "\.ca$" "\.ar$" "\.mi$" "\.cu$" "\.de$" "\.to$" "\.la$"  \
"\.pr$" "\.nz$" "\.cd$" "\.fl$" "\.dc$" "\.jp$" "\.uk$" "\.nh" "\.vm$" "\.al$" "\.bk$" "\.fr$" "\.ma" "\.nv$"  \
"\.gr$" "\.or$" "\.wa$"  "\.nb$" "\.hi$" "\.hw$" "\.sw$" "\.kr$" "\.mk$"  "\.sh$" "\.bh$" "\.mx$" "\.us$" \
"\.hr$" "\.fm$" "\.id$" "\.kw$" "net$" "gov$" "com$" "org$" "\.cc$" "^static\." "gov$" "mil$" \
"(^(((([-,_,a-z,1-9]*)\.)*)partner(s?)(\w?((net(z(werk)))*|(prog(gram(m)))*|(link(s))*))([-,_,a-z,1-9]*)\.)((([-,_,a-z,1-9]*)\.)*)(([a-z]*))$)"  \
"(^(((([-,_,a-z,1-9]*)\.)*)ad([-,_,a-z,1-9]*)\.)((([-,_,a-z,1-9]*)\.)*)(([a-z]*))$)" "\.it$" "\.in$" "\.sh$" \
"^(.+[_.-])?amp(project)?\." "\.nato$" "^static\." "suggestqueries.google.com" "^shop((ping)*)\." "\.gov$" "\.me$" \
'cdn[a-z,1-9]*\.[a-z,1-9]*\.(com|de|net|org|eu)$' '\.gl$' '\.cz$' \
"(^|\.)youtubei\.googleapis\.com$"  "(^|.)geo[-.]?" "^(ad)[a-z,1-9]*\." "media-amazon\.com" "^[a-z]{7,15}$" \
"\.mil$" '\.tv$' '\.tw$' '\.py$' '\.qa$' '\.ss$' '\.mu$' '\.ms$' '\.nc$' '\.mo$' '\.mm$' '\.cat$' \
'\.na$' '\.pw$' '\.ps$' '\.pt$' '\.rw$' '\.kn$' '\.kp$' '\.it$' '^static\.' \
'(((\w*)\.)*((\w+[^you](?=tube))|\w*[^you]tube([-,_,a-z,1-9]*))\.((([-,_,a-z,1-9]*)\.)*)(([a-z]*)))' \
'(.+|\.|)doubleclick\.net$' '(^|\.)samsungelectronics\.com$' '(^|\.)samsungcloudsolution\.net$' '(^|\.)samsungcloudsolution\.com$' '(^|\.)samsungcloudcdn\.com$' '(\.|^)()\.com' \
'\.' '^\.$' '$' '^[a-z].([0-9]+|ad[^d]|click|coun(t|ter)|tra[ck](k|ker|king))'

sleep 1.5s

pihole -b -d appspot.com sc-cdn.net developers.google.com suggestqueries.google.com
sleep 1.5s
pihole -w googlevideo.com appspot.com gvt1.com gvt2.com suggestqueries.google.com www.google.com google.com developers.google.com
sleep 0.5s
pihole -w -d device-metrics-us-2.amazon.com device-metrics-us.amazon.com mads.amazon-adsystem.com s.amazon-adsystem.com app-measurement.com \
aax-us-east.amazon-adsystem.com ssl.google-analytics.com
sleep 0.5s
pihole -b aan.amazon-adsystem.com aax-us-pdx.amazon-adsystem.com aax.amazon-adsystem.com app-measurement.com device-metrics-us-2.amazon.com device-metrics-us.amazon.com \
mads.amazon-adsystem.com s.amazon-adsystem.com aax-us-east.amazon-adsystem.com ssl.google-analytics.com
sleep 1.5s
echo "starting remove blacklist"
pihole -b -l | grep --line-buffer "rate-limited-proxy\|googlevideo\|cache.google.com" | awk '{print $2}' | parallel -P 1 -j4 --xargs -m -m --lb --no-run-if-empty pihole -b -d && sleep 0.10s
sleep 1.5s
echo "starting remove whitelist"
pihole -w -l | grep --line-buffer "googlevideo" | awk '{print $2}' | parallel -P 1 -j4 --xargs -m --lb --no-run-if-empty pihole -w -d
sleep 1.5s


