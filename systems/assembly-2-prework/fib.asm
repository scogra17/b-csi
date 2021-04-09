section .text
global fib
fib:
	push r12         ; push value of callee saved register r12 to the stack before overwriting 
	mov r12, rdi     ; use register r12 to store the value of n
	cmp rdi, 1       ; check for base case 
	jle .return
	dec rdi       
	call fib         ; make recursive fib(n-1) call
	mov r8, rax      ; use register r8 to store the return value of fib(n-1) 
	push r8          ; push value of caller save register r8 to the stack before making next recursive call  
	lea rdi, -2[r12] ; decrement r12 by 2
	call fib         ; make recursive fib(n-2 call)
	pop r8
	add rax, r8      ; add the results of the two recursive calls 
	pop r12          
	ret

.return:
	pop r12
	mov rax, rdi     ; used for base case to return 0 or 1
	ret