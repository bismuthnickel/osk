;
; putsvga
; Description: Function to put a string to the screen using vga driver
; Arguments:
;           ah - color setting
;           dl - termination character (usually null)
;           si - where the string starts in memory.
;
putsvga:
    push ax
    push ebx
    push si
    mov dword ebx, [0x90000]
.loop:
    mov al, [si]
    add si, 1
    cmp al, dl
    je .return
    call write_teletype_at_ebx
    jmp .loop
.return:
    mov dword [0x90000], ebx
    pop si
    pop ebx
    pop ax
    ret