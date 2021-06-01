# ni-linux-packer arm
- create an opkg package from ni-linux branches 20.0 and newer kernel
- kernel, modules and header 

## create package

- compile kernel as described in main branch
- modify control/control to your need
- run `./build_opkg.sh ${KERNEL_PATH} `
- copy package to target 
- install `opkg install ./package.ipkg`



## backport
- get backport https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases
- build kernel, without the modules provided by backport, refer to `nilrt/20.5/4.14/lwb5p`

```bash
set -a
ARCH=arm
CROSS_COMPILE=/usr/local/oecore-x86_64/sysroots/x86_64-nilrtsdk-linux/usr/bin/arm-nilrt-linux-gnueabi/arm-nilrt-linux-gnueabi-
KLIB=/usr/local/oecore-x86_64/sysroots/cortexa9-vfpv3-nilrt-linux-gnueabi/
KLIB_BUILD=/home/mas/ni-linux/ # build kernel first
set +a
make defconfig-lwb5p
make

# copy built modules to target/package
```



## Wifi setings
- AP Mode is done in wpa_supplicant.conf
    - How to add support for MAX? interface appears as wiredapter
- confi set with nirtcfg, see postinst
- regulatory domain, set in /etc/modprobe.d/brmcfmac.conf
    - see laird for details: https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases/download/LRD-REL-8.5.0.7/sig_LWB_series_radio.pdf

## Resources
Laird Resources

https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases
https://www.lairdconnect.com/wireless-modules/wifi-modules-bluetooth/sterling-lwb5-plus-wifi-5-bluetooth-5-module



Linux Backport

https://backports.wiki.kernel.org/index.php/Documentation/packaging

