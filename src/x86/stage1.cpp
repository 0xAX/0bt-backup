/*
 * -*- Mode: c++; indent-tabs-mode: t -*-
 *
 * This file is part of 0bt. For more info see COPYING.
 *
 * Entry point of stage 1.
 */

#include "stage1.hpp"

const char *greetings = "Hello from 0bt!";

extern "C" {
void stage1_main()
{
	clear_screen();
	bios_print_string(greetings);
}
}
