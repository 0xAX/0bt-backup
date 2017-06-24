/*
 * -*- Mode: asm; indent-tabs-mode: t -*-
 *
 * This file is part of 0bt. For more info see COPYING.
 *
 * This is the entry point of the 0bt in a case when Master boot record
 * is used.
 *
 * This code implements a Master Boot Record (MBR) for an Intel/PC disk.
 * A Master Boot Record (MBR) is the bootsector of a hard disk. It should
 * occupy exatly 512 bytes.
 *
 * Due to we can't do anything useful with only 512 bytes of code, the
 * main goal of the mbr.S is only to load second part of bootloader.
 *
 * The code should be called with CS:IP 0x0000:0x7c00.
 *
 * %dl register contains drive number
 * %si register contains pointer to partition table from which we are loaded.
 */
        .file "mbr.S"

        /* Tell GNU as to generate 16-bit code as we are in real mode */
        .code16

        .section ".boothdr", "ax"
	.globl	_start
_start:
        /* we are not safe so, let's turn off interrupts */
        cli

        /* clear segment registers to set them to known values */
        xorw %ax, %ax
        movw %ax, %ds
        movw %ax, %es

        /*
         * setup stack. the top of the stack will be right before
         * we were loaded
         */
        movw %ax, %ss
        movw $ENTRY_POINT, %sp

        /* Ok, the stack is set up, now we can enable interrupts */
        sti

        /* enable A20 gate */
        inb  $0x92, %al
        orb  0x02, %al
        outb %al, $0x92

        /* TODO add description here */
read_second_stage:
        movb $0x42, %ah
	movw $disk_address_packet, %si
        int  $0x13

        /* Call secondary bootloader */
        jmp $0x0000,$0x7e00

        /* TODO add description */
disk_address_packet:
size:
        .byte 0x10
null:
        .byte 0x00
count:
        .byte 0x01
        .byte 0x00
offset:
        .word 0x7e00
segment:
        .word 0x0000
lba:
        .int 0x00000001
lba48:
        .int 0x00000000
