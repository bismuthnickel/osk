[org 0x7e00]

jmp _start

%include "src/lib/gdt.asm"

[bits 16]
_start:
    cli                     ; Disable interrupts for setup

    ; Set VGA text mode (80x25)
    ; mov ah, 0x00            ; BIOS function: Set video mode
    ; mov al, 0x03            ; VGA text mode
    ; int 0x10

    ; Load GDT
    lgdt [gdt_descriptor]   ; Load GDT descriptor
    mov eax, cr0
    or eax, 0x1             ; Set PE bit to enter protected mode
    mov cr0, eax

    ; Long jump to protected mode
    jmp 0x08:pm32main       ; Load CS with code segment selector (0x08)

[bits 32]
pm32main:
    cli                     ; Clear interrupts (for safety during setup)
    mov ax, 0x10            ; Load data segment selector (0x10 from GDT)
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    ; Write 'P' with white text on black background to video memory
    mov ax, 0x0700         ; Character 'P' (0x50) with attribute (0x0F)
    mov al, "P"
    mov ebx, 0xB8000        ; Video memory base address
    mov word [ebx], ax      ; Write character and attribute
    add ebx, 4
    mov al, "e"
    mov word [ebx], ax      ; Write character and attribute

halt:
    jmp halt

times (512)*7 db 0