# ni-linux-packer
create an opkg package from ni-linux kernel

## DOC
Full  Doc here:

- [NI RT Community Doc](https://forums.ni.com/t5/NI-Linux-Real-Time-Documents/Working-with-the-Linux-Kernel-on-NI-LabVIEW-RT-targets-Exercise/ta-p/3538644?profile.language=en)
- [Getting Started Video](https://www.youtube.com/watch?v=pjRfKh8kf4o)
- [NILRT rootfs ](https://github.com/ni/nilrt)

Be aware you would need to build and copy kernel and rootfs separately

Be aware the [rootfs](https://github.com/ni/nilrt) instruction will lead you in a plain linux, but misses the proprietary NI stuff


## Kernel Build

```bash
# install required tools
apt install texinfo u-boot-tools gawk chrpath libsdl-dev wget git-core unzip make gcc g++ build-essential subversion sed autoconf automake texi2html coreutils diffstat python-pysqlite2 docbook-utils libsdl1.2-dev libxml-parser-perl libgl1-mesa-dev libglu1-mesa-dev xsltproc desktop-file-utils groff libtool xterm fop libncurses5-dev libncursesw5-dev mksquashfs 

# get toolchain
# armv7-a: http://www.ni.com/download/labview-real-time-module-2014/4957/en/
# x86_64: http://www.ni.com/download/labview-real-time-module-2014/4959/en/

# ARM, set environment 
export ARCH=arm
export CROSS_COMPILE=/usr/local/oecore-x86_64/sysroots/x86_64-nilrtsdk-linux/usr/bin/arm-nilrt-linux-gnueabi/arm-nilrt-linux-gnueabi-
export TGT_EXTRACFLAGS="--sysroot=/usr/local/oecore-x86_64/sysroots/cortexa9-vfpv3-nilrt-linux-gnueabi/"

# x86, set environment 
export ARCH=x86_64
export CROSS_COMPILE=/usr/local/oecore-x86_64_core2/sysroots/x86_64-nilrtsdk-linux/usr/bin/x86_64-nilrt-linux/x86_64-nilrt-linux-
export TGT_EXTRACFLAGS="--sysroot=/usr/local/oecore-x86_64_core2/sysroots/core2-64-nilrt-linux/"

# ARM, make config
make nati_zynq_defconfig

# X86, make config
make nati_x86_64_defconfig

# make ni-packages
make -j4 ni-pkg
```

## copy Kernel

```bash
# ARM only
scp ${KERNEL_ROOT}/ni-install/arm/boot/ni_zynq_custom_runmodekernel.itb \
    admin@${rt_target_hostname}:/boot/linux_runmode.itb

# x86_64 only
scp ${KERNEL_ROOT}/ni-install/x86/boot/bzImage \
    admin@${rt_target_hostname}:/boot/runmode/

# Copy kernel modules
scp -r ${KERNEL_ROOT}/ni-install/${ARCH}/lib/modules/ \
       admin@${rt_target_hostname}:/lib/modules/${VERSION}/
# Note that the newly-built modules directory contains symbolic links to the
# build and source directories; do not copy the linked directories to your
# target.
```

### Branches 19.1 and older

```bash 
# Copy headers squashfs
scp ${KERNEL_ROOT}/ni-install/${ARCH}/headers/headers.squashfs \
    admin@${rt_target_hostname}:/usr/local/natinst/tools/module-versioning-image.squashfs
    
# Reboot the target and check that the target successfully boots. 
# check that your kernel is running 
uname -a

# update NI drivers to work with the new kernel.
source /usr/local/natinst/tools/versioning_utils.sh
setup_versioning_env
versioning_call /usr/local/natinst/nikal/bin/updateNIDrivers $(kernel_version)
```

### Branches 20.0 and newer

```bash
# copy headers from host
cd /{KernelRoot}/ni-install/x86_64/headers/
unsquashfs module-versioning-image.squashfs
scp -r squashfs-root/kernel/ admin@${TargetIP}:/lib/modules/${KernelVersion}

# on target install proprietary modules
dkms autoinstall
dkms status
```

