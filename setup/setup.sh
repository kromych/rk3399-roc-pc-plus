#!/bin/bash

# git clone https://android.googlesource.com/tools/repo
# repo init --repo-url=https://github.com/rockchip-linux/repo -u https://github.com/rockchip-linux/manifests -b master
# repo sync

# git clone https://git.kernel.org/pub/scm/utils/dtc/dtc.git
# cd dtc
# make
# sudo make install PREFIX=/opt/dtc
# cd ..

# git clone -b rk3399/firefly https://gitlab.com/firefly-linux/kernel.git ../firefly-linux
# git clone -b stable-4.4-rk3399-linux https://github.com/rockchip-linux/kernel.git ../rockchip-linux

# wget https://releases.linaro.org/components/toolchain/binaries/7.5-2019.12/aarch64-linux-gnu/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu.tar.xz 
sudo tar xJvf ./gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu.tar.xz -C /opt
