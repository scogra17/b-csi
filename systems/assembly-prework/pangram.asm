section .text
global pangram
pangram:
	xor r12, r12 ; zero out register to store individual ascii values
	xor r13, r13 ; zero out register to store record of letters seen

.loop: 
	mov r12b, [rdi]      ; move the value stored at rdi (representing character in ascii) into r12
	inc rdi              ; increment rdi to point to the next ascii value
	cmp r12b, 0x0        ; check byte value for null value
	je .test             ; determine if we've seen all letters by checking for the null character
	or r12b, 0b00100000  ; lower case character by flipping a single bit (see ascii table for reference)
	sub r12b, 97         ; convert ascii values to numbers where 0d0 corresponds to 'a' and 0d26 correponds to 'z'
	xor r10, r10         ; zero out register to store bit representing seen letter
	btc r10, r12         ; flip appropraite bit (e.g. bit 1 for 'a', bit 2 for 'b', etc.)
	or r13, r10          ; set the corresponding bit to 1 
	jmp .loop            ; proceed to the next character

.test:
	xor rax, rax         ; zero out return register, which if unchanged will return "false"     
	and r13, 0x03ffffff  ; zero out bits that don't correspond to letters
	cmp r13, 0x03ffffff  ; check if we encountered all letters
	je .pass                           
	ret                         

.pass:
	mov al, 0xff ; store all ones ("true") in the lower order byte of the return register
	ret   

