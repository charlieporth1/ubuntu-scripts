export ip=$(bash /mnt/HDD/Programs//random_ip_gen.sh)
echo $ip
if ping -t 100 -c 1 $ip &> /dev/null
then
  echo 1
else
  echo 0
fi
