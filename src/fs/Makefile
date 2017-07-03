#  -*- Mode: makefile; indent-tabs-mode: t -*-
#
#  This file is part of 0bt. For more info see COPYING.

include $(TOPDIR)/Makefile.common

CXX_FLAGS  = -std=c++14
CXX_FLAGS += -fno-rtti -fno-strict-aliasing -fno-pic -fno-exceptions
CXX_FLAGS += -fno-stack-protector -fno-delete-null-pointer-checks
CXX_FLAGS += -fno-toplevel-reorder
CXX_FLAGS += -nostdlib -c

CXX_ARCH_32_BIT_ENTRY = --entry stage1_main
CXX_ARCH_32_BIT_FLAGS += -march=i386 -m32 -mregparm=3

ifdef USE_FAT_FS
FS_OBJECTS += fat.o
endif

all: fs

fs: $(FS_OBJECTS)

%.o : %.cpp
	$(QUIET_CC) $(CXX) $(CXX_FLAGS) $(CXX_ARCH_32_BIT_FLAGS) \
	$(CXX_ARCH_32_BIT_ENTRY)  $< -o $@

$(CLEAN):
	$(QUIET_OBJS_CLEAN) $(RM) $(FS_OBJECTS)
