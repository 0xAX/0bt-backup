# ∅bt

The `0bt` is a simple linux kernel bootloader written in [️C++](https://en.wikipedia.org/wiki/C%2B%2B) and [assembly](https://en.wikipedia.org/wiki/Assembly_language).

The main purpose of which is to describe the linux kernel [boot protocol](https://www.kernel.org/doc/Documentation/x86/boot.txt) in action and to learn related low level stuff.

**Only `x86_64` architecture is supported now.**

## Building

The following programs and dependencies may be required:

  * [GNU Binutils](https://www.gnu.org/software/binutils/)
  * [GNU Make](https://www.gnu.org/software/make/)
  * [GNU GCC](https://gcc.gnu.org/)
  * [QEMU](http://www.qemu.org/)
  * [util-linux](https://github.com/karelzak/util-linux) for `fdisk`, `losetup` and other utils.
  * [dosfstools](https://github.com/dosfstools/dosfstools) for `mkfs.vfat` and other tools.

To build `0bt` from source code:

```
$ git clone https://github.com/0xAX/0bt
$ cd 0bt
$ make
```

The following options can be passed to make:

  * `V=1` to enable verbose output during build.
  * `DEBUG=1` to enable debug mode.
  * `DISK_IMAGE=name.img` to change default name of a disk image.
  * `DISK_SIZE=4G` to specify image size.
  * `USE_FAT` - to load kernel from FAT32 partition.

`0bt` provides other targets besides the `all` target. For other options see the output of:

```
make help
```

## Usage

**TODO**

## LICENSE

The source code of the `0bt` is under `Apache License 2.0` license.

See [COPYING](https://github.com/0xAX/0bt/blob/master/COPYING) for more details.

The description of how everything works from [Documentation](https://github.com/0xAX/0bt/blob/master/Documentation) is under
[BY-NC-SA Creative Commons](https://creativecommons.org/licenses/by-nc-sa/4.0/) license.

## Contributing

Feel free to send a [pull request](https://help.github.com/articles/about-pull-requests/) if you found something wrong or you have any ideas.

If you don't know where to start, see [TODO.md](https://github.com/0xAX/0bt/blob/master/TODO.md).

If you have any questions or suggestions, feel free to create new [issue](https://github.com/0xAX/0bt/issues/new) or drop me an [email](mailto:kuleshovmail@gmail.com).

## Author

[@0xAX](https://twitter.com/0xAX)