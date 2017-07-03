/*
 * -*- Mode: c++; indent-tabs-mode: t -*-
 *
 * This file is part of 0bt. For more info see COPYING.
 */

#ifndef STAGE_1_HPP
#define STAGE_1_HPP

__asm__(".code16\n");

/*
 * Assember functions
 */
extern "C" void print_char(char a);
extern "C" void goto_pm();
extern "C" void clear_screen();
extern "C" void move_cursor(unsigned short x, unsigned short y);

/* */
void bios_print_string(const char *str);

#endif /* STAGE_1_HPP */
