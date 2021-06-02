#!/bin/bash
# PURPOSE
# Build a kernel update opkg package
#  - get files from ni-install 
#  - build opkg
#  - cleanup

if [[ $1 == "" || $1 == "-h" ]]; then
    echo "this script builds an opkg package to update the ni kernel"
    echo "usage: "
    echo " - build kernel (refer to main branch for doc)"
    echo " - update control/control to your needs"
    echo " - build opkg with:"
    echo "     $0 path-to-kernel"
    exit 0 
else
    KERNEL_ROOT=$1
    echo "build opkg from $KERNEL_ROOT"
fi

#--------------------------------------------#
# config src
SRC_FOLDER_STAGE="./stage"
KERNEL_RELEASE="$(cat ${KERNEL_ROOT}/include/config/kernel.release)"
SRC_FILE_KERNEL="${KERNEL_ROOT}/ni-install/arm/boot/ni_zynq_custom_runmodekernel.itb"
SRC_FOLDER_MODULES="${KERNEL_ROOT}/ni-install/arm/lib/modules/${KERNEL_RELEASE}"
SRC_FILE_HEADERS="${KERNEL_ROOT}/ni-install/arm/headers/module-versioning-image.squashfs"

# config target
TARGET_FOLDER="./data"
TARGET_FILE_KERNEL="./data/boot/linux_runmode.itb"
TARGET_FOLDER_MODULES="./data/lib/modules/"
TARGET_FILE_VERSIONING="./data/usr/local/natinst/tools/module-versioning-image.squashfs"

#--------------------------------------------#
echo "### copy staged kernel and firmware files"
cp -r $SRC_FOLDER_STAGE $TARGET_FOLDER
mv $TARGET_FOLDER_MODULES/KERNEL_VERSION $TARGET_FOLDER_MODULES/$KERNEL_RELEASE 

#--------------------------------------------#
echo "### get files from ni-install folders"
## linux kernel
mkdir -p $(dirname $TARGET_FILE_KERNEL)
cp $SRC_FILE_KERNEL $TARGET_FILE_KERNEL
test $? -ne 0 && echo "### failed to get runmode kernel" && exit 1

## kernel modules
mkdir -p $TARGET_FOLDER_MODULES
cp -r $SRC_FOLDER_MODULES $TARGET_FOLDER_MODULES
test $? -ne 0 && echo "### failed to get kernel modules" && exit 1
# remove symbolic links
rm -r $TARGET_FOLDER_MODULES/${KERNEL_RELEASE}/{build,source}

## ni versioning tools
mkdir -p $(dirname $TARGET_FILE_VERSIONING)
cp $SRC_FILE_HEADERS $TARGET_FILE_VERSIONING
test $? -ne 0 && echo "### failed to ni module versionig" && exit 1

#--------------------------------------------#
echo "### build opkg package, note you may want to use opkg utils, see link in script"
# https://forums.ni.com/t5/NI-Linux-Real-Time-Documents/NI-Linux-Real-Time-and-opkg-Introduction-to-ipks/ta-p/4014793?profile.language=en

## set kernel version in postinst script
sed -i "s/^KERNEL_VERSION=.*/KERNEL_VERSION=${KERNEL_RELEASE}/g" ./control/postinst

## get config
PKG_VERSION=$(cat ./control/control | grep Version: | sed -e "s/^Version://" | tr -d [:space:])
PKG_NAME=$(cat ./control/control | grep Package: | sed -e "s/^Package://" | tr -d [:space:])

tar --group=root --owner=root -czvf control.tar.gz -C ./control ./ > /dev/null
test $? -ne 0 && echo "### failed commpressing control" && exit 1

tar --group=root --owner=root -czvf data.tar.gz -C ./data ./ > /dev/null
test $? -ne 0 && echo "### failed commpressing data" && exit 1

echo "2.0" > debian-binary
mkdir -p ./${PKG_NAME}_${PKG_VERSION}/
ar rc ./${PKG_NAME}_${PKG_VERSION}/${PKG_NAME}_${PKG_VERSION}.ipk debian-binary data.tar.gz control.tar.gz
test $? -ne 0 && echo "### failed commpressing package" && exit 1

gzip -c ./control/control > ./${PKG_NAME}_${PKG_VERSION}/Packages.gz
test $? -ne 0 && echo "### failed commpressing package info" && exit 1

#--------------------------------------------#
echo "### cleanup"
rm control.tar.gz
rm data.tar.gz

rm debian-binary

rm -r ./data

echo "### success, copy ${PKG_NAME}_${PKG_VERSION}.ipk to your target or feed"
