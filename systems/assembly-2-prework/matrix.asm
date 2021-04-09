section .text
global index
index:
	; rdi: matrix
	; rsi: rows
	; rdx: cols
	; rcx: rindex
	; r8: cindex
	lea rax, [rcx + r8]    ; add indeces 
	imul rcx, r8           ; multiply indeces 
	lea rax, [rax + rcx]   ; add sum and product of indeces, which will result in the desired index
	mov rax, [rdi + rax*4] ; scale the desired index by the size of an int (4 bytes), add to the matrix pointer, and grab the value from memory
	ret
