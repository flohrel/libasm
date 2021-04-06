; Determines the length of a C-style NUL-terminated string
;
; Inputs:	RDI = address of string copy
;			RSI = address of source string
; Outputs:	RAX = address of string copy
; Clobbers:	<none>

	global	ft_strcmp

ft_strcmp:
	xor		rax, rax
	jmp		loop

loop:
	inc		rax
	mov		cl, BYTE [rdi+rax]
	cmp		cl, 0
	jz		exit
	cmp		BYTE [rsi+rax], cl
	jnz		exit
	jmp		loop

exit:
	sub		cl, BYTE [rsi+rax]
	mov		al, cl
	ret
