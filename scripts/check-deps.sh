#!/bin/bash

function check_deb() {
    if [[ -x $1 ]]; then
      echo -e "\e[39m`$1 --version | head $3` \e[32m[OK]"
    else
      echo -e "\e[39m$2 not found \033[31m[NOT OK]"
    fi
}

check_deb /usr/bin/ld ld -n1
check_deb /usr/bin/make make -n1
check_deb /usr/bin/gcc gcc -n1
check_deb /usr/bin/qemu-system-x86_64 qemu-system-x86_64 -n1
check_deb /sbin/fdisk fdisk -n1
check_deb /sbin/losetup losetup -n1
check_deb /sbin/mkfs.ntfs mkfs.ntfs -n2
