ENTRY(boot)
OUTPUT_FORMAT("binary")

SECTIONS {
   . = 0x7c00;
   .bootloader : {
    main.o
   }
  /* . = 0xa601;*/
   .kernel : {
    SYS1.o
   }

       /DISCARD/ :
    {
        *(.note*);
        *(.iplt*);
        *(.igot*);
        *(.rel*);
        *(.comment);
    }
}
