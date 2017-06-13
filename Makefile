#
# Define V=1 for a more verbose build.
#
# Define DEBUG=1 for compilation in debug mode.
#
# Define DISK_IMAGE = name.img to change default name of a disk image.
#
# Define DISK_SIZE = 1G to set an image size. Default is 4G.

include Makefile.common

.PHONY: $(HELP) $(CLEAN)

.DEFAULT_GOAL: $(DEFAULT)

$(DEFAULT): $(BUILD_BOOTLOADER) $(BUILD_IMAGE)

$(BUILD_IMAGE):
	@$(MAKE) $(MAKE_FLAGS) --makefile=mk/Makefile.img TOPDIR=$(shell pwd)

$(BUILD_BOOTLOADER):
	@$(MAKE) $(MAKE_FLAGS) -C src/ TOPDIR=$(shell pwd)

$(CLEAN):
	@$(MAKE) $(MAKE_FLAGS) -C src/ TOPDIR=$(shell pwd) $@
	@$(MAKE) $(MAKE_FLAGS) --makefile=mk/Makefile.img TOPDIR=$(shell pwd) $@

$(HELP):
	@echo "Common build targets:"
	@echo "  * image - Create an empty disk.img image."
	@echo 'Cleaning targets:'
	@echo '  * clean - Remove most generated files, images and so on.'
	@echo "Miscellaneous targets:"
	@echo '  * help      - Print this output.'
