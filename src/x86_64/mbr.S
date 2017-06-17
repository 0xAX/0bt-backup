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

        movw %ax, %dx
        movw %ax, %ss
        movw $ENTRY_POINT, %sp

        /* Ok, the stack is set up, now we can enable interrupts */
        sti

        /* Loading of secondary bootloader */
        hlt

        /* Call secondary bootloader */
        call 0x7e00
