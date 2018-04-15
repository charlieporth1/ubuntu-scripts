#!/bin/bash
for file in /var/www/*
do
    sum1="$(md5sum "$file")"
    sleep 2
    sum2="$(md5sum "$file")"
    if [ "$sum1" = "$sum2" ];
    then
        echo "Identical"
    else
        echo "Different"
    fi
done
