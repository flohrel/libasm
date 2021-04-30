; Convert string to int in a specific base
;
; Inputs:	RDI = address of string to convert
;			RSI = address of base string
; Outputs:	RAX = string converted to int
; Clobbers:	flags, r8, r10, r11, rcx

	global	ft_atoi_base

ft_atoi_base:
	push	rdi
	mov		rdi, rsi
	call	check_base
	pop		rdi
	cmp		rax, 2					; if (base < 2)
	jl		error					;    exit
	mov		r10, rax				; r10 = bsize
	call	space_loop				; skip spaces
	call	sign_loop				; determine sign
	mov		r11, rax				; r11 = sign
	call	base_convert
	jmp		exit

is_inbase:
	xor		rax, rax				; index = 0
	mov		cl, BYTE [rdi]			; char to find in base saved in rcl
	dec		rax
.loop:
	inc		rax
	cmp		BYTE [rsi + rax], 0		; cmp base[index] to '\0'
	jz		.exit
	cmp		cl, BYTE [rsi + rax]	; cmp cl to base[index]
	jne		.loop
	ret
.exit:
	mov		rax, -1
	ret

base_convert:
	xor		r8, r8					; put r8 to 0
	dec		rdi
.loop:
	inc		rdi
	call	is_inbase
	cmp		rax, 0
	jl		.exit
	imul	r8, r10					; ret * bsize
	add		r8, rax
	jmp		.loop
.exit:
	mov		rax, r8
	ret

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
	xor		r8, r8					; int bsize = 0
	cmp		rdi, 0					; check NULL pointer
	jz		.error					; if true -> .error
	dec		rdi
.loop:
	inc		r8
	inc		rdi
	cmp		BYTE [rdi], 0			; check if '\0'
	jz		.exit
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
.exit:
	mov		rax, r8					; return val = bsize
	dec		al
	ret
.error:
	mov		rax, 0					; return 0
	ret

error:
	xor		rax, rax				; return value = 0
exit:
	imul	rax, r11				; sign * ret
	ret
