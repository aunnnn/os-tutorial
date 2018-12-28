; Using call and ret

mov al, 'H'
call my_print_function
mov al, 'e'
call my_print_function

; End of code
jmp $ ; Without this it goes down to call my_print_function the third time!

my_print_function:
    mov ah, 0x0e
    int 0x10
    ret 
    ; jump back to the caller

times 510-($-$$) db 0
dw 0xaa55