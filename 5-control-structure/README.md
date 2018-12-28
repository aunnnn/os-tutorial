# Session 5: Control Structures
## If/Else
We can use `cmp` function to compare value like this:
`cmp ax, 4`.

The result will then be magically stored in CPU’s special register `flags`, waiting for you to use with _conditional jumps_ below:
```nasm
je 	target_block ; jump if equal
jne 	... ; jump if not equal
jl	... ; jump if less than
jle	... ; jump if less than/equal
; etc.
```

Putting all together, we can use two-step instructions to implement conditional:
```nasm
cmp bx, 4
jle then_block
...
then_block:
	mov al, 'A'

jmp $
```

**Important 1**: when you jump to the label `then_block`, you **don’t** automatically return back to where you come from (like you do in Python or any high-level languages), you need to explicitly say where you want to go next, e.g., `jmp somewhere_else` at the end of the label.

**Important 2**: when the `then_block` reaches the last line, It just continue to execute what’s below it. In this case, `jmp $` will be the next instruction to execute. Again, it doesn’t go back to where you come from.

To recap, label (`label:`) is just an easy way for us to refer to instructions and to jump around. Don’t misread it as function block like in Python where the logic is nicely separated from the world.

#study/os