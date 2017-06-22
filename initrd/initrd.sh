#!/bin/bash

pushd $1/initrd

mkdir {bin,sys,dev,proc,etc,lib}

# fetch busybox as static lib
pushd bin

wget https://busybox.net/downloads/binaries/1.21.1/busybox-x86_64 -O busybox
chmod +x busybox

ln -s busybox ash
ln -s busybox mount
ln -s busybox echo
ln -s busybox ls
ln -s busybox cat
ln -s busybox ps
ln -s busybox dmesg
ln -s busybox sysctl
ln -s busybox sh
popd

sudo mknod dev/ram0 b 1 1
sudo mknod dev/null c 1 3
sudo mknod dev/tty1 c 4 1
sudo mknod dev/tty2 c 4 2

ln -s bin sbin

find . | cpio -o -H newc | gzip > initrd.img

cp initrd.img $1/initrd.img

popd
