# ep-p22-zsom-linux-packer

This branch adds the LWB5+ Backport to the Kernel. The Backport contains kernel modules, configuration and firmware. See Folder `stage` for details. It refers to this kernel [origin/nilrt/20.5/4.14/lwb5p](https://github.com/schmid-elektronik/ni-linux/tree/origin/nilrt%2F20.5%2F4.14%2Flwb5p)

Documentation

- for ZSOM user installation see [installation.md](./doc/installation.md)
- for Backport build, see [build.md](./doc/build.md)
- USB troubleshooting, see  [usbtree.md](./doc/usbtree.md)



## create package

- compile kernel as described in main branch
- modify control/control to your need
- run `./build_opkg.sh ${KERNEL_PATH} `
- copy package to target
- install `opkg install ./package.ipkg`
