.section .multiboot
.align 4
.long 0x1BADB002      # magic number
.long 0x0             # flags
.long -(0x1BADB002)   # checksum

.section .text
.global _start
.type _start, @function

_start:
    mov $kernel_main, %eax
    call *%eax
halt:
    cli
    hlt
    jmp halt
