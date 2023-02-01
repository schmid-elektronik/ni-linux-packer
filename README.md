# ni-linux-packer
This Branch creates packages to install only kernel modules. Not the kernel itself. The Kernel Module can be found in `data` Folder.

- refers to this kernel [origin/nilrt/20.5/4.14/ath](https://github.com/schmid-elektronik/ni-linux/tree/origin/nilrt/20.5/4.14/ath)
- run `./build.sh`
- install package



To build or update Kernel module

- compile "ni mainline 20.5" Kernel with your additional Module (`ath9k_htc.ko`)
- copy module to `./data`
