#  -*- Mode: makefile; indent-tabs-mode: t -*-
#
#  This file is part of 0bt. For more info see COPYING.

include $(TOPDIR)/Makefile.common

all: fs arch

fs:
	@$(MAKE) $(MAKE_FLAGS) -C $(TOPDIR)/$(SRC_DIR)fs all TOPDIR=$(TOPDIR)

arch:
	@$(MAKE) $(MAKE_FLAGS) -C $(TOPDIR)/$(SRC_DIR)$(ARCH) all TOPDIR=$(TOPDIR)

$(CLEAN):
	@$(MAKE) $(MAKE_FLAGS) -C $(TOPDIR)/$(SRC_DIR)$(ARCH) $(CLEAN) TOPDIR=$(TOPDIR)
	@$(MAKE) $(MAKE_FLAGS) -C $(TOPDIR)/$(SRC_DIR)fs $(CLEAN) TOPDIR=$(TOPDIR)

.PHONY: arch fs $(CLEAN)
