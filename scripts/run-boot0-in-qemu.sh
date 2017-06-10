#!/bin/bash

make all && \
qemu-system-x86_64 ./src/x86_64/boot0_x86_64.bin
