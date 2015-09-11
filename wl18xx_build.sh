#!/bin/bash

if [ ! -d ./ignore/ ] ; then
	mkdir -p ./ignore/
fi

if [ ! -d ./rootfs/ ] ; then
	mkdir -p ./rootfs/
fi

if [ -d ./ignore/build-utilites ] ; then
	cd ./ignore/build-utilites
	git pull
	cd -
else
	cd ./ignore/
	git clone git://git.ti.com/wilink8-wlan/build-utilites.git
	cd -
fi

directory=`pwd`
cd ./ignore/build-utilites

echo "export TOOLCHAIN_PATH=${directory}/dl/gcc-linaro-arm-linux-gnueabihf-4.8-2014.04_linux/bin/" > setup-env
echo "export ROOTFS=${directory}/rootfs/" >> setup-env
echo "export KERNEL_PATH=${directory}/KERNEL/" >> setup-env
echo "export KERNEL_VARIANT=DEFAULT" >> setup-env
echo "export CROSS_COMPILE=arm-linux-gnueabihf-" >> setup-env
echo "export ARCH=arm" >> setup-env
echo "[ \"\$TOOLCHAIN_PATH\" != \"DEFAULT\" ] && export PATH=\$TOOLCHAIN_PATH:\$PATH" >> setup-env

./build_wl18xx.sh init
./sudo_build_wl18xx.sh update R8.6
./sudo_build_wl18xx.sh firmware


