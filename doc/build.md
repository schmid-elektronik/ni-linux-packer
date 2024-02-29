
# LWP5+ Backport
Building the Backport generates the LWP5+ Kernel Modules. They are already in the stage folder. To build them from scratch see:
https://github.com/schmid-elektronik/ep-p22-zsom-linux-packer/blob/20.5/lwb5p/arm/doc/build.md

## Wifi settings
- AP config is done in wpa_supplicant.conf
  - Currently there is no support for MAX, since we use another driver
- config set with nirtcfg, see postinst for details
- regulatory domain, set in /etc/modprobe.d/brmcfmac.conf
  - see laird for details: https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases/download/LRD-REL-8.5.0.7/sig_LWB_series_radio.pdf

# Huawei ME909
To activated USB serial driver make defconfig and rebuild kernel modules. See Kernel build in main branch.  
**Note: In our branch they are already activated!**

## build

To Build Kernel Modules, do some other custom config follow the steps below, just before make `ni-packages` ;)

```bash
sudo apt install libncurses5-dev libncursesw5-dev

make nati_zynq_defconfig
make menuconfig

## for Z SOM add following Modules
# Prompt: Huawei NCM embedded AT channel support
# Location: -> Device Drivers -> Network device support (NETDEVICES [=y])  -> USB Network Adapters (USB_NET_DRIVERS [=m]) -> Multi-purpose USB Networking Framework (USB_USBNET [=m]) 

# Prompt: USB driver for GSM and CDMA modems
# Location: -> Device Drivers  -> USB support (USB_SUPPORT [=y]) -> USB Serial Converter support (USB_SERIAL [=m]) ->  USB driver for GSM and CDMA modems
```

Now you can check witch additional parameters was set:
```bash
vimdiff .config .config.old

# following additional parameters was added
CONFIG_USB_NET_HUAWEI_CDC_NCM=m
CONFIG_USB_WDM=m
CONFIG_USB_SERIAL_OPTION=m
```
Now build ni-packages:
```bash
make -j4 ni-pkg

# following additional kernel modules will be built
./drivers/net/usb/huawei_cdc_ncm.ko
./drivers/usb/class/cdc-wdm.ko
./drivers/usb/serial/option.ko
```


## Resources
Laird Resources

https://github.com/LairdCP/Sterling-LWB-and-LWB5-Release-Packages/releases
https://www.lairdconnect.com/wireless-modules/wifi-modules-bluetooth/sterling-lwb5-plus-wifi-5-bluetooth-5-module



Linux Backport

https://backports.wiki.kernel.org/index.php/Documentation/packaging

