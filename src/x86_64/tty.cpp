/*
 * -*- Mode: c++; indent-tabs-mode: t -*-
 *
 * This file is part of 0bt. For more info see COPYING.
 *
 * This source code file provides API for input/output
 * via different sources/destinations like BIOS, serial
 * I/O and etc.
 */

#include "stage1.hpp"

void bios_print_string(const char *str)
{
	while (*str)
		print_char(*str++);
}
