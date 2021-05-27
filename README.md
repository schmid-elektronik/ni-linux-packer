# ni-linux-packer x86
- create an opkg package from ni-linux branches 20.0 and newer kernel
- kernel, modules and header 
- activates memtest in kernel bootarguments

## create package

- compile kernel as described in main branch
- modify control/control to your need
- run `./build_opkg.sh ${KERNEL_PATH} `
- copy package to target 
- install `opkg install ./package.ipkg`
