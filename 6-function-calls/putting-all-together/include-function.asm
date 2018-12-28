
; Make Assembler knows the loaded offset, so it handles automatically
; (No more manual 'add bx, 0x7c00'!)
[org 0x7c00]

; Use bx as (addresses to) parameters
mov bx, HELLO_MSG
call print_string
mov bx, GOODBYE_MSG
call print_string

jmp $ ; Hang (infinite-loop here)

%include "print-string.asm"

; DATA
HELLO_MSG:
  db 'Hello, World!', 0

GOODBYE_MSG:
  db 'Good Bye!', 0

times 510-($-$$) db 0
dw 0xaa55