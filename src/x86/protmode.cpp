/*
 * -*- Mode: c++; indent-tabs-mode: t -*-
 *
 * This file is part of 0bt. For more info see COPYING.
 *
 */

#include "fat.hpp"

void write_string(int colour, const char *string)
{
	volatile char *video = (volatile char *)0xB8000;

	while (*string != 0)
	{
		*video++ = *string++;
		*video++ = colour;
	}
}

void setup_pm()
{
	write_string(2, "Protected mode is enabled");

#ifdef USE_FAT_FS
	init_fat_fs();
#endif

#ifdef USE_EXT2_FS
	init_ext2_fs();
#endif

	__asm__("hlt");
}

extern "C" {
void pm() { setup_pm(); }
}
