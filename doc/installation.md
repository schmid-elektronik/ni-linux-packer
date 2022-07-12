# Prerequisite

- installed `Linux RT System Image 20.5` (for LabVIEW 2019 and 2020)
  - (do not use the legacy Image installation)
- Target has Internet access

# installation

```bash
# ssh in to your target (e.g. putty, bash)
ssh admin@<IP>

# get lwb5p kernel package 
wget https://github.com/schmid-elektronik/ep-p22-zsom-linux-packer/releases/download/lwb5p%2F20.5-0.1/ni-linux-kernel-lwb5p_0.1-r01.ipk

# install 
opkg update  # get package list for dependencies
opkg install ./ni-linux-kernel-lwb5p_0.1-r01.ipk
# takes some minutes (proprietary ni modules are rebuilt)

# restart in the installed kernel
reboot
```



## config AccessPoint

MAX can't handle this driver Backport. The AP is configured in the wpa_supplicant.conf file. (Basically the same that MAX does)

```bash
# ssh in to your target
ssh admin@<IP>

# install text editor (e.g. vi, nano)
opkg install nano

# open config file
nano /etc/natinst/share/wpa_supplicant.conf

# change parameter ssid, psk to your needs
# psk need at least 8 characters
# example config
network={
        ssid="myNetwork"
        scan_ssid=1
        psk="myKeySecure"
        key_mgmt=WPA-PSK
        mode=2
        frequency=2412
}

# save and close file
# with nano (ctl+x), (y), (Enter)

# reboot to update config
reboot

```





