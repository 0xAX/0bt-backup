OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
OUTPUT_ARCH(i386)
ENTRY(stage1_main)

SECTIONS
{
        . = 0x7e00;
        
        .text :
        {
                *(.text)
        }

        .data : { *(.data) *(.rodata) *(.bss) }
 
        _end = .;

        /DISCARD/ : { *(.eh_frame .comment) }
}
