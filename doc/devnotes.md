# Manual Kernel installation

Usually you can use the ipkg build script in the respective Branch. But in case you have fun installing the new Kernel manually, here is how it goes.

## copy Kernel to Target

```bash
# ARM only
scp ${KERNEL_ROOT}/ni-install/arm/boot/ni_zynq_custom_runmodekernel.itb \
    admin@${rt_target_hostname}:/boot/linux_runmode.itb

# x86_64 only
scp ${KERNEL_ROOT}/ni-install/x86/boot/bzImage \
    admin@${rt_target_hostname}:/boot/runmode/

# Copy kernel modules
scp -r ${KERNEL_ROOT}/ni-install/${ARCH}/lib/modules/ \
       admin@${rt_target_hostname}:/lib/modules/${VERSION}/
# Note that the newly-built modules directory contains symbolic links to the
# build and source directories; do not copy the linked directories to your
# target.
```



## Branches 20.0 and newer

Uses DKMS

```bash
# copy headers from host
cd /{KernelRoot}/ni-install/x86_64/headers/
unsquashfs module-versioning-image.squashfs
scp -r squashfs-root/kernel/ admin@${TargetIP}:/lib/modules/${KernelVersion}

# on target install proprietary modules
dkms autoinstall
dkms status
```



## Branches 19.1 and older

Uses some custom versioning Tools

```bash 
# Copy headers squashfs
scp ${KERNEL_ROOT}/ni-install/${ARCH}/headers/headers.squashfs \
    admin@${rt_target_hostname}:/usr/local/natinst/tools/module-versioning-image.squashfs
    
# Reboot the target and check that the target successfully boots. 
# check that your kernel is running 
uname -a

# update NI drivers to work with the new kernel.
source /usr/local/natinst/tools/versioning_utils.sh
setup_versioning_env
versioning_call /usr/local/natinst/nikal/bin/updateNIDrivers $(kernel_version)
```


