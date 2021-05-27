# ni-linux-packer x86
- create an opkg package from ni-linux branches 20.0 and newer kernel

- generic, plain kernel, modules and header without any additional files

## create package

- compile kernel as described in main branch
- modify control/control to your need
- run `./build_opkg.sh ${KERNEL_PATH} `
- copy package to target 
- install `opkg install ./package.ipkg`
