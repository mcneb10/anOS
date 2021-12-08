ENTRY(boot)
OUTPUT_FORMAT("binary")

SECTIONS {
   . = 0x7c00;
   .bootloader : {
    /opt/anos/main.o
   }
  /* . = 0xa601;*/
   .kernel : {
    /opt/anos/SYS1.o
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
