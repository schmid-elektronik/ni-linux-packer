# Prerequisite

- installed `Linux RT System Image 2022 Q4` for LabVIEW 2019 and higher (do not use the legacy Image installation)
- Target has Internet access

# Installation
### Target has internet access
```bash
# ssh in to your target (e.g. putty, bash)
ssh admin@<IP>

# get lwb5p kernel package
wget https://github.com/schmid-elektronik/ep-p22-zsom-linux-packer/releases/download/lwb5p%2F22.8-0.1/nilrt-kernel-lwb5p_4.14-22.8_0.1-r01.ipk

# install 
opkg install ./nilrt-kernel-lwb5p_4.14-22.8_0.1-r01.ipk
# takes some minutes (proprietary ni modules are rebuilt)

# restart in the installed kernel
reboot
```
### Target has no internet access
```bash
# download all ipk packages from the repos to our computer:
#   dhcp-server-config_4.3.6-r0.49_cortexa9-vfpv3.ipk
#   dhcp-server_4.3.6-r0.49_cortexa9-vfpv3.ipk
#   nilrt-kernel-lwb5p_4.14-22.8_0.1-r01.ipk

# copy the files with scp or winscp to the target
scp *.ipk admin@<IP>:/home/admin

# ssh in to your target (e.g. putty, bash)
ssh admin@<IP>

# install the packages in the following order
opkg install ./dhcp-server-config_4.3.6-r0.49_cortexa9-vfpv3.ipk
opkg install ./dhcp-server_4.3.6-r0.49_cortexa9-vfpv3.ipk
opkg install ./nilrt-kernel-lwb5p_4.14-22.8_0.1-r01.ipk
# takes some minutes (proprietary ni modules are rebuilt)

# restart in the installed kernel
reboot
```



## Config AccessPoint

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





