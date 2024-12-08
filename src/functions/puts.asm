;
; puts
; Description: Function to put a string to the screen
; Arguments:
;           si - where the string starts in memory.
;           dl - termination character (usually null)
;
puts:
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