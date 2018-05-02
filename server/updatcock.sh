#!/bin/bash
cd /mnt/HDD/cockpit$
sudo git pull
sudo ./autogen.sh
sudo make
sudo make install 
