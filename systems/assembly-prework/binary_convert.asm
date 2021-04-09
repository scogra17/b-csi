section .text
global binary_convert
binary_convert:
	xor r12b, r12b        ; use a single byte register to store ASCII values, initialize to 0
	xor rax, rax          ; use rax to store return value, initialize to 0 

.loop:
	mov r12b, [rdi]       ; move the first ASCII character byte to r12 
	cmp r12b, 0           ; compare with the null value, and exit if they match 
	je .exit              
	inc rdi               ; increment rdi to point to the next ASCII value
	shl rax, 1			  ; reaching this command indicates we have a new ASCII character so multiply the existing total by 2 by left shifting
	and r12, 1            ; isolate lowest order bit of ASCII char
	add rax, r12         
	jmp .loop

.exit:
	ret
