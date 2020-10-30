#!/bin/bash
killall -9 chrome
killall -9 google-chrome
killall -9 chromedriver
killall -9 chromium-browser
for pid in `ps aux | grep "chrome" | awk '{print $2}'`; do sudo kill -9 $pid; done
for pid in `sudo ps aux | grep "chrome" | awk '{print $2}'`; do sudo kill -9 $pid; done
