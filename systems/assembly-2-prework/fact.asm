section .text
global fact
fact:	
	cmp rdi, 1      
	jle .return      ; base case, if n <= 1, return n  
	sub rsp, 8       ; provision space on the stack to save the value of n
	mov [rsp], rdi   ; push the value of n to the stack, note `sub + mov` could be replaced with a single push command
	sub rdi, 1     		
	call fact        ; make recursive call using (n-1)
	imul rax, [rsp]  ; multiply the return value of fact(n-1) and n (saved on the stack)
	add rsp, 8       ; pop n off the stack, note `pop` could be used here
	ret

.return:
	mov rax, rdi     ; base case, return n
	ret