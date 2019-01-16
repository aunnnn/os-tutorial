; - general source line is: 
;   - label instruction (operands) ; comment
; - The (operands) depends on nature of an instruction
; - label is just a way to bookmark and refer to them later in the code
label: mov ax, 0x1f
mov bx, 0x2f

cmp ax, bx
cmp al, bl

; See the generated `explore.bin` in hex format, you'll see it produces something like:
; B8 1F 00 BB 2F 00 ... 
; ...
; Some early insights:
; - These instructions map to some agreed machine code by Assembler (and we usually don't have to care about).
; - B8 probably associates with `mov ax` and BB probably associates with `mov bx`, and so on.
; - The two `mov` instructions ENDS WITH 00 (B8 1F 00, BB 2F 00), probably with some good reason.
; - The two `cmp` instructions DOES NOT END WITH 00 (39 D8, 38 D8).
; - Having label seems to not affect the code, probably just a convenient way to refer to an address.


; Pseudo-instructions
; -------------------
; These include `times`, which for example, repeats the instruction for 64 times
; and `db`, which means `declare byte (8 bits)`
; Using them together means to create bytes directly as you saw in the generated bin file. (or `dw` for declare word: 16-bit)
times 64 db 0xfd

db 0xab, 0xcd, 0xef ; Declare three following bytes

; FUN FACT
; ---------
; You'll notice that the machine codes are generated SEQUENTIALLY as you code in Assembly.
; E.g., We begin with few `mov`s and `cmp`s, then with 64 of `FD`s, then with the below `mov` again. 
; This reflects directly in the bin file.
; This mean we could debug Assembly code directly from bin, unlike in other higher-level languages 
; where the code often goes through many processing steps that end up with mysterious machine codes.
mov ax, 0x55

; Let's end with the cryptic instruction we've used for many previous sessions:
; This is not some magic instruction that pads our boot sector with 0s, there's meaning behind it:
; (Summarized from https://softwareengineering.stackexchange.com/a/322191/272193)
;
; For `times`: we already know this, repeat the instruction for N times.
; For `510 - ($ - $$)`, it is actually a simple MATH expression. 
; $ = current address that the instruction WILL BE ASSEMBLED.
; $$ = address of the start of the section (whatever it is).
; So ($ - $$) = offset from the start
; And 510 - offset = number of bytes before the 510th byte
; ANDDD:

times 510-($-$$) db 0

; Means that we pad 0 starting from current address of the machine code til the 510th byte!

; And as always, we complete a 512-byte boot sector with the magic number:
dw 0xaa55
