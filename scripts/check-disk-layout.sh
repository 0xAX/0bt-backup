#!/bin/bash

DEFAULT_DISK_IMAGE_NAME=disk.img

if [[ "$#" -eq 0 ]];
then
    sudo fdisk -l $DEFAULT_DISK_IMAGE_NAME
    exit 0
fi

if [[ "$#" -eq 1 ]];
then
    sudo fdisk -l $1
    exit 0
fi

echo "check-disk-layout.sh - display disk layout."
echo "Usage:"
echo "  * name - disk with the given name will be used."
echo "  * no arguments - default $DEFAULT_DISK_IMAGE_NAME will be taken."

exit 0
