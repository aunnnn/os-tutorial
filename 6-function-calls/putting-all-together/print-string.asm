; Main function
print_string:
  pusha

; Loop printing each char
for_loop:
  mov al, [bx]
  cmp al, 0

  ; break the loop
  je end_of_loop

  ; print char
  mov ah, 0x0e
  int 0x10

  ; move to next char & repeat
  add bx, 0x1
  jmp for_loop

end_of_loop:
  popa
  ret