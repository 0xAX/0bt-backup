/*
 * -*- Mode: c++; indent-tabs-mode: t -*-
 *
 * This file is part of 0bt. For more info see COPYING.
 *
 */

// write_string() should have the same address. This one function
// is most needed in drivers.
extern char inittext_begin[];

void __attribute__((section(".inittext"))) write_string(int colour, const char *string)
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
	write_string(7, "Protected mode is enabled");

	__asm__("hlt");
}

extern "C" {
void pm() { setup_pm(); }
}
