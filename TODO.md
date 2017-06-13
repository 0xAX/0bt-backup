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

## Scripts

  * Check a disk existance before execution of fdisk in
`scripts/dislplay-disk-layout.sh` and other scripts which use
`sudo`.
  * Use `sudo(8)` only if we are not root in all scripts.
  * Add `check-deps` script to check existance of tools that we are
using during build/testing.

## Tools

  * Add `0bt-install` program to install mbr.S to a given disk.

## Other

  * Add `Contributing.md`.