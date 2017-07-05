/*
 * -*- Mode: c++; indent-tabs-mode: t -*-
 *
 * This file is part of 0bt. For more info see COPYING.
 */

#include "console.hpp"

static unsigned short line = 0;
static unsigned short column = 0;

void putchar(char ch)
{
	if (line == 40)
	{
		/* TODO clear screen and go up */
	}

	if (ch == '\n')
	{
		line += 2;
		column = 0;
		return;
	}

	volatile char *video = (volatile char *)0xB8000 + (line * 80) + column;

	*video++ = ch;
	*video++ = 7;
	column += 2;

	if (column == 160)
		column = 0;
}

void write_string(const char *str)
{
	while (*str != 0)
		putchar(*str++);
}
