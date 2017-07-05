/*
 * -*- Mode: c++; indent-tabs-mode: t -*-
 *
 * This file is part of 0bt. For more info see COPYING.
 *
 */

#include "fat.hpp"
#include "console.hpp"

void setup_pm()
{
	write_string(7, "Protected mode is enabled");

#ifdef USE_FAT32_FS
	init_fat_fs();
#endif
	__asm__("hlt");
}

extern "C" {
void pm() { setup_pm(); }
}
