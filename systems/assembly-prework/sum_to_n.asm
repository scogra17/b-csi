section .text
	global sum_to_n

sum_to_n:
	xor rax, rax  ; set rax to 0, which will be used to store the running total
.loop: 
	add rax, rdi  ; add value to running total 
	sub rdi, 1    ; decrement n
	cmp rdi, 0    ; check if n is equal to 0. NOTE that we could exclude this step as sub will have the same effect on the carry flag https://www.aldeid.com/wiki/X86-assembly/Instructions/cmp
	jge .loop     ; if n is not equal to 0, re-run the loop
	ret
