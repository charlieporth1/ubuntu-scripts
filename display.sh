#add ip / hostname separated by white space
myHost=
export DISPLAY=:0
# no ping request
COUNT=1

count=$(ping -c $COUNT $myHost | grep 'received' | awk -F',' '{ print $2 }' | awk '{ print $1 }')
if [ $count -eq 0 ]; then
# 100% failed
echo "Host : $myHost is down (ping failed) at $(date)"
else
    firefox $myHost
fi
