# TODO

## Build

  * Add `pdfdocs` target to makefile when `Documentation` will be filled with at
least one document.
  * Add better description to `make image` target in `make help` output.
  * Add `Vagrantfile`.

## initrd

  * Add a target for building new initrd.
  * Put default initrd in `./initrds`.

## Debugging

  * Try to use tmux for creating two sessions. One for gdb and the second
for qemu.

## Tools

  * Add `0bt-install` program to install mbr.S to a given disk.

## MBR stage 0

  * Add checks for LBA:

1. are we able to use extended read or not
2. was reading successful or not

  * Fallback to reading using CHS.

## Scripts

  * Add script to get current free loop device and make `FORMAT_FAT_IMAGE`
target more configurable.

## Other

  * Add `Contributing.md`.
  * Add `clang-format`.