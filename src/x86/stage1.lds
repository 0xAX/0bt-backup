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

        .inittext :
        {
                *(.inittext)
        }

        .data : { *(.data) *(.rodata) *(.bss) }
 
        _end = .;
}
