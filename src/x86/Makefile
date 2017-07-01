#  -*- Mode: makefile; indent-tabs-mode: t -*-
#
#  This file is part of 0bt. For more info see COPYING.

include $(TOPDIR)/Makefile.common

#
# boot sector objects
#
MBR = stage0/mbr.o

#
# stage1 objects
#
STAGE1_OBJECTS += stage1.o
STAGE1_OBJECTS += tty.o
STAGE1_OBJECTS += protmode.o
STAGE1_OBJECTS += asmutil.o

#
# linker scripts
#
MBR_LINKER_SCRIPT = stage0/mbr.lds
STAGE1_LINKER_SCRIPT = stage1.lds

#
# linker flags
#
MBR_LD_FLAGS = -nostdlib --oformat binary -T$(MBR_LINKER_SCRIPT)
STAGE1_LD_FLAGS = -nostdlib --oformat binary -T$(STAGE1_LINKER_SCRIPT)

#
# Flags for 16bit assembler code
#
AS_FLAGS = -march=i386 -m16 -Wall -ffreestanding -c

#
# Flags for C++ compiler
#
CXX_FLAGS  = -std=c++14
CXX_FLAGS += -fno-rtti -fno-strict-aliasing -fno-pic -fno-exceptions
CXX_FLAGS += -fno-stack-protector -fno-delete-null-pointer-checks
CXX_FLAGS += -fno-toplevel-reorder
CXX_FLAGS += -nostdlib --entry stage1_main -c

CXX_ARCH_32_BIT_FLAGS += -march=i386 -m32 -mregparm=3
CXX_ARCH_64_BIT_FLAGS += -mcmodel=small -m64

all: $(STAGE1) $(STAGE0)

$(STAGE0): $(MBR)
	$(QUIET_LD) $(LD) $(MBR_LD_FLAGS) $(MBR) -o $(STAGE0)

$(STAGE1): $(STAGE1_OBJECTS)
	$(QUIET_LD) $(LD) $(STAGE1_LD_FLAGS) $(STAGE1_OBJECTS) -o $(STAGE1)

$(MBR): stage0/mbr.S
	$(eval STAGE1_SIZE = $(shell wc -c $(STAGE1) | sed -e 's/\s.*//'))
	$(eval SECTORS = $(shell echo $(STAGE1_SIZE) / 512 + 1 | bc))
	$(QUIET_CC) $(CC) -DSTAGE1_SECTORS_SIZE=$(SECTORS) $(AS_FLAGS) $< -o $@

%.o : %.S
	$(QUIET_CC) $(CC) $(AS_FLAGS) $< -o $@

%.o : %.cpp
	$(QUIET_CC) $(CXX) $(CXX_FLAGS) $(CXX_ARCH_32_BIT_FLAGS) $< -o $@

$(CLEAN):
	$(QUIET_OBJS_CLEAN) $(RM) $(OBJECT_FILES)
	@echo "    RM stage0/*.o"
	$(RM) stage0/$(OBJECT_FILES)
	$(QUIET_BIN_CLEAN) $(RM) $(BIN_FILES)
