/*
 * -*- Mode: c++; indent-tabs-mode: t -*-
 *
 * This file is part of 0bt. For more info see COPYING.
 *
 * Entry point of stage 1.
 */

#include "stage1.hpp"

const char *greetings = "Hello from 0bt!";

/*
 * Executes switch to protected mode. For this purpose we need:
 *
 *   1. Disable interrupts
 *   2. Create and Load GDT
 *   3. Create and Load IDT with null limit to prevent real mode IDT
 *      from being used in protected mode
 *   4. Set the PE bit of the MSW or CR0 register
 *   5. Execute a far jump
 *   6. Load data segment registers with valid selector(s) to prevent GP
 *      exceptions when interrupts happen
 *   7. Load new valid stack
 *   8. Load an IDT
 *   9. Enable Interrupts
 *
 * We are in protected mode.
 *
 */
static void goto_pm()
{
	__asm__("cli");
	__asm__("sti");
}

extern "C" {
void stage1_main()
{
	clear_screen();
	bios_print_string(greetings);
	goto_pm();
}
}
