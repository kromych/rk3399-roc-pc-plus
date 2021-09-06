#!/bin/bash

export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-
export INSTALL_MOD_PATH=../out/
export INSTALL_HDR_PATH=../out/
export INSTALL_FW_PATH=../out/lib/firmware/

cd firefly-linux
make mrproper
#make firefly_linux_defconfig
cp ../virtio_config .config

make rk3399-roc-pc-plus.img -j`nproc`
make headers_install modules_install firmware_install

cp *.img ../out

cd ..
