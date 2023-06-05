import os

TARGET_DIR = "./user/target/bin/"

if __name__ == '__main__':
    f = open("kernel/kernel_app.ld", mode="w")
    apps = os.listdir(TARGET_DIR)
    f.write(
'''OUTPUT_ARCH(riscv)
ENTRY(_entry)
OUTPUT_FORMAT( "elf64-littleriscv" )
BASE_ADDRESS = 0x80200000;

SECTIONS
{
    . = BASE_ADDRESS;
    skernel = .;

    s_text = .;
    .text . : {
        *(.text.entry)
        *(.text .text.*)
        . = ALIGN(4K);
        PROVIDE(_trapforward = .);
        *(.trapforwardsec)
        . = ALIGN(4K);
/*
        ASSERT(( . - _trapforward ) == 4K, "err : trapforward sector is larger than 4K" );
*/
        PROVIDE(etext = .);
    }

    s_rodata = .;
    .rodata : {
        *(.rodata .rodata.*)
    }

    . = ALIGN(4K);
    e_rodata = .;
    s_data = .;
    .data : {
        *(.data)
''')
    for (idx, _) in enumerate(apps):
        f.write('        . = ALIGN(0x1000);\n')
        f.write('        *(.data.app{})\n'.format(idx))
    f.write(
'''
        . = ALIGN(0x1000);
        *(.data.*)
        *(.sdata .sdata.*)
    }
    
    . = ALIGN(4K);
    e_data = .;
    
    .bss : {
        . = ALIGN(16);
        PROVIDE(bss = .);
        *(.sbss .sbss.* .bss .bss.*)
        . = ALIGN(16);
        PROVIDE(ebss = .);
    }

    PROVIDE(ekernel = .);

}
''')
    f.close()

