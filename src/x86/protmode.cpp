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
        write_string("Console is enabled\n");
	write_string("Protected mode is enabled\n");

	__asm__("hlt");
}

extern "C" {
void pm() { setup_pm(); }
}
