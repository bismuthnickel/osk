;
; OSBL
;

[org 0x7c00]
[bits 16]

jmp _start
nop

load_into: dw 0x7e00
disk_num: db 0

required_header_thats_required_for_some_reason: db "OSBL"

_start:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7bff
    mov [disk_num], dl
    mov si, msg_0
    mov dl, 0
    call log
    call wait_one_second
    mov si, msg_1
    call log
    cmp dword [required_header_thats_required_for_some_reason], "OSBL"
    jne halt
    call wait_one_second
    mov si, msg_2
    call log
    mov ah, 0x02
    mov al, 64
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, [disk_num]
    mov bx, [load_into]
    int 0x13
    call wait_one_second
    jmp [load_into]
    mov si, msg_fail
    call log

halt:
    jmp $

log:
    push ax
    push bx
    mov ah, 0x0e
    mov bx, 0
.loop:
    mov al, [si]
    add si, 1
    cmp al, dl
    je .return
    int 0x10
    jmp .loop
.return:
    pop bx
    pop ax
    ret

wait_one_second:
    pusha
    mov cx, 0x0f
    mov dx, 0x4240
    mov ah, 0x86
    int 0x15
    popa
    ret

msg_0: db "OSBL", 0x0d, 0x0a, 0
msg_1: db "Verifying header", 0x0d, 0x0a, 0
msg_2: db "Loading from disk", 0x0d, 0x0a, 0
msg_fail: db "Loading from disk failed", 0x0d, 0x0a, 0

times 510-($-$$) db 0
dw 0xaa55