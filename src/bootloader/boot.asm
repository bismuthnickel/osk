[org 0x7c00]
[bits 16]

; jump to entry point
jmp _start

; declare headers or something up here
osk_header:
    dq 0
    dq 0
    db "OSK"
    dd 0
    db "The Open Source Kernel"
    dq 0
    db "Created by a couple of people"
    dd 0
    db "just me and me :/"
    dq 0
    dq 0

_start:
    xor ax, ax ; we cant directly write to segment registers so we use ax.
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7bff ; stack grows down so we put it's origin right before our code

    mov [drive_num], dl

    mov si, msg_loading ; set si to the address of our message
    mov dl, 0 ; set the string to be terminated by null character
    call puts

    ; AH = 02h
    ; AL = number of sectors to read (must be nonzero)
    ; CH = low eight bits of cylinder number
    ; CL = sector number 1-63 (bits 0-5)
    ; high two bits of cylinder (bits 6-7, hard disk only)
    ; DH = head number
    ; DL = drive number (bit 7 set for hard disk)
    ; ES:BX -> data buffer

    mov ah, 0x02
    mov al, 64
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, [drive_num]
    mov bx, 0x7e00
    int 0x13

    call 0x7e00

    jmp halt
halt:
    jmp halt

; functions and routines
%include "src/functions/puts.asm" ; we have to include the src/functions/ because this is relative to the makefile

jmp $ ; bad idea to let our program run past our code. put this here just in case a function forgets to return or something

; declare data
msg_loading: db "loading sectors 2-4", 0x0d, 0x0a, 0x00
drive_num: db 0

times 510-($-$$) db 0
db 0x55, 0xaa