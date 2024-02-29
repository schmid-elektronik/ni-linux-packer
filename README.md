# ni-linux-packer
This Branch creates packages to install only kernel modules. Not the kernel itself. The Kernel Module can be found in `data` Folder.

- refers to this kernel [origin/nilrt/20.5/4.14/ath](https://github.com/schmid-elektronik/ni-linux/tree/origin/nilrt/20.5/4.14/ath)
- run `./build.sh`
- install package



## To build or update kernel module

If you want to rebuild the `ath9k_htc.ko` see kernel build in main branch. Then do some other custom config follow the steps below, just before make ni-packages ;)


```bash
sudo apt install libncurses5-dev libncursesw5-dev

make nati_zynq_defconfig
make menuconfig

## for Z SOM add following Modules
# Prompt: Atheros HTC based wireless cards support
# Location: -> Device Drivers -> Network device support (NETDEVICES [=y]) -> Wireless LAN (WLAN [=y]) -> Atheros/Qualcomm devices (WLAN_VENDOR_ATH [=y]) 
```
Now build ni-packages:
```bash
make -j4 ni-pkg

# following additional kernel module will be built
./drivers/net/wireless/ath/ath9k/ath9k_htc.ko
```

Copy your additional module `ath9k_htc.ko` to `./data`