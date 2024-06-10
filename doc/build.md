# Build Linux Kernel and LWB5+ Backport

**Prerequisite:** Install the NI crosscompiler described in main branch.

For this build we use the sterling LWB5P driver release [10.4.0.10](https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases/tag/LRD-REL-10.4.0.10)

## Kernel

```bash
# set the working directory
WD=/home/roman/zsom
cd $WD

# set crosscompiler
export ARCH=arm
export CROSS_COMPILE=/usr/local/oecore-x86_64/sysroots/x86_64-nilrtsdk-linux/usr/bin/arm-nilrt-linux-gnueabi/arm-nilrt-linux-gnueabi-
export TGT_EXTRACFLAGS="--sysroot=/usr/local/oecore-x86_64/sysroots/cortexa9-vfpv3-nilrt-linux-gnueabi/"

# get the sources
git clone git@github.com:ni/linux.git

# checkout branch for image 22.8
cd linux
git checkout origin/nilrt/22.8/4.14

git log | head -n 5
commit bc0d982eacfb9764302e888ea6d9f3d3bb4a5cc9 (HEAD, origin/nilrt/master/4.14, origin/nilrt/22.8/4.14)
Author: Ben Hutchings <ben@decadent.org.uk>
Date:   Sat Jul 25 02:06:23 2020 +0100

    libtraceevent: Fix build with binutils 2.35
```

Now create and build our own defconfig. For further details see Laird Software Integration Guide -> Backports: [sig_LWB_series_radio.pdf](https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases/download/LRD-REL-10.4.0.10/sig_LWB_series_radio.pdf)
```bash
# build config
make nati_zynq_defconfig
make menuconfig

# disable all the following modules
# - Device Drivers -> Network device support -> Wireless LAN []
# - Networking support -> Wireless []
# - Networking support -> Bluetooth subsystem support []

# build the kernel
make -j4 ni-pkg
```
Now build the driver package with de precompiled kernel modules from this repo or continue building the LWB5+ kernel modules. 

## LWB5+ Backport
Building the backport generates the LWP5+ kernel modules. They are already in the stage folder. Here is how to build the whole repo from scratch.
```bash
# set the working directory
WD=/home/roman/zsom
cd $WD

# install  the following packages in needed
sudo apt install flex bison

# get the linux packer repo:
cd $WD
git clone git@github.com:schmid-elektronik/ep-p22-zsom-linux-packer.git
cd ep-p22-zsom-linux-packer
git checkout origin/20.5/lwb5p/arm

# build lwb5p kernel object files
cd $WD
wget https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases/download/LRD-REL-10.4.0.10/backports-laird-10.4.0.10.tar.bz2
tar xfva backports-laird-10.4.0.10.tar.bz2
cd laird-backport-10.4.0.10

set -a
ARCH=arm
CROSS_COMPILE=/usr/local/oecore-x86_64/sysroots/x86_64-nilrtsdk-linux/usr/bin/arm-nilrt-linux-gnueabi/arm-nilrt-linux-gnueabi-
KLIB=/usr/local/oecore-x86_64/sysroots/cortexa9-vfpv3-nilrt-linux-gnueabi/
KLIB_BUILD=$WD/linux
set +a
make defconfig-lwb5p
make

# copy files to the corresponding folder:
STAGE=$WD/ep-p22-zsom-linux-packer/stage/lib/modules/KERNEL_VERSION/kernel/

cp ./drivers/net/wireless/broadcom/brcm80211/brcmfmac/brcmfmac.ko $STAGE/drivers/net/wireless/broadcom/brcm80211/brcmfmac/
cp ./drivers/net/wireless/broadcom/brcm80211/brcmutil/brcmutil.ko $STAGE/drivers/net/wireless/broadcom/brcm80211/brcmutil/
cp ./net/wireless/cfg80211.ko $STAGE/net/wireless/
cp ./compat/compat.ko $STAGE/compat/
cp ./net/bluetooth/bluetooth.ko $STAGE/net/bluetooth/
cp ./net/bluetooth/rfcomm/rfcomm.ko $STAGE/net/bluetooth/rfcomm/
cp ./drivers/bluetooth/hci_uart.ko $STAGE/drivers/bluetooth/
cp ./drivers/bluetooth/btusb.ko $STAGE/drivers/bluetooth/
cp ./drivers/bluetooth/btbcm.ko $STAGE/drivers/bluetooth/


# get lwb5p firmware (we use usb and single antenna):
cd $WD
wget https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases/download/LRD-REL-10.4.0.10/laird-lwb5plus-usb-sa-firmware-10.4.0.10.tar.bz2
tar xfva laird-lwb5plus-usb-sa-firmware-10.4.0.10.tar.bz2

# copy files to the corresponding folder:
cp -r lib/firmware $WD/ep-p22-zsom-linux-packer/stage/lib/
``` 

## Create the opkg package
```bash
# set the working directory
WD=/home/roman/zsom
cd $WD

# build packet:
cd ep-p22-zsom-linux-packer
./build_opkg.sh $WD/linux/
```