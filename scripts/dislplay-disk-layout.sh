#!/bin/bash

DEFAULT_DISK_IMAGE_NAME=disk.img

if [[ "$#" -eq 0 ]];
then
    if [[ -f $DEFAULT_DISK_IMAGE_NAME ]]; then
        if [[ "$(id -u)" -eq "0" ]]; then
            fdisk -l $DEFAULT_DISK_IMAGE_NAME
            exit 0
        else
            sudo fdisk -l $DEFAULT_DISK_IMAGE_NAME
            exit 0
        fi
    fi
fi

if [[ "$#" -eq 1 ]];
then
    if [[ -f $1 ]]; then
        if [[ "$(id -u)" -eq "0" ]]; then
            fdisk -l $1
            exit 0
        else
            sudo fdisk -l $1
            exit 0
        fi
    fi
fi

echo "display-disk-layout.sh - display disk layout."
echo "Usage:"
echo "  * name - disk with the given name will be used."
echo "  * no arguments - default $DEFAULT_DISK_IMAGE_NAME will be taken."

exit 0
