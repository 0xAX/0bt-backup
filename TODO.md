# TODO

## Build

  * Add `pdfdocs` target to makefile when `Documentation` will be filled with at
least one document.
  * Add better description to `make image` target in `make help` output.
  * Add `Vagrantfile`.

## Tools

  * Add `0bt-install` program to install mbr.S to a given disk.

## MBR stage 0

  * Add checks for LBA:

1. are we able to use extended read or not
2. was reading successful or not

  * Fallback to reading using CHS.
  * Calculate size of `stage1` during compilation and pass it to LBA.

## Stage 1

  * Add `-DSERIAL_CONSOLE` support.

## Other

  * Add `Contributing.md`.
  * Add `clang-format`.