/*
 * -*- Mode: c++; indent-tabs-mode: t -*-
 *
 * This file is part of 0bt. For more info see COPYING.
 */

#include "console.hpp"

void write_string(int colour, const char *string)
{
	volatile char *video = (volatile char *)0xB8000;

	while (*string != 0)
	{
		*video++ = *string++;
		*video++ = colour;
	}
}
