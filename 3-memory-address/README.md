# Session 3: Memory
## Memory address (CPU)
We can visualize physical memory as long sequence of bytes:
![](&&&SFLOCALFILEPATH&&&15153470-6E0A-457F-9422-71DC12720721.png)
which can be indexed by hex number (12th byte as 0x0c, etc.).

BIOS loads the boot sector (our program) at predefined address: _0x7c00_. There’s enough space for Interrupt vector, BIOS, etc. at the beginning of the memory to prevent overwriting.

### Find the “X” game
```nasm
the_secret:
	db "X"
```

First doesn’t work because it prints the address (also wrong) of the label.

Second doesn’t work because, though it prints the content at the address, the address here **does not consider offset that the boot sector is loaded by the BIOS yet.**
```nasm
mov al, the_secret ; 1st
mov al, [the_secret] ; 2nd

; Both 1 and 2 failed.
```

Third worked because it adds the offset to the label and print the content.
Forth worked because it calculates the address manually.
```nasm
; 3rd (Add Offset - worked)
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]

; 4th (Manual - worked)
mov al, [0x7c1e]
```
- - - -
That manual offset is so tedious. You can let the Assembler handles this by telling it where the code will be loaded like this:
`[org 0x7c00]`

Then it’ll manage the memory offset for you! Going forward you can refer to label’s address directly. 
- - - -
## Some string convention
Ends string with zero to know that it reaches the end!
```nasm
MY_LABEL:
	db 'Hello world', 0
```

`db` = declare bytes, e.g., tells it to write this part directly into memory, that it’s not instruction, it’s DATA!
#study/os