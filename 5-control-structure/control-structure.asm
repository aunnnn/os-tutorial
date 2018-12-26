mov bx, 50

cmp bx, 4
jle first_block
cmp bx, 40
jle second_block
jmp else_block

first_block:
  mov al, 'A'
  jmp the_end

second_block:
  mov al, 'B'
  jmp the_end

else_block:
  mov al, 'C'
  jmp the_end

the_end:



mov ah, 0x0e
int 0x10

jmp $
times 510-($-$$) db 0
dw 0xaa55