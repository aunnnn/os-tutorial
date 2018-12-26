mov ah, 0x0e	; tele-type mode

mov al, 'H'		; put 'H' at al
int 0x10		; call interrupt for display on screen

mov al, 'e'
int 0x10

mov al, 'l'
int 0x10

mov al, 'l'
int 0x10

mov al, 'o'
int 0x10

jmp $			; Jump to current address, infinite loop

times 510-($-$$) db 0	; Pad bott sector with zeros (need 512 bytes)
dw 0xaa55				; Magic number for boot sector at the end