default rel

section .text
global volume
volume:
 	mulss xmm0, xmm0    ; radius^2
 	mulss xmm0, [pi]    ; multiply by pi
 	divss xmm0, [three] ; divide by 3 
 	mulss xmm0, xmm1    ; multiply by height 
 	ret

section .data 
pi:    dd 3.141592654
three: dd 3.0
