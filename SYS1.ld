OUTPUT_FORMAT(elf32-i386)
SECTIONS
 {
   . = 0xa601;
   .text : { *(.text) }
   .data : { *(.data) }
   .bss  : { *(.bss)  }
 }