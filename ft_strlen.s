; Determines the length of a C-style NUL-terminated string
;
; Inputs:	RDI = address of beginning of string buffer
; Outputs:	RAX = length of the string, excluding NUL terminator

section .text
	global	ft_strlen

ft_strlen:
	push	rbp
	mov		rbp, rsp

.count:
	mov		rcx, -1
	mov		rsi, rdi
	xor		al, al
	repne	scasb
	sub		rdi, rsi
	dec		rdi
	mov		rax, rdi
	leave
	ret
