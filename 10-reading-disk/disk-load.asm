disk_load:
  push dx

  mov ah, 0x02
  mov al, dh ; no. of sectors
  
  mov ch, 0x00 ; C 0
  mov dh, 0x00 ; H 0
  mov cl, 0x02 ; S 2

  int 0x13
  jc disk_error_1

  pop dx      ; restore dx
  cmp dh, al
  jne disk_error_2
  ret

disk_error_1:
  mov bx, DISK_ERROR_MSG_1  
  call print_string

  mov dx, ax
  call print_hex
  
  jmp $

disk_error_2:
  mov bx, DISK_ERROR_MSG_2
  call print_string
  jmp $

; Try to prevent duplicated include here:
; This means if INCLUDE_PRINT is not defined yet, then define it
%ifndef INCLUDE_PRINT
  %define INCLUDE_PRINT

  ; Then do the include once
  %include "../6-function-calls/putting-all-together/print-string.asm"
%endif

; Of course if it's already included elsewhere, we need to call `%define INCLUDE_PRINT` there, else this check is useless.

DISK_ERROR_MSG_1: db 'Disk read error: carry', 0
DISK_ERROR_MSG_2: db 'Disk read error: incorrect no. of sectors expected', 0