#  -*- Mode: makefile; indent-tabs-mode: t -*-
#
#  This file is part of 0bt. For more info see COPYING.

include $(TOPDIR)/Makefile.common

.PHONY: $(BUILD_INITRD) $(CLEAN_INITRD)

.DEFAULT_GOAL: $(BUILD_INITRD)

$(BUILD_INITRD):
	./initrd.sh $(TOPDIR) $(STD_ERR_OUT_TO_DEV_NULL)

$(CLEAN_INITRD):
	@echo "    RM initrd"
	@$(RM) $(INITRD_FILES)
