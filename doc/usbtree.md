##  running ZSOM-Control with WiFi Modul

```shell
admin@NI-sbRIO-9651-01dd1c45:~# dmesg | grep 'usb\|USB'
[    0.655173] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    4.132073] chipidea-usb2 e0003000.usb: e0003000.usb supply vbus not found, using dummy regulator
[    4.289823] usb_phy_generic phy0: phy0 supply vcc not found, using dummy regulator
[    4.291782] usb_phy_generic phy1: phy1 supply vcc not found, using dummy regulator
[    4.302265] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus number 1
[    4.330917] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
[    4.346764] hub 1-0:1.0: USB hub found
[    9.043981] usb0: HOST MAC 4a:5c:79:4c:23:8b
[    9.044042] usb0: MAC 00:80:2f:24:23:32
[   58.320830] usb 1-1: new high-speed USB device number 2 using ci_hdrc
[   58.523696] hub 1-1:1.0: USB hub found
[   58.840909] usb 1-1.2: new high-speed USB device number 3 using ci_hdrc
[   58.992220] hub 1-1.2:1.0: USB hub found
[   59.640842] usb 1-1.2.2: new high-speed USB device number 4 using ci_hdrc
[   59.792440] hub 1-1.2.2:1.0: USB hub found
[   60.210843] usb 1-1.2.2.1: new high-speed USB device number 5 using ci_hdrc
[   60.525115] usbcore: registered new interface driver brcmfmac
[   60.917351] usb 1-1.2.2.1: USB disconnect, device number 5
[   61.021569] brcmfmac: brcmf_usb_dl_cmd: usb_submit_urb failed -19
[   61.320832] usb 1-1.2.2.1: new high-speed USB device number 6 using ci_hdrc
[   72.180830] usb 1-1.2.1: new high-speed USB device number 7 using ci_hdrc
[   72.399446] usbcore: registered new interface driver usbserial
[   72.403212] cdc_ether 1-1.2.1:2.0 usb1: register 'cdc_ether' at usb-ci_hdrc.1-1.2.1, CDC Ethernet Device, 02:1e:10:1f:00:00
[   72.403509] usbcore: registered new interface driver cdc_ether
[   72.432206] usbcore: registered new interface driver option
[   72.432346] usbserial: USB Serial support registered for GSM modem (1-port)
[   72.434300] usb 1-1.2.1: GSM modem (1-port) converter now attached to ttyUSB0
[   72.434953] usb 1-1.2.1: GSM modem (1-port) converter now attached to ttyUSB1
[   72.435570] usb 1-1.2.1: GSM modem (1-port) converter now attached to ttyUSB2
[   72.436184] usb 1-1.2.1: GSM modem (1-port) converter now attached to ttyUSB3

admin@NI-sbRIO-9651-01dd1c45:~# lsusb -t
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ci_hdrc/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=, Driver=hub/4p, 480M
        |__ Port 2: Dev 3, If 0, Class=, Driver=hub/2p, 480M
            |__ Port 1: Dev 7, If 0, Class=, Driver=cdc_ether, 480M
            |__ Port 1: Dev 7, If 1, Class=, Driver=cdc_ether, 480M
            |__ Port 1: Dev 7, If 2, Class=, Driver=option, 480M
            |__ Port 1: Dev 7, If 3, Class=, Driver=option, 480M
            |__ Port 1: Dev 7, If 4, Class=, Driver=option, 480M
            |__ Port 1: Dev 7, If 5, Class=, Driver=option, 480M
            |__ Port 2: Dev 4, If 0, Class=, Driver=hub/2p, 480M
                |__ Port 1: Dev 6, If 0, Class=, Driver=brcmfmac, 480M
```
