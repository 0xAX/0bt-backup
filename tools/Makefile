#  -*- Mode: makefile; indent-tabs-mode: t -*-
#
#  This file is part of 0bt. For more info see COPYING.

include Makefile.common

.DEFAULT_GOAL: $(DEFAULT)

$(DEFAULT): 0bt-install

0bt-install-objs: 0bt-install.o
0bt-install-srcs: 0bt-install.cpp

0bt-install: 0bt-install.cpp
	g++ 0bt-install.cpp -o ../0bt-install
