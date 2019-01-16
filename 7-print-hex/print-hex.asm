[org 0x7c00]

; Target content we will printout
mov dx, 0x1fb6

; Counter, will count from 0 to 3
mov cx, 0

start_manipulate_hex:
  ; Manipulate HEX_OUT to reflex DX

  cmp cx, 4
  je end_manipulate_hex
  
  ; copy val into ax first
  mov ax, dx

  ; shr can be used only with cl, 
  ; so we save the prev cx value first
  mov bx, cx

  ; mul ax each iteration by 4 (shift LEFT 2)
  shl cx, 2
  shr ax, cl

  ; Restore cx
  mov cx, bx

  ; Keep only the last hex char (last 4 bit)
  and ax, 0x000f

  ; Start at last pos
  mov bx, HEX_OUT + 5

  ; Traverse from the back
  sub bx, cx

  cmp al, 9
  jle manipulate ; If <=9, skip adding part
  add al, 39


manipulate:
  add [bx], al

  ; next iteration
  add cx, 1

  ; Continue the loop
  jmp start_manipulate_hex

end_manipulate_hex:

; Final print
mov bx, HEX_OUT
call print_string

jmp $

%include "../6-function-calls/putting-all-together/print-string.asm"

HEX_OUT: 
  db '0x0000', 0

times 510-($-$$) db 0
dw 0xaa55