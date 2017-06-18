#  -*- Mode: makefile; indent-tabs-mode: t -*-
#
#  This file is part of 0bt. For more info see COPYING.

include $(TOPDIR)/Makefile.common

.DEFAULT_GOAL: $(DEFAULT)

$(DEFAULT): 0bt-install

0bt-install-bin = 0bt-install
0bt-install-srcs = 0bt-install.cpp

0bt-install: $(0bt-install-srcs)
	$(CXX) $(0bt-install-srcs) -o $(TOPDIR)/$(0bt-install-bin)
