; Learn about memory address

mov ah, 0x0e

; First attempt: print the_secret
; - Failed because it will try to print address instead of content.
mov al, "1" ; Just to seperate 1 to 4 attempts apart.
int 0x10

mov al, the_secret
int 0x10

; Second attempt: print content of 'the_secret' instead (using [])
; - Failed because when the boot sector code is loaded by BIOS, it's loaded with default offset 0x7c00! 
; This will print content at the early memory address (ISRs stuffs). 
mov al, "2"
int 0x10

mov al, [the_secret]
int 0x10

; Third attempt: Offset
; - Worked, since we add the correct offset and print it.
mov al, "3"
int 0x10

mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

; Fourth attempt:
; - Worked, since default offset = 0x7c00, and the_secret is offset at 0x2d (45) (JUST BEFORE, not AT). 
; We can add manually and use it as a direct address to "X".
; Note: May not be the same, inspect with `od -t x1 -A n print-x.bin`
mov al, "4"
int 0x10

mov al, [0x7c2d]
int 0x10

jmp $

the_secret:
  db "X"

times 510-($-$$) db 0
dw 0xaa55
  