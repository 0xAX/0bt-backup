#  -*- Mode: makefile; indent-tabs-mode: t -*-
#
#  This file is part of 0bt. For more info see COPYING.

include $(TOPDIR)/Makefile.common

OBJECTS = mbr.o
OBJECTS += stage1.o

LINKER_SCRIPT = boot.lds

LD_FLAGS = --oformat binary -T$(LINKER_SCRIPT)
AS_FLAGS = -march=i386 -m16 -Wall -ffreestanding -c

all: $(STAGE0)

$(STAGE0): $(OBJECTS)
	$(QUIET_LD) $(LD) $(LD_FLAGS) $(OBJECTS) -o $(STAGE0)

%.o : %.S
	gcc $(AS_FLAGS) $< -o $@

$(CLEAN):
	$(QUIET_OBJS_CLEAN) $(RM) $(OBJECT_FILES)
	$(QUIET_BIN_CLEAN) $(RM) $(BIN_FILES)
