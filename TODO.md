# TODO

## Build

  * Check if `CXX` is not set, set `g++` by default in Makefile.common
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

## Scripts

  * Add script to get current free loop device and make `FORMAT_FAT_IMAGE`
target more configurable.

## Other

  * Add `Contributing.md`.
  * Add `clang-format`.