;
; write_teletype_at_ebx
; Description: Function to put a character to the screen
; Arguments:
;           ah - color
;           al - character
;           ebx - offset
;
write_teletype_at_ebx:
    push ecx
    mov ecx, 0xB8000
    add ecx, ebx
    mov word [ecx], ax
    pop ecx
    ret
