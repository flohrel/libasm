	global	ft_atoi_base

ft_atoi_base:
	sub		rsp, 16					; local vars
	mov		DWORD [rsp + 12], 0		; int ret = 0
	mov		DWORD [rsp + 8], 1		; int sign = 1
	mov		DWORD [rsp + 4], 0		; int n = 0
	mov		DWORD [rsp], 0			; int bsize = 0

	push	rdi
	mov		rdi, rsi
	call	check_base


check_base:
	sub		rsp, 12					; local vars
	mov		QWORD [rsp + 8], 0		; char *base_ptr = NULL
	mov		DWORD [rsp], 0			; int bsize = 0

	cmp		rdi, 0					; check NULL pointer
	jz		.error					; if true -> error

.error:
	add		rsp, 12
	mov		rax, 0
	ret
