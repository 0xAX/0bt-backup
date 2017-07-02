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

.PHONY: $(HELP) $(CLEAN) $(TOOLS) $(CLEAN_IMAGE) $(CLEAN_ALL) \
	$(BUILD_INITRD) $(CLEAN_INITRD)

.DEFAULT_GOAL: $(DEFAULT)

VERSION = "0.0.1"
IMG_MAKEFILE=--makefile=mk/Makefile.img

$(DEFAULT): $(BUILD_BOOTLOADER)

$(BUILD_IMAGE):
	@$(MAKE) $(MAKE_FLAGS) $(IMG_MAKEFILE) TOPDIR=$(shell pwd)
	@$(MAKE) $(MAKE_FLAGS) $(IMG_MAKEFILE) TOPDIR=$(shell pwd) $(CREATE_DISK_PARTITIONS)
	@$(MAKE) $(MAKE_FLAGS) $(IMG_MAKEFILE) TOPDIR=$(shell pwd) $(FORMAT_FAT_IMAGE)

$(BUILD_BOOTLOADER):
	@$(MAKE) $(MAKE_FLAGS) -C src/ TOPDIR=$(shell pwd)

$(TOOLS):
	@$(MAKE) $(MAKE_FLAGS) -C tools TOPDIR=$(shell pwd) VERSION=$(VERSION)

# TODO this should be made by the 0bt-install util in future
$(INSTALL):
	$(DD) if=src/$(ARCH)/$(STAGE0) of=$(DISK_IMAGE) conv=notrunc bs=446 count=1
	$(DD) if=src/$(ARCH)/$(STAGE1) of=$(DISK_IMAGE) conv=notrunc count=3 seek=1 ibs=512

$(RUN):
	qemu-system-x86_64 -drive format=raw,file=$(DISK_IMAGE)

$(BUILD_INITRD):
	@echo "    GEN initrd"
	@$(MAKE) $(MAKE_FLAGS) -C initrd TOPDIR=$(shell pwd)

$(CLEAN):
	@$(MAKE) $(MAKE_FLAGS) -C src/ TOPDIR=$(shell pwd) $@

$(CLEAN_DISK):
	@$(MAKE) $(MAKE_FLAGS) $(IMG_MAKEFILE) TOPDIR=$(shell pwd) $(CLEAN)

$(CLEAN_INITRD):
	@$(MAKE) $(MAKE_FLAGS) -C initrd TOPDIR=$(shell pwd) $@

$(CLEAN_ALL): $(CLEAN) $(CLEAN_DISK) $(CLEAN_INITRD)

$(HELP):
	@echo "Common build targets:"
	@echo "  * build-boot - build source code (will be runned by default)"
	@echo "  * image - Create an empty disk.img image."
	@echo "  * initrd - Build initrd image."
	@echo "  * run - Run image with installed bootloader in qemu."
	@echo "  * tools - build 0bt utils from 0bt/tools directory."
	@echo
	@echo 'Cleaning targets:'
	@echo '  * clean - Remove executables, object files and so on.'
	@echo '  * clean_image - Remove *.img files.'
	@echo '  * clean_initrd - Remove initrd.img and related files.'
	@echo '  * clean_all - Both clean and clean_image.'
	@echo
	@echo "Miscellaneous targets:"
	@echo '  * help      - Print this output.'
