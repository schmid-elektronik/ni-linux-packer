# ep-p22-zsom-linux-packer

This branch adds the LWB5+ Backport to the Kernel and activates USB serial driver for Huawei ME909. Kernel modules, configuration and firmware see Folder `stage` for details. It refers to this kernel [origin/nilrt/20.5/4.14/zsom-connect](https://github.com/schmid-elektronik/ni-linux/tree/origin/nilrt/20.5/4.14/zsom-connect)

Documentation

- for ZSOM user installation see [installation.md](./doc/installation.md)
- to build form scratch see [build.md](./doc/build.md)
- USB troubleshooting, see  [usbtree.md](./doc/usbtree.md)



## create package

- compile kernel as described in main branch
- modify control/control to your need
- run `./build_opkg.sh ${KERNEL_PATH} `
- copy package to target
- install `opkg install ./package.ipkg`