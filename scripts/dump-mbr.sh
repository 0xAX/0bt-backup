#!/bin/bash

MBR_SIZE=512
DEFAULT_DISK_IMAGE_NAME=disk.img

if [[ "$#" -eq 0 ]];
then
    dd if=$DEFAULT_DISK_IMAGE_NAME | hexdump -C -n $MBR_SIZE | less
    exit 0
fi

if [[ "$#" -eq 1 ]];
then
    dd if=$1 | hexdump -C -n $MBR_SIZE | less
    exit 0
fi

echo "display-mbr.sh - display MBR of a given disk"
echo "Usage:"
echo "  * name - disk with the given name will be used."
echo "  * no arguments - default $DEFAULT_DISK_IMAGE_NAME will be taken."

exit 0
