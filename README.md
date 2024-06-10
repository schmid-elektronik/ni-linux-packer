# ep-p22-zsom-linux-packer

This branch adds the LWB5+ Backport to the Kernel. The Backport contains kernel modules, configuration and firmware. See Folder `stage` for details.

Documentation

- for ZSOM user installation see [installation.md](./doc/installation.md)
- for Kernel and Backport build, see [build.md](./doc/build.md)


## create package

- compile kernel as described [here](./doc/build.md#kernel)
- modify control/control to your need
- run `./build_opkg.sh ${KERNEL_PATH} `
- copy package to target
- install `opkg install ./package.ipkg`
