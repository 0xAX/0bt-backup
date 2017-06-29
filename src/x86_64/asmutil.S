/*
 * -*- Mode: asm; indent-tabs-mode: t -*-
 *
 * This file is part of 0bt. For more info see COPYING.
 *
 */
        .file "stage1.S"

        /* Tell GNU as to generate 16-bit code as we are in real mode */
        .code16

        .section .text
        .globl print_char
        .globl clear_screen
        .globl move_cursor
/*
 * BIOS call "INT 0x10 Function 0x0E" to display a character on the screen,
 * advancing the cursor and scrolling the screen as necessary.
 *
 *	Call with	%ah = 0x0e
 *                      %al = an ASCI character
 *			%bh = page number
 *                      %bl = foreground color (only in graphics mode)
 *
 * More info at - http://www.ctyme.com/intr/rb-0106.htm
 */
print_char:
        /*
         * If the write causes the screen to scroll, BP may be destroyed
         * by BIOSes so we preserve it here.
         */
        push %bp
        mov $0x0e, %ah
        mov $0x00, %bh
        mov $0x07, %bl
        int $0x10
        pop %bp
        ret
/*
 * BIOS calls "INT 0x10 Function 0x02" and "INT 0x10 Function 0x06".
 *
 * The first call: moves cursor to the 0:0 -
 *
 *	Call with	%ah = 0x02
 *                      %bx = row number
 *                      %dx = col number
 *
 * The second call: scrolls up window to clear screen -
 *
 *	Call with	%ah = 0x06
 *                      %al = lines to scroll
 *                      %bx = background color and foreground color
 *                      %ch = upper row number
 *                      %cl = left column number
 *                      %dh = lower row number
 *                      %dl = right column number
 */
clear_screen:        
        mov $0x02, %ah
        xor %bx, %bx
        xor %dx, %dx
        int $0x10

        mov $0x06, %ah
        xor %al, %al
        xor %bx, %bx
        mov $0x07, %bh
        xor %cx, %cx
        mov $25, %dh
        mov $80, %dl
        int $0x10
        ret
