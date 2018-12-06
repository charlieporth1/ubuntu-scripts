#export ip=$(bash /mnt/HDD/Programs//random_ip_gen.sh)
export MAX=255
export dot='.'
delare -a a
for ((a=0; a<=$MAX; a++))
do
for ((b=0; b<=$MAX; b++))
do
for ((c=0; c<=$MAX; c++))
do
for ((d=0; d<=$MAX; d++))
do
export ip=$a$dot$b$dot$c$dot$d
echo $ip
if ping -t 100 -c 1 $ip &> /dev/null
then
  echo $ip
  echo $ip >> ip_wordlist.txt
  echo 1
else
  echo 0
fi
done 
done 
done 
done 
declare -a myarray

# myarray

IFS=$'\n' a=($(cat ip_wordlist.txt))
for i in $(seq ${#a[*]}); do
    [[ ${a[$i-1]} = $name ]] && echo "${a[$i]}"
echo ${a[$i]} 
if ping -t 100 -c 1 ${a[$i]} &> /dev/null
then
  echo ${a[$i]} 
  echo ${a[$i]}  > ip_wordlist_online.txt
  echo 1
else
  echo 0
fi

done
