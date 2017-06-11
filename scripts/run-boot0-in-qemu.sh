#!/bin/bash

if [[ "$#" -eq 0 ]];
then
    make all && qemu-system-x86_64 ./src/x86_64/boot0_x86_64.bin
    exit 0
fi

if [[ "$1" = "debug" ]];
then
   make all && qemu-system-x86_64 -s -S ./src/x86_64/boot0_x86_64.bin
   exit 0
fi

echo "run-boot0-in-qemu.sh - runs plain boot0 in qemu"
echo "Usage:"
echo "  * debug - run qemu and open a gdbserver on TCP port 1234."
echo "  * no arguments - run the boot0_x86_64.bin in qemu."

exit 0
