#!/bin/bash
sudo cgcreate -g cpu:/cpulimited
sudo cgset -r cpu.shares=128 cpulimited
