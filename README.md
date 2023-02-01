# ni-linux-packer
create an opkg package from ni-linux kernel

## DOC
Full  Doc here:

- [NI RT Community Doc](https://forums.ni.com/t5/NI-Linux-Real-Time-Documents/Working-with-the-Linux-Kernel-on-NI-LabVIEW-RT-targets-Exercise/ta-p/3538644?profile.language=en)
- [Getting Started Video](https://www.youtube.com/watch?v=pjRfKh8kf4o)
- [NILRT rootfs ](https://github.com/ni/nilrt)

When we started building a custom Kernel in 2019. The NILRT rootfs instructions lead into plain Linux running on a RIO without the NI tools.

- This repo describes how to build the Kernel from [source](https://github.com/schmid-elektronik/ni-linux)
- This repo builds an ipkg from the Kernel build
- Today when starting from scratch, I would try to use NILRT rootfs instructions (Yocto) and build a complete Image

### Releases/Branches

Every Branch in [this Repo](https://github.com/schmid-elektronik/ep-p22-zsom-linux-packer) matches a Branch in the [Linux source Repo](https://github.com/schmid-elektronik/ni-linux)

- [Generic x86](https://github.com/schmid-elektronik/ep-p22-zsom-linux-packer/tree/20.x/generic/x86_64) - [20.0 and newer](https://github.com/schmid-elektronik/ni-linux/tree/nilrt/20.0/4.14) - vanilla NI Kernel
- [Memtest x86](https://github.com/schmid-elektronik/ep-p22-zsom-linux-packer/tree/20.x/memtest/x86_64) - [20.5 memtest](https://github.com/schmid-elektronik/ni-linux/tree/origin/nilrt/20.5/4.14/memtest) - activates Memtest in Bootargs
- [ath arm](https://github.com/schmid-elektronik/ep-p22-zsom-linux-packer/tree/20.5/ath/arm) - [20.5 ath](https://github.com/schmid-elektronik/ni-linux/tree/origin/nilrt/20.5/4.14/ath) - adds the ath9 wifi driver
- [lwp5p arm](https://github.com/schmid-elektronik/ep-p22-zsom-linux-packer/tree/20.5/lwb5p/arm) - [20.5 lwp5p](https://github.com/schmid-elektronik/ni-linux/tree/origin/nilrt%2F20.5%2F4.14%2Flwb5p) - adds the Laird Backport LWB5+  wifi driver



## Vanilla Kernel Build

### Tools

```bash
# install required tools
apt install texinfo u-boot-tools gawk chrpath wget git unzip make gcc g++ build-essential subversion sed autoconf automake texi2html coreutils diffstat python-pysqlite2 docbook-utils libsdl1.2-dev libxml-parser-perl libgl1-mesa-dev libglu1-mesa-dev xsltproc desktop-file-utils groff libtool xterm fop libncurses5-dev libncursesw5-dev

# mksquashfs

# get toolchain
# armv7-a: http://www.ni.com/download/labview-real-time-module-2014/4957/en/
wget https://download.ni.com/support/softlib/labview/labview_rt/2018/Linux%20Toolchains/linux/oecore-x86_64-cortexa9-vfpv3-toolchain-6.0.sh

# x86_64: http://www.ni.com/download/labview-real-time-module-2014/4959/en/
wget https://download.ni.com/support/softlib/labview/labview_rt/2018/Linux%20Toolchains/linux/oecore-x86_64-core2-64-toolchain-6.0.sh

# install ARM toolchain to    /usr/local/oecore-x86_64
# install x86_64 toolchain to /usr/local/oecore-x86_64_core2
```

### Get Source

```bash
git clone https://github.com/schmid-elektronik/ni-linux.git
git clone https://github.com/schmid-elektronik/ep-p22-zsom-linux-packer.git
```

### Build Arm

Check your architecture on the [cRio Site](https://www.ni.com/en-us/shop/hardware/products/compactrio-controller.html) or the [sbRio Site](https://www.ni.com/en-us/shop/hardware/products/compactrio-single-board-controller.html)

```bash
# ARM, set environment (zynq devices)
# . /usr/local/oecore-x86_64/environment-setup-cortexa9-vfpv3-nilrt-linux-gnueabi
export ARCH=arm
export CROSS_COMPILE=/usr/local/oecore-x86_64/sysroots/x86_64-nilrtsdk-linux/usr/bin/arm-nilrt-linux-gnueabi/arm-nilrt-linux-gnueabi-
export TGT_EXTRACFLAGS="--sysroot=/usr/local/oecore-x86_64/sysroots/cortexa9-vfpv3-nilrt-linux-gnueabi/"

# cd into source
cd ni-linux
git co <YOURBRANCH>

# ARM, make config
make nati_zynq_defconfig

# make ni-packages
make -j4 ni-pkg
```
### Build x86_64

```bash
# x86, set environment (intel devices)
# . /usr/local/oecore-x86_64_core2/environment-setup-core2-64-nilrt-linux
export ARCH=x86_64
export CROSS_COMPILE=/usr/local/oecore-x86_64_core2/sysroots/x86_64-nilrtsdk-linux/usr/bin/x86_64-nilrt-linux/x86_64-nilrt-linux-
export TGT_EXTRACFLAGS="--sysroot=/usr/local/oecore-x86_64_core2/sysroots/core2-64-nilrt-linux/"

# cd into source
cd ni-linux
git co <YOURBRANCH>

# X86, make config
make nati_x86_64_defconfig

# make ni-packages
make -j4 ni-pkg

# FIXME, you might get the Error
# You are building kernel with non-retpoline compiler, please update your compiler..
# unconfig the CONFIG_RETPOLINE option
# make menuconfig -> Processor type and features -> uncheck avoid speculative indirect branches in kernel
```



From here on follow the instructions in your respective Branch.  Or see [devnotes](./doc/devnotes.md) for manual installations.

