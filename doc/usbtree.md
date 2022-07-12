##  running ZSOM-Control with WiFi Modul

```shell
admin@NI-sbRIO-9651-01dd1c30:~# dmesg | grep 'usb\|USB'
[    0.298651] usbcore: registered new interface driver usbfs
[    0.298735] usbcore: registered new interface driver hub
[    0.298860] usbcore: registered new device driver usb
[    0.655100] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    4.263495] chipidea-usb2 e0003000.usb: e0003000.usb supply vbus not found, using dummy regulator
[    4.373748] usb_phy_generic phy0: phy0 supply vcc not found, using dummy regulator
[    4.374955] usb_phy_generic phy1: phy1 supply vcc not found, using dummy regulator
[    4.380437] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus number 1
[    4.400783] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
[    4.413506] hub 1-0:1.0: USB hub found
[    4.790780] usb 1-1: new high-speed USB device number 2 using ci_hdrc
[    5.015097] hub 1-1:1.0: USB hub found
[    5.340779] usb 1-1.2: new high-speed USB device number 3 using ci_hdrc
[    5.492511] hub 1-1.2:1.0: USB hub found
[    5.920797] usb 1-1.2.1: new high-speed USB device number 4 using ci_hdrc
[    6.170762] usb 1-1.2.2: new high-speed USB device number 5 using ci_hdrc
[    9.226211] usb0: HOST MAC de:e8:64:94:6a:26
[    9.226275] usb0: MAC 00:80:2f:24:21:55
admin@NI-sbRIO-9651-01dd1c30:~# lsusb -t
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ci_hdrc/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=, Driver=hub/4p, 480M
        |__ Port 2: Dev 3, If 0, Class=, Driver=hub/2p, 480M
            |__ Port 1: Dev 4, If 0, Class=, Driver=, 480M
            |__ Port 2: Dev 5, If 2, Class=, Driver=, 480M
            |__ Port 2: Dev 5, If 0, Class=, Driver=, 480M
            |__ Port 2: Dev 5, If 3, Class=, Driver=, 480M
            |__ Port 2: Dev 5, If 1, Class=, Driver=, 480M
```

 Port 2: Dev 3 represents the Hub on Wifi modul