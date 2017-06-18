#  -*- Mode: makefile; indent-tabs-mode: t -*-
#
#  This file is part of 0bt. For more info see COPYING.
#
#  Define V=1 for a more verbose build.
#
#  Define DEBUG=1 for compilation in debug mode.
#
#  Define DISK_IMAGE = name.img to change default name of a disk image.
#
#  Define DISK_SIZE = 1G to set an image size. Default is 4G.

include Makefile.common

.PHONY: $(HELP) $(CLEAN) $(TOOLS)

.DEFAULT_GOAL: $(DEFAULT)

VERSION = "0.0.1"
IMG_MAKEFILE=--makefile=mk/Makefile.img

$(DEFAULT): $(BUILD_BOOTLOADER) $(BUILD_IMAGE)

$(BUILD_IMAGE):
	@$(MAKE) $(MAKE_FLAGS) $(IMG_MAKEFILE) TOPDIR=$(shell pwd)
	@$(MAKE) $(MAKE_FLAGS) $(IMG_MAKEFILE) TOPDIR=$(shell pwd) $(CREATE_DISK_PARTITIONS)
	@$(MAKE) $(MAKE_FLAGS) $(IMG_MAKEFILE) TOPDIR=$(shell pwd) $(FORMAT_FAT_IMAGE)

$(BUILD_BOOTLOADER):
	@$(MAKE) $(MAKE_FLAGS) -C src/ TOPDIR=$(shell pwd)

$(TOOLS):
	@$(MAKE) $(MAKE_FLAGS) -C tools TOPDIR=$(shell pwd)

# TODO this should be made by the 0bt-install util in future
$(INSTALL):
	dd if=src/x86_64/boot0_x86_64.bin of=disk.img conv=notrunc bs=446 count=1
	dd if=src/x86_64/boot0_x86_64.bin of=disk.img conv=notrunc skip=1 count=1 seek=1 ibs=512

$(CLEAN):
	@$(MAKE) $(MAKE_FLAGS) -C src/ TOPDIR=$(shell pwd) $@
	@$(MAKE) $(MAKE_FLAGS) $(IMG_MAKEFILE) TOPDIR=$(shell pwd) $@

$(HELP):
	@echo "Common build targets:"
	@echo "  * image - Create an empty disk.img image."
	@echo 'Cleaning targets:'
	@echo '  * clean - Remove most generated files, images and so on.'
	@echo "Miscellaneous targets:"
	@echo '  * help      - Print this output.'
