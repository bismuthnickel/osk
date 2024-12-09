; gets cursor from memory and puts it in ebx
get_cursor:
    mov dword ebx, [CURSOR]
    ret

; sets cursor in memory to ebx
set_cursor:
    mov dword [CURSOR], ebx
    ret

; sets cursor in memory to row BH, column BL
set_cursor_row_column:
    mov eax, 0
    mov al, bh
    mov ecx, 160
    mul ecx
    mov cl, bl
    mov ebx, 0
    mov bl, cl
    shl ebx, 1
    add ebx, eax
    mov dword [CURSOR], ebx
    ret

CURSOR equ 0x70000