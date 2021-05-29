################################################################################
# This is a crontab example for otih-oith.us.to - (uid: charlieporth1)
# Generated 2018-06-20 14:58:27 PST @ http://freedns.afraid.org/
################################################################################
# NOTES:
# * Works on Mac/Linux/*BSD/*NIX type systems
# * Updates automatically each 5 minutes
#
# INSTRUCTIONS:
# 1) To install, goto a system console, then type: 'crontab -e' (without 
#      apostrophe's) then paste the bottom last line/entry from this file (all
#      on 1 line) and then save
# 2) To list installed crontabs (verifying installation), type: 'crontab -l'
# 3) To verify updates are occuring, wait 5 minutes, then 'cat /tmp/freedns_otih-oith_us_to.log'
# 4) To read more about how crontab works, check out 'man -a crontab' or search 
#      the web for 'installing a crontab' or 'cron' (same thing)
# 
# SOME THOUGHTS:
# - This example is for simplicity, and ultra compatibility
# - I urge you to make updates only when a IP change occurs if you know how 
#      (such as on ifup), or by polling your router status/snmp device first.
#      I wrote a client/daemon 'lastip2.phps' listed on the clients page that 
#      can pull a router status page - however it requires some skill and
#      knowledge of your particular network to set it up properly
# - This below generated example avoids updates when seconds is between :55
#      and :05 to prevent a thundering herd of updates at the minute
# - PATH line may optional, or not! Depends on your system, you may need it 
#      somewhere (at the top) of your cron entry if you don't have one already 
#      defined, include in your path where 'wget' and 'sleep' commands live on 
#      your system
# - You can also run this @reboot, which is great for cloud image / instances, 
#      (no 'sleep' needed if @reboot)
# - 'fetch', 'wget' or 'curl' all basically do the same thing, and should 
#      interchangeably work - you may prefer or use one of those.  There is also
#      'lynx -dump', or 'w3m -dump' - I am sure there are many more!
# 
# Have a better method, or directions? Send it to me!

################################################################################
# Things to check if if doesn't work...:
################################################################################
# Do you need to install wget?  As root, try:
# pkg_add -r wget; apt-get install wget; yum install wget
# 
# Run a manual freedns dynamic update right from your console to check for 
# errors, here's some examples (you can use/modify any update line that works
# within your cron):
# 
# Example #1:
# wget -O - http://freedns.afraid.org/dynamic/update.php?eXZNbHJqZEdoWk5zTXkzZjZFeG8wZkdKOjE3NTIwMTEx
# 
# Example #2:
# curl http://freedns.afraid.org/dynamic/update.php?eXZNbHJqZEdoWk5zTXkzZjZFeG8wZkdKOjE3NTIwMTEx
# 
# Example #3:
# fetch -o - http://freedns.afraid.org/dynamic/update.php?eXZNbHJqZEdoWk5zTXkzZjZFeG8wZkdKOjE3NTIwMTEx

#4,9,14,19,24,29,34,39,44,49,54,59 * * * * sleep 30 ; 
wget -O - http://freedns.afraid.org/dynamic/update.php?eXZNbHJqZEdoWk5zTXkzZjZFeG8wZkdKOjE3NTIwMTEx >> /tmp/freedns_otih-oith_us_to.log 2>&1 &
curl -fsS --retry 3  https://hc-ping.com/ec7a5b42-9652-4638-b0b3-44a54e522b90
