OUTPUT_FORMAT(elf32-i386)
ENTRY(main)
SECTIONS
 {
   . = 0x7c00;
   .text : { main.o(.text) }
   .data : { main.o(.data) }
   .bss  : { main.o(.bss)  }
   . = 0xa601;
   .text : { SYS1.o(.text) }
   .data : { SYS1.o(.data) }
   .bss  : { SYS1.o(.bss)  }
 }