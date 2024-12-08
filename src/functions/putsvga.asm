;
; putsvga
; Description: Function to put a string to the screen using vga driver
; Arguments:
;           ah - color setting
;           ebx - cursor offset from 0xB8000
;           dl - termination character (usually null)
;           si - where the string starts in memory.
;
putsvga:
    push ax
.loop:
    mov al, [si]
    add si, 1
    cmp al, dl
    je .return
    call write_teletype_at_ebx
    jmp .loop
.return:
    pop bx
    pop ax
    ret