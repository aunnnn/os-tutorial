mov ah, 0x0e

; 1st Attempt - nope
mov al, [the_secret]
int 0x10

; 2nd Attempt - correct
mov bx, 0x7c0 ; Can't set to ds directly
mov ds, bx
mov al, [the_secret] ; ds is used implicitly
int 0x10

; 3rd Attempt - use general purpose segment register es, still nope
mov al, [es:the_secret] ; Tell CPU to use es
int 0x10

; 4th Attempt - correct
mov bx, 0x7c0
mov es, bx
mov al, [es:the_secret]
int 0x10

jmp $

the_secret:
  db "X"

times 510-($-$$) db 0
dw 0xaa55