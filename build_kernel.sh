#!/bin/bash

export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-

cd firefly-linux
make mrproper
#make firefly_linux_defconfig
cp ../virtio_config .config

make rk3399-roc-pc-plus.img -j`nproc`
INSTALL_MOD_PATH=../ INSTALL_FW_PATH=../lib/firmware/ make modules_install firmware_install
cp *.img ../lib

cd ..
