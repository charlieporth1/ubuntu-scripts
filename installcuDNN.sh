#!/bin/sh
# Install cuDNN R2 on NVIDIA Jetson TK1
# Register as a NVIDIA developer and download the cuDNN package
# Package is named cudnn-6.5-linux-ARMv7-R2-rc1.tgz
# This script and the cuDNN package should be in the same directory, usually ~/Downloads
# This script places the library and include files for cudnn in the CUDA 6.5 directories
# Make sure this is executing as root
if [ $(id -u) != 0 ]; then
  echo "This script requires root permissions"
  echo "$ sudo "$0""
  exit
fi
# unzip the archive
tar -zxvf cudnn-6.5-linux-ARMv7-R2-rc1.tgz
cd cudnn-6.5-linux-ARMv7-R2-rc1
# copy the include file
cp cudnn.h /usr/local/cuda-6.5/include
cp libcudnn* /usr/local/cuda-6.5/lib
