; Duplicate a string on the heap
;
; Inputs:	RDI = string to duplicate
; Outputs:	RAX = address of new string (NULL if error)
; Clobbers:	flags

	extern	malloc
	extern	ft_strlen
	extern	ft_strcpy
	global	ft_strdup

ft_strdup:
	push	rdi							;; save address of source string in stack
	call	ft_strlen
	inc		rax							;; length + 1 for '\0'
	mov		rdi, rax					;; set length of string as size for malloc
	call	malloc wrt ..plt
	cmp		rax, 0						;; check NULL pointer
	jz		exit
	mov		rdi, rax					;; put destination pointer in RSI
	pop		rsi							;; put source in RSI
	call	ft_strcpy
	ret

exit:
	pop		rdi
	ret
