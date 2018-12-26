# Session 2: Write to Screen
## Writing ‘Hello’ to screen
4 bit e.g. `f` = one hex number
1 byte = 8 bit `e.g. 0xff` = two hex numbers
**1 word** = 16 bit = 2 bytes `e.g., 0x1234`

### Interrupts
Need to use interrupts to do this.
**Interrupt** is a mechanism to stop the CPU and do some job we want, then back to resume. Those jobs we want can be displaying something on screen.

### Assembly code for interrupt
Can be triggered from software instruction, e.g., `int 0x10` for screen-related or `0x13` for disk-related I/O 

Can also be triggered by hardware.

### Where are these stored?
An interrupt is represented by a number that’s an indexing to _interrupt vector_, e.g., at start of memory `0x0`, which in turn contains address pointers to actual machine instructions that do these jobs, called Interrupt service routines _ISRs_)

To get more options for the interrupts (and to save space), the register is used as a parameter of the instruction. E.g., `int 0x10` and `mov ah, 0x0e` used together to indicate tele-type mode displaying to screen.

## 4 Types of CPU Registers
* ax, bx, cx, dx
Each can store _a word_.

``` nasm
mov ax, 1234 ; store decimal
mov cx, 0x234 ; store hex
mov dx, 't' ; store ASCII
mov bx, ax ; copy ax to bx
``` 

Can control _high_ and _low_ bytes independently with `ah, al` (or whole word with `ax`):
``` nasm
mov ax, 0 ; 0x0000
mov ah, 0x56 ; 0x5600
mov al, 0x12 ; 0x5612
```

## Putting all together
We set the tele-type mode once. Set `al` to character we want. Then call interrupt `int 0x10` to display it on screen, like this:
``` nasm
mov ah, 0x0e	; tele-type mode

mov al, 'H'		; put 'H' at al
int 0x10		; call interrupt for display on screen
; ...
```

#study/os