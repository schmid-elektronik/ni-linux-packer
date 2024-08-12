# Wifi configuration

MAX can't handle this driver Backport. The AP is configured in the wpa_supplicant.conf file. (Basically the same that MAX does)

```bash
# ssh in to your target
ssh admin@<IP>

# install text editor (e.g. vi, nano)
opkg install nano

# open config file
nano /etc/natinst/share/wpa_supplicant.conf

# change parameter ssid, psk to your needs (at least 8 characters)
# example config see below

# save and close file
# with nano (ctl+x), (y), (Enter)

# reboot to update config
reboot
```

## Create an Access Point
This is done by the driver by default. The access point name is `sbRio` and current IP should be `172.16.0.1`
```bash
ifconfig | grep -A 1 wlan0 
wlan0     Link encap:Ethernet  HWaddr C0:EE:40:80:47:1C  
          inet addr:172.16.0.1  Bcast:172.15.255.255  Mask:255.240.0.0
```

To change access point name or secure key edit the `wpa_supplicant.conf` file as shown on top
```bash
# example config
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=ni
ap_scan=2
fast_reauth=0
update_config=1

network={
        ssid="myNetwork"
        scan_ssid=1
        psk="myKeySecure"
        key_mgmt=WPA-PSK
        mode=2
        frequency=2412
}
```
***Reboot to update config!***

Show current settings:
```bash
/usr/local/natinst/bin/nirtcfg -l | grep wlan0 | sed 's/\[wlan0\]//g'
radioenabled=1
dhcpenabled=1
linklocalenabled=1
adaptermode=1
dhcpserverenabled=1
Mode=TCPIP
```


## Connect to Access Point
By default, the driver configures an access point with the name `sbRio` To connect to an existing access point we first need to clear all settings.

Clear current settings:
```bash
# show the current settings
/usr/local/natinst/bin/nirtcfg -l | grep wlan0 | sed 's/\[wlan0\]//g'
radioenabled=1
dhcpenabled=1
linklocalenabled=1
adaptermode=1
dhcpserverenabled=1
Mode=TCPIP

# clear all
/usr/local/natinst/bin/nirtcfg --clear section=wlan0,token=radioenabled
/usr/local/natinst/bin/nirtcfg --clear section=wlan0,token=dhcpenabled
/usr/local/natinst/bin/nirtcfg --clear section=wlan0,token=linklocalenabled
/usr/local/natinst/bin/nirtcfg --clear section=wlan0,token=adaptermode
/usr/local/natinst/bin/nirtcfg --clear section=wlan0,token=dhcpserverenabled
/usr/local/natinst/bin/nirtcfg --clear section=wlan0,token=Mode

# now check again (should be empty)
/usr/local/natinst/bin/nirtcfg -l | grep wlan0 | sed 's/\[wlan0\]//g'
```

Update `wpa_supplicant.conf` as shown on top with configuration example below:
```bash
# example config
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=ni
update_config=1
fast_reauth=0

network={
        ssid="AccessPoint"
        scan_ssid=1
        psk="Key"
        key_mgmt=WPA-PSK
}
```

Set new config to connect to an access point:
```bash
/usr/local/natinst/bin/nirtcfg --set section=wlan0,token=radioenabled,value=1
/usr/local/natinst/bin/nirtcfg --set section=wlan0,token=dhcpenabled,value=1
/usr/local/natinst/bin/nirtcfg --set section=wlan0,token=linklocalenabled,value=1
```

***POWER OFF the device and restart to update config!***

Check if we have received an IP address `192.168.1.5` from access point:
```bash
ifconfig | grep -A 1 wlan0
wlan0     Link encap:Ethernet  HWaddr C0:EE:40:80:47:1C  
inet addr:192.168.1.5  Bcast:192.168.1.255  Mask:255.255.255.0
```
