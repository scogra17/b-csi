# Notes

## Notable registers
* rax: return value; additionally, used by syscall 

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

## Opcodes
### Move
* mov rdx, rbx // copies what's stored in rbx into rdx 

### Arithmetic
* add r10, r11 // add what's stored at r10 and r11 and store in r10
* sub r10, r11 // subtract r11 from r10 and store in r10 
* inc r10      // increments value in r10 by 1
* shl r10      // shift left the value in r10 by 1
* shr r10      // shift right the value in r10 by 1 

### Stack operations 
* push rbx // push what's stored in rbx onto the stack
* pop rbx  // pop what's at the top of the stack into rbx 

### Control flow
* cmp rax, 0 // compare value stored in rax with 0 
* jmp .printer // jump to .printer:
* je .printer // jumpt to .printer if previous `cmp` was equal
* jne .printer // jump to .printer if previous `cmp` was not equal
* call str_to_int // call function 

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



