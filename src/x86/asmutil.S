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
	.globl goto_pm

	.globl _start

_start:
/*
 * BIOS call "INT 0x10 Function 0x0E" to display a character on the screen,
 * advancing the cursor and scrolling the screen as necessary.
 *
 *      Call with       %ah = 0x0e
 *                      %al = an ASCI character
 *                      %bh = page number
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
 *     Call with        %ah = 0x02
 *                      %bx = row number
 *                      %dx = col number
 *
 * The second call: scrolls up window to clear screen -
 *
 *     Call with        %ah = 0x06
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

goto_pm:
	cli

	lgdt gdt_init

	movl %cr0, %eax
	orl  $0x1, %eax
	movl %eax, %cr0

	ljmp $0x08, $pm_entry

	.code32
pm_entry:
	xorl %eax, %eax
	movl $0x10, %eax
	movl %eax, %ds
	movl %eax, %ss

	/* TODO null them, we don't need in them */
	movl %eax, %es
	movl %eax, %fs
	movl %eax, %gs

	movl $0xffff, %esp
	movl $0xffff, %ebp

	ljmp $0x08, $(pm)

.align 16
.global gdt
gdt:
	.word	0,0,0,0				# reserved
	.word	0xffff, 0x0000, 0x9a00, 0x00cf	# code seg 1 - kernel flat 4GB code
	.word	0xffff, 0x0000, 0x9200, 0x00cf	# data

gdt_init:
	.word	gdt_init-gdt
	.long	gdt
