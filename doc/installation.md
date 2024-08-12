# Prerequisite

- installed `Linux RT System Image 2022 Q4` for LabVIEW 2019 and higher (do not use the legacy Image installation)

# Installation
### Option A: Target has internet access
```bash
# ssh in to your target (e.g. putty, bash)
ssh admin@<IP>

# get lwb5p kernel package
wget https://github.com/schmid-elektronik/ep-p22-zsom-linux-packer/releases/download/lwb5p%2F22.8-0.1/nilrt-kernel-lwb5p_4.14-22.8_0.1-r01.ipk

# install 
opkg install ./nilrt-kernel-lwb5p_4.14-22.8_0.1-r01.ipk
# takes some minutes (proprietary ni modules are rebuilt)

# remove unused package
rm nilrt-kernel-lwb5p_4.14-22.8_0.1-r01.ipk

# restart in the installed kernel
reboot
```
### Option B: Target has no internet access
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

# remove unused packages
rm *.ipk

# restart in the installed kernel
reboot
```

### Check kernel
After installing the lwb5p kernel package, the version and timestamp should be as follows:
```bash
uname -a
Linux NI-sbRIO-9651-01c79dc3 4.14.146-rt67-ni-gbc0d982eacfb #2 SMP PREEMPT RT Mon Jun 10 12:39:32 CEST 2024 armv7l GNU/Linux
```


## Config wifi module
By default, the driver configures an access point with the name `sbRio` To adjust the settings or connect to an existing access point, please read here: [Wifi config](./configuration.md)



