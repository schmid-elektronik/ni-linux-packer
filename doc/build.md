
# LWP5+ Backport
Building the Backport generates the LWP5+ Kernel Modules. They are already in the stage folder. Here is how to build them from scratch.

- get backport https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases
- build kernel, without the modules provided by backport, refer to `nilrt/20.5/4.14/lwb5p` (that is configured in the lwb5p branch)

## build

Use the NI Crosscomplier

```bash
set -a
ARCH=arm
CROSS_COMPILE=/usr/local/oecore-x86_64/sysroots/x86_64-nilrtsdk-linux/usr/bin/arm-nilrt-linux-gnueabi/arm-nilrt-linux-gnueabi-
KLIB=/usr/local/oecore-x86_64/sysroots/cortexa9-vfpv3-nilrt-linux-gnueabi/
KLIB_BUILD=/home/mas/ni-linux/ # build kernel first
set +a
make defconfig-lwb5p
make

# copy built modules to target/package, respective the stage folder
```



## Wifi settings
- AP Mode is done in wpa_supplicant.conf
    - Currently there is no support for MAX, since we use another driver.
- config set with nirtcfg, see postinst for details
- regulatory domain, set in /etc/modprobe.d/brmcfmac.conf
    - see laird for details: https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases/download/LRD-REL-8.5.0.7/sig_LWB_series_radio.pdf

## Resources
Laird Resources

https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases
https://www.lairdconnect.com/wireless-modules/wifi-modules-bluetooth/sterling-lwb5-plus-wifi-5-bluetooth-5-module



Linux Backport

https://backports.wiki.kernel.org/index.php/Documentation/packaging

