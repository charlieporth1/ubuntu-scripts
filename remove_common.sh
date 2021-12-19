#!/bin/bash
echo "starting remove common"
source $PROG/all-scripts-exports.sh
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
<(pihole --regex -l | grep --line-buffer "$REGEX_EXCLUDE" | awk '{print $2}') | parallel -P 1 -j 4 --xargs -m --lb --no-run-if-empty pihole --regex -d
#	for arg in `pihole --white-regex -l | grep  --line-buffer "$item" | awk "{print $2}" `; do pihole --white-regex -d "$arg";done
#	for arg in `pihole --regex -l | grep  --line-buffer "$item" | awk "{print $2}" `; do pihole --regex -d "$arg";done
sleep 1.5s
ccat $HOLE/blacklist.regex.remove | parallel $parallel_args_pihole pihole --regex -d
sleep 1.5s

ccat $HOLE/blacklist.list.remove | parallel $parallel_args_pihole pihole -b -d
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

:'
sleep 1.5s
RM_LIST="rate-limited-proxy\|googlevideo\|cache.google.com"
echo "starting remove blacklist"
pihole -b -l | grep --line-buffer "$RM_LIST" | awk '{print $2}' | parallel -P 1 -j4 --xargs -m -m --lb --no-run-if-empty pihole -b -d
sleep 1.5s
echo "starting remove whitelist"
pihole -w -l | grep --line-buffer "$RM_LIST" | awk '{print $2}' | parallel -P 1 -j4 --xargs -m --lb \
	--no-run-if-empty pihole -w -d
sleep 1.5s
'

# https://stackoverflow.com/questions/10346816/using-grep-to-search-for-a-string-that-has-a-dot-in-it
REGEX_REMOVE_COMMON_LIST="(.|^)\|(^|.)\|(.)?\|(^.$)\|(.)"
pihole --regex -l | grep --line-buffer "$REGEX_REMOVE_COMMON_LIST" | awk '{print $2}' | parallel $parallel_args_pihole pihole --regex -d
sleep 1.5s
pihole --regex -l | grep --line-buffer "$REGEX_REMOVE_COMMON_LIST" | awk '{print $2}' | parallel $parallel_args_pihole pihole --regex -d
sleep 1.5s
pihole --regex -l | grep --line-buffer "$REGEX_REMOVE_COMMON_LIST" | awk '{print $2}' | parallel $parallel_args_pihole pihole --regex -d
sleep 1.5s
pihole --regex -l | grep --line-buffer "$REGEX_REMOVE_COMMON_LIST" | awk '{print $2}' | parallel $parallel_args_pihole pihole --regex -d
sleep 1.5s

pihole -w playatoms-pa.googleapis.com
