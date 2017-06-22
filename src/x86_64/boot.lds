OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
OUTPUT_ARCH(i386)
ENTRY(_start)

/* Where BIOS loaded us */
ENTRY_POINT = 0x7c00;
/* Total size in bytes of mbr */
MBR_SIZE = 0x0200;
/* MBR signature */
MAGIC_SIGNATURE = 0xAA55;
/* Size of a MBR signature in bytes */
SIGNATURE_SIZE = 2;
/* Offset to MBR signature */
SIGNATURE_OFFSET = ENTRY_POINT + MBR_SIZE - SIGNATURE_SIZE;
/* Offset to partition table */
PARTITION_TABLE_OFFSET = 0x1be;

SECTIONS
{
        . = ENTRY_POINT;

        .boothdr : AT(ENTRY_POINT)
        {
                *(.header)        
        }

        .signature : AT(SIGNATURE_OFFSET)
        {
                SHORT(MAGIC_SIGNATURE);
        }

        .text :
        {
                *(.text)
        }

        _end = .;
} 
