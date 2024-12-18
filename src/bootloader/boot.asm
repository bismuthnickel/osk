[org 0x7c00] ; code is loaded in at 0x7c00
[bits 16] ; 16 bits

jmp _16bit

gdt_start:
    ; null descriptor (entry 0) - not used, but required
    dq 0x0000000000000000
    
    ; code segment descriptor (entry 1)
    dq 0x00CF9A000000FFFF
    
    ; data segment descriptor (entry 2)
    dq 0x00CF92000000FFFF

gdt_end:

gdt_ptr:
    dw gdt_end - gdt_start - 1      ; limit
    dd gdt_start                    ; base address

drive_number: db 0

_16bit:
    mov [drive_number], dl
    mov ah, 0
    mov al, 3
    int 0x10
.diskread:
    mov ah, 2
    mov al, 64
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, [drive_number]
    mov bx, 0x7e00
    int 0x13
.enter32bits:
    lgdt [gdt_ptr] ; load gdt
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp 0x08:_32bit ; jump to _32bit

[bits 32]
_32bit:
    cli
    mov ax, 0x10      ; load the data segment selector (entry 2 of the GDT)
    mov ds, ax        ; set DS
    mov es, ax        ; set ES
    mov fs, ax        ; set FS
    mov gs, ax        ; set GS
    mov ss, ax        ; set SS
    mov esp, 0x90000
    jmp 0x7e00

jmp $

times 510-($-$$) db 0
dw 0xaa55