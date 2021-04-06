; Determines the length of a C-style NUL-terminated string
;
; Inputs:	RDI = address of string copy
;			RSI = address of source string
; Outputs:	RAX = address of string copy
; Clobbers:	CL, flags

section .text
	global	ft_strcpy

ft_strcpy:
	mov		rax, -1

loop:
	inc		rax
	mov		cl, [rsi+rax]
	mov		[rdi+rax], cl
	cmp		BYTE [rsi+rax], 0
	jnz		loop

exit:
	mov		rax, rdi
	ret
