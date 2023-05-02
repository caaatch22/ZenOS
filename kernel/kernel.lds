OUTPUT_ARCH( "riscv" )
OUTPUT_FORMAT( "elf64-littleriscv" )
ENTRY( _entry )
BASE_ADDRESS = 0x80200000; /*specified by sbi compiling parameter*/

SECTIONS
{
  . = BASE_ADDRESS;
  .text . : {
    *(.text.entry)
    *(.text .text.*)
    . = ALIGN(4K);
/*
    PROVIDE(_trapforward = .);
    *(.trapforwardsec)
    . = ALIGN(4K);
    ASSERT(( . - _trapforward ) == 4K, "err : trapforward sector is larger than 4K" );
*/
    PROVIDE(etext = .);
  }

  .rodata : {
    . = ALIGN(16);
    *(.srodata .srodata.* .rodata .rodata.*)
  }

  .data : {
    . = ALIGN(16);
    *(.sdata .sdata.* .data .data.*)
  }

  .bss : {
    . = ALIGN(16);
    PROVIDE(bss = .);
    *(.sbss .sbss.* .bss .bss.*)
    . = ALIGN(16);
    PROVIDE(ebss = .);
  }

  PROVIDE(end = .);
}
