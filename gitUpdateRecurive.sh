#!/bin/bash
pwd
for i in $( ls ); do
   echo 'folder: $i'
cd $i 
git pull 
cd ..
for i in $( ls ); do
   echo 'folder: $i'
cd $i 
git pull 
cd ..
for i in $( ls ); do
   echo 'folder: $i'
cd $i 
git pull 
cd ..
done
done
done
        
