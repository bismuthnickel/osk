gdt_start:
    ; Null descriptor (8 bytes)
    dd 0x0              ; First 4 bytes
    dd 0x0              ; Second 4 bytes

    ; Code segment descriptor (8 bytes)
    dw 0xFFFF           ; Limit (low 16 bits)
    dw 0x0000           ; Base (low 16 bits)
    db 0x00             ; Base (next 8 bits)
    db 10011010b        ; Access byte: Present, Ring 0, Executable, Code segment
    db 11001111b        ; Flags: Granularity=4KB, 32-bit segment, Limit (high 4 bits)
    db 0x00             ; Base (high 8 bits)

    ; Data segment descriptor (8 bytes)
    dw 0xFFFF           ; Limit (low 16 bits)
    dw 0x0000           ; Base (low 16 bits)
    db 0x00             ; Base (next 8 bits)
    db 10010010b        ; Access byte: Present, Ring 0, Read/Write, Data segment
    db 11001111b        ; Flags: Granularity=4KB, 32-bit segment, Limit (high 4 bits)
    db 0x00             ; Base (high 8 bits)

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1; Limit of GDT
    dd gdt_start               ; Base of GDT
