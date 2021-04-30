	global	ft_atoi_base

ft_atoi_base:
	sub		rsp, 16					; local vars
	mov		DWORD [rsp + 12], 0		; int ret = 0
	mov		DWORD [rsp + 8], 1		; int sign = 1
	mov		DWORD [rsp + 4], 0		; int n = 0
	mov		DWORD [rsp], 0			; int bsize = 0
	push	rdi						; [rsp] = string to convert
	mov		rdi, rsi
	call	check_base
	pop		rdi
	cmp		rax, 2					; if (base < 2)
	jl		error					;    exit
	mov		[rsp], rax				; [rsp] = bsize
	call	space_loop
	call	sign_loop
	mov		[rsp + 8], rax
	jmp		exit

sign_loop:
	dec		rdi
	mov		rax, 1
.loop:
	inc		rdi
	cmp		BYTE [rdi], '+'
	je		.loop
	cmp		BYTE [rdi], '-'
	jne		.exit
	imul	rax, -1
	jmp		.loop
.exit:
	ret

space_loop:
	dec		rdi
.loop:
	inc		rdi
	cmp		BYTE [rdi], ' '
	je		.loop
	cmp		BYTE [rdi], 13
	jg		.exit
	cmp		BYTE [rdi], 9
	jge		.loop
.exit:
	ret

check_base:
	sub		rsp, 4					; local var
	mov		DWORD [rsp], 0			; int bsize = 0
	cmp		rdi, 0					; check NULL pointer
	jz		.error					; if true -> .error
	dec		rdi
.loop:
	inc		BYTE [rsp]
	inc		rdi
	cmp		BYTE [rdi], 0			; check if '\0'
	jz		.end
	cmp		BYTE [rdi], '+'
	jz		.error
	cmp		BYTE [rdi], '-'
	jz		.error
	cmp		BYTE [rdi], 33
	jl		.error
	cmp		BYTE [rdi], 126
	jg		.error
	mov		rax, rdi
.check_dup:
	inc		rax
	mov		cl, BYTE [rax]
	cmp		cl, 0
	jz		.loop
	cmp		BYTE [rdi], cl
	jz		.error
	jmp		.check_dup
.end:
	mov		rax, [rsp]				; return val = bsize
	dec		al
	add		rsp, 4					; clean stack
	ret
.error:
	add		rsp, 4					; clean stack
	mov		rax, 0					; return 0
	ret

error:
	mov		rax, 0
exit:
	add		rsp, 16					; restore stack ptr
	ret
