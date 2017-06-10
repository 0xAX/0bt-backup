/* -*-Asm-*- */

        .file "stage1.S"

        /* Tell GNU as to generate 16-bit code as we are in real mode */
        .code16

        .section .text
stage1:
        mov $'b',  %al
        mov $0x0e, %ah
        mov $0x00, %bh
        mov $0x07, %bl

        int $0x10
        hlt

