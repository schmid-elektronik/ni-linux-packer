# ni-linux-packer x86
- refers to this kernel [origin/nilrt/20.5/4.14/memtest](https://github.com/schmid-elektronik/ni-linux/tree/origin/nilrt/20.5/4.14/memtest)

- create an opkg package from ni-linux branches 20.0 and newer kernel
- kernel, modules and header 
- activates memtest in kernel bootarguments

## create package

- compile kernel as described in main branch
- modify control/control to your need
- run `./build_opkg.sh ${KERNEL_PATH} `
- copy package to target 
- install `opkg install ./package.ipkg`
