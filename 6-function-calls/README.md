# Session 6: Function Calls
As we saw from session 5, label won’t help us much in term of calling function. It just either let us jump around, then continue to execute from top to bottom. So, we must setup something manually to make function calls work.

Another thing we have to deal with is how to pass parameters.

One way is to set our parameters on some place where caller and callee both know to get/set. E.g.,:
```nasm
mov al, 'H'
jmp my_print_function
...
return_to_here:
...

; our function
my_print_function:
	mov ah, 0x0e
	int 0x10
	jmp return_to_here
```

Here we use  `al` as a place to store parameter on `my_print_function`. After finish the call we jump back to `return_to_here`.

You can already notice one downside (more to come) with this approach: `return_to_here` is explicitly set to return back to where you call the function. What if you have multiple places to go back? `return_to_here_1`,  `return_to_here_2`, etc.? Messy.

## An idea
One nice and flexible solution is to store where you currently are in some well-known/agreed address before making the jump, so that you can jump back when you’re done with the current label.

## A built-in solution
CPU provides a special register `ip` that does exactly this, where it tells the current instruction being executed.

In a good way, `ip` _cannot_ be accessed directly to implement this mechanism, because CPU provides a pair of instructions:  `call` and `ret`, that already implement this.

## `call` and `ret`
First you use `call` to call a function/label. `call` is like `jmp`, but in addition it also puts a current address on some hidden stack. Then, `ret` should be called at the end to return back to where you come from. It automatically pops off that current address from the hidden stack.

```nasm
mov al, 'H'
call my_print_function ; jump!
...
my_print_function:
	mov ah, 0x0e
	int 0x10
	ret ; return back
```

In other words, `call` and `ret` handles function calling for us. Going to and return back has never been easier.
- - - -
## Cleaning up the mess when you jump around
You’ll realize it can get dirty when each function use the same registers over and over again without cleaning it before or after the use. Another function won’t know which registers you touched and which ones are available to use. Just like in typical coding, you can already feel the future bugs when you share some global variables out there.

Luckily, you can use `pusha` and `popa` (push_pop all) to /safe and restore_ all the registers before and after the execution of function:
```nasm
some_function:
	pusha 	; save
	;... use registers freely
	popa	; restore
	ret
```
- - - -
You can include code from other files with:
```nasm
%include "print_string.asm"
```
What it does is simple, replace content from `print_string.asm` to that exact line!
- - - -
## Putting all together
Check out `include-function.asm` and `print-string.asm`, where we put all concepts together, to _print string of arbitrary length_, this includes:
*  `[org 0x7c00]`
* Passing labels as addresses to parameter
* `call` and `ret`
* `%include` a file
* `pusha` and `popa`
* simple for-loop by `jmp`
* break the loop conditionally with  `cmp` and `je`
* Convention to end string with `0`

#study/os