# Session 4: Stack
Since registers are very limited, in the end we must resort to CPU main memory. But dealing with address is tedious, CPU offers `push` and `pop` as a way to manage memory as **stack**.

To use we set the base and the top of stack with `bp` and `sp` respectively:
```nasm
mov bp, 0x8000 	; set base
mov sp, bp		; set top
```

**Stack actually grows DOWNWARD.**
By that I mean it approaches 0x00 as you `push` more content to it.

E.g. with base `0x8000`, the first content will be at `0x7ffe` . Notice how a `push` occupies 2 bytes. (Including `pop`)

That means if you push a lot of things on stack, it might override important stuff at the beginning of the memory.

#study/os