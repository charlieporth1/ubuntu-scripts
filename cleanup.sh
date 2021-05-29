#!/bin/bash
rm -rf /var/cache/apt/archives
rm -rf /var/log/pcp*
rm -rf /var/cache/fontconfig/*

sudo apt autoremove
sudo apt autoclean
