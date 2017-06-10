/* -*-Asm-*- */

/*
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
 */
        
        .file "mbr.S"

        /* Tell GNU as to generate 16-bit code as we are in real mode */
        .code16

        .section ".boothdr", "ax"
	.globl	_start
_start:
        /*
         * Normally we should be loaded at 0x0000:0x7c00, but
         * some buggy BIOSes begin execution at 07c0:0000.
         *
         * To fix this oddity, we execute a long jump at the
         * predefined address.
         */
        ljmp $0x0000,$_start2
_start2:
        /* we are not safe so, let's turn off interrupts */
        cli

        /* clear segment registers to set them to known values */
        xorl %eax, %eax

        movw %ax, %ds
        movw %ax, %es

        /* TODO setup stack */
        movw %ax, %ss

        sti

        /* Loading of secondary bootloader */

        /* Call secondary bootloader */
        call 0x7e00
