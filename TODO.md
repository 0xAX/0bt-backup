# TODO

## Build

  * Add `pdfdocs` target to makefile when `Documentation` will be filled with at
least one document.
  * Add `Vagrantfile`.

## Tools

  * Add `0bt-install` program to install mbr.S to a given disk.
  * The `0bt-install` should determine filesystem of a boot partition
and put fs module to disk to. The stage1 will will load it to load other
modules and configuration file.

## MBR stage 0

  * Add checks for LBA:

1. are we able to use extended read or not
2. was reading successful or not

  * Fallback to reading using CHS.
  * Calculate size of `stage1` during compilation and pass it to LBA.
  * Use green foreground.

## Stage 1

  * Add `-DSERIAL_CONSOLE` support.
  * Setup IDT in protected mode.
  * Move `pm_entry` to C code.
  * Move `write_string()` into IO mod.
  * Add support for formatting to `write_string()`.
  * Add scroll up to putchar.

## Other

  * Add `Contributing.md`.
  * Add `clang-format`.