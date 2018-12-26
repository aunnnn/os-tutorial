mov ah, 0x0e

mov bp, 0x8000 	; Set base of stack
mov sp, bp		; Set top of stack as base

push 'A'		; Push as 16 bit (padded with 0x00)
push 'B'
push 'C'

pop bx
mov al, bl
int 0x10		; Print C

mov al, [0x7ffc]
int 0x10		; Print B, stack grows downward from bp (0x8000)!

pop bx
mov al, bl
int 0x10		; Print B

mov al, [0x7ffe]
int 0x10		; Print A, stack grows downward from bp (0x8000)!

jmp $

times 510-($-$$) db 0
dw 0xaa55