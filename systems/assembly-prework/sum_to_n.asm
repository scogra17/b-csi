section .text
	global sum_to_n

sum_to_n:
	xor r11, r11  ; set r11 to 0, which will be used to store the running total
.loop: 
	add r11, rdi  ; add value to running total 
	sub rdi, 1    ; decrement n
	cmp rdi, 0    ; check if n is equal to 0 
	jge .loop     ; if n is not equal to 0, re-run the loop
	mov rax, r11  ; move the total into the return register rax
	ret
