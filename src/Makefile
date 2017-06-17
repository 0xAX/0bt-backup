#  -*- Mode: makefile; indent-tabs-mode: t -*-
#
#  This file is part of 0bt. For more info see COPYING.

include $(TOPDIR)/Makefile.common

all: $(STAGE0)

$(STAGE0):
	@$(MAKE) $(MAKE_FLAGS) -C $(TOPDIR)/$(SRC_DIR)$(ARCH) all TOPDIR=$(TOPDIR)

$(CLEAN):
	@$(MAKE) $(MAKE_FLAGS) -C $(TOPDIR)/$(SRC_DIR)$(ARCH) $(CLEAN) TOPDIR=$(TOPDIR)
