/*
 * -*- Mode: c++; indent-tabs-mode: t -*-
 *
 * This file is part of 0bt. For more info see COPYING.
 *
 */

#include "fat.hpp"

extern void write_string(const char *str);

void init_fs()
{
	write_string("Fat module is loaded");
	return;
}
