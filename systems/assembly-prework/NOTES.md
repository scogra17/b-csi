# Notes

## Data section
* the header should be `section .data` followed by constants 
* e.g.:
```
	  SYS_WRITE  equ 1 
	  STD_IN     equ 1

	  NEW_LINE   db  0xa
	  WRONG_ARGC db  "Must be two command line arguments", 0xa
```

## Text (code) section
* the header should be `section .text` followed by `global _[entry_point]`

## Bss (buffer) section
* the header should be `section .bss` followed by buffer name 
* e.g. 
```
     output: resb 12 // reserves 12 bytes without initializing, aka buffer
```

## Notable registers
* rax: return value; additionally, used by syscall 
	* for syscall, "0x02000004" in rax, for instance, signifies "write". "0x02000001" signifies "exit"
	* "write" syscall: 
		* 1st argument (rdi): file descriptor (e.g. 1 for stdout)
		* 2nd argument (rsi): message address
		* 3rd argument (rdx): length of message
	* "exit" syscall: 
		* 1st argument (rdi): code (e.g. 0 for success)

* Function arguments: 
	* rdi: 1st argument; also first argument when own function is called
	* rsi: 2nd argument (pointer)
	* rdx: 3rd argument 
	* rcx: 4th argument 
	* r8:  5th argument 
	* r9:  6th argument 

* rsp: stack pointer
* rbp: base stack pointer 
* rip: program counter
* bl : 1 byte register

## Opcodes
### Move
* mov rdx, rbx // copies what's stored in rbx into rdx 
	* movb (move byte)
	* movw (move word)
	* movl (move double word)
	* movq (move quad word)
* lea rdx, rbx // copy the mem address i rbx into rdx
	* lea can also be used to compactly represent arithmetic operations, e.g. `leaq rax, 7[rdx, rdx, 4]` is equivalent to 5x + 7 if rdx contains value x

#### Memory scaling
* movq rdx, 8[rsp] // copies the second quad word from the stack to register rdx

### Arithmetic
* add r10, r11 // add what's stored at r10 and r11 and store in r10
* sub r10, r11 // subtract r11 from r10 and store in r10 
* inc r10      // increments value in r10 by 1
* shl r10      // shift left the value in r10 by 1
* shr r10      // shift right the value in r10 by 1 
* mul rcx      // multiply rax by what's in rcx (stores high 64 bits in rdx, low in rax)
* neg r10      // negate value stored at r10
* shl r10, n   // shift value stored at r10 left by n positions

### Control flow
* cmp rax, 0      // compare value stored in rax with 0 
	* cmp 1, 3    // 1-3 = -2 
* jmp .printer    // jump to .printer:
* je .printer     // jumpt to .printer if previous `cmp` was equal
* jne .printer    // jump to .printer if previous `cmp` was not equal
* call str_to_int // call function 

#### Conditional codes 
* CF: carry flag
* ZF: zero flag - most recent operation yielded a zero 
* SF: sign flag - most recent operation yielded a negative
* OF: overflow flag - most recent operation caused a two's compelement overflow
* apart from `leaq` all arithmetic operations impact conditional codes: 
	* for logical operations, CF and OF are zeroed 
	* for shift operations, the CF is set to the last bit shifted out, while the overflow flag is set to 0
	* inc and dec set the OF and ZF, but leave the CF unchanged
	* cmp operations do the same as sub but without affecting the register values. ZF is set to 0 if the operands are equal

### Logical operators
and r10, r11 // r10 and (&=) r11
or r10, r11  // r10 or (|=) r11
xor r10, r11 // r10 xor (^=) r11
not r10      // inverse  (`~`)

### Misc 
cld // reset df flag to 0
lea rdi, [rel message] // put address of message (intialized in data) in rdi

### Stack operations 
* push rbx // decrements rsp and copies what's stored in rbx onto the stack
* pop rbx  // pop what's at the top of the stack into rbx and increments rsp

## Flags 
[rsp + 8]  = argv[0]
[rsp + 16] = argv[1]

decreasing address values
^           |_______|
|           |       |
|next push  |_______| 
|           |       |
|rsp-8-->   |_______|
|           |       |
|rsp-->     |_______|
             "Bottom of stack"

Also note that the stack can be thought of as existing to preserve 
register state between function calls. Additionally if we call a function 
with more than 6 arguments, the additional arguments will be stored on 
the stack

## Debugging w/ lldb [cheat sheet](https://www.nesono.com/sites/default/files/lldb%20cheat%20sheet.pdf)
### Initiating 
* `lldb [name of executable]`
* example breakpoint set: `breakpoint set --file binary_convert.asm --line 4`
* run the debugger: `run`

### Commands 
* `c`: continue, i.e. move to next function call 
* `s`: step, i.e. step to next machine instruction 

## Memory 
* example memory read: `memory read --size 1 --format b --count 10 0x0000000100007af2`

## Call/return
the call instruction takes one operand, the address of the function being called and pushes the return address (current value of rip, which is the next instruction after the call) onto the stack and then jumps to the address of the function called.

the ret instruction pops the return address from the stack into rip, thus resuming at the saved return address

to set up for a call, the caller puts the first six arguments into the arg registers and executes the call instruction

when the callee finishes, it writes the return value to rax (if there is one), cleans up the stack and uses ret to return control to the caller

the called function must preserve rbp, rbx, r12, r13, r14, r15. All others are free to be changed by the callee 

e.g. 
```
mov eax, 0x0
add rsp, 0x10 // deallocate stack frame
ret 
```

caller saved registers 
------------------------------------------------------
rax, rcx, rdx, rsi, rdi, rsp, r8, r9, r10, r11

callee saved registers* 
------------------------------------------------------
rbx, rbp, r12-r15                 

* callee save register: callee must preserve values in these registers. Caller saved registers can be modified by any function -- caller should save these register values to the stack if they will be needed later 

## Floating point
* xmm1: return register 

# Sources 
* [Stanford 107](https://web.stanford.edu/class/cs107/guide/x86-64.html#common-instructions)


# Questons
* difference betwen label with and without leading `.`, e.g. :
```
.loop:
  ; do something

vs 

loop: 
  ; do something 
```
one difference is that lldb did not reach the label until the preceding `.` was added

## Working with files
* compile only: `gcc -O1 -S -masm=intel [c file name, e.g. mstore.c]` -> produces `mstore.s`
	* `-masm=intel` since default is ATT 
* compile and assemble: `gcc -O1 -c [c file name, e.g. mstore.c]` -> produces `mstore.o`
* compile, assemble and link: `gcc -g -O1 -o prog [c file name, e.g. mstore.c]` -> produces executable called `prog`
	* `-g` enables debugging
* disassemble: `objdump -d [object file name, e.g. mstore.o]`

## Other convensions
* when copying partial data
	* when generating only 1- or 2-byte quantities, the remaining bits are left unchanged; with 4-byte quantities, the remaining bits are zeroed 

## Questions 
* How do cmp, sub etc. use rflags and the carry flag in particular? What uses do the carry flags have? 
* What is the significance of `movzx` vs. `mov`? 
	* A: `movz` zero extends, `movzbw` zero extends byte to word 
	* `movs` sign extends, replicating the most significant bit of the source operand
* Why do we sometimes prefix an address with `byte`? e.g. `mov cx, byte [rdi]`
* Where are the condition flags stored? `rflags`?
	* https://en.wikipedia.org/wiki/FLAGS_register 
* Text Figure 3.32 vs. 3.25. Shouldn't the return address have the lowest address as was the case in the earlier diagram? 
	* The return address in 3.32 is for the main function. Once proc is called, the return address is added to the stack as shown in figure 3.29
