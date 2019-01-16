; IMPORTANT
; You need to test this with:
; qemu-system-x86_64 -fda test-load.bin
; Somehow this loads to 0x00 (checked with dl), and make the whole thing works.
;
; qemu-system-x86_64 test-load.bin <- This loads to some weird drive don't know why
;
; Ref: https://github.com/cfenollosa/os-tutorial/tree/master/07-bootsector-disk

[org 0x7c00]

; dl stores the drive number before the boot sector is loaded, so save it!
mov [BOOT_DRIVE], dl

; Let's inspect it 
call print_hex

; Print separator
mov bx, STR_SEPARATOR
call print_string

mov bp, 0x8000
mov sp, bp

mov bx, 0x9000
mov dh, 5
mov dl, [BOOT_DRIVE]
call disk_load

mov dx, [0x9000]
call print_hex

mov dx, [0x9000 + 512]
call print_hex

jmp $

%include "../6-function-calls/putting-all-together/print-string.asm"
%define INCLUDE_PRINT

%include "../7-print-hex/for-include/print-hex-f.asm"
%include "disk-load.asm"

BOOT_DRIVE: 
  db 0

STR_SEPARATOR:
  ; 0xA = line feed
  ; 0xD = carriage return
  db 0xA, 0xD, '----', 0xA, 0xD, 0

times 510-($-$$) db 0
dw 0xaa55

; Append with one more sector
times 256 dw 0xdada
times 256 dw 0xface