#!/bin/bash

if [[ $1 == "-h" ]]; then
    echo "this script builds an opkg package "
    echo "usage: "
    echo " - build kernel(module)"
    echo " - copy ath9k_htc.ko manually"
    echo " - update control/control to your needs"
    echo "     $0"
    exit 0 
fi

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

echo "### success, copy ${PKG_NAME}_${PKG_VERSION}.ipk to your target or feed"
