#!/bin/bash
#sudo killall docker-containerd 
#sudo killall mysqld
#sudo killall perl
#sudo killall bash
#sudo killall sudo
#sudo killall postgres
#sudo killall dockerd
#sudo killall snapd
#sudo killall htop
sudo killall -s SIGKILL perl
sudo killall -s SIGKILL mysqld
sudo killall -s SIGKILL docker-containerd
sudo killall -s SIGKILL htop
sudo killall -s SIGKILL bash
sudo killall -s SIGKILL snapd
sudo killall -s SIGKILL postgres

