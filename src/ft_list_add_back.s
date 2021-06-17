	global	ft_list_add_back
	extern	malloc

ft_list_last:
	push	rbp
	mov		rbp, rsp
	test	rdi, rdi		; cmp lst to NULL
	jz		.return
.loop:
	mov		rcx, [rdi+8]		; put lst->next in rcx
	test	rcx, rcx			; cmp to NULL
	jz		.return
	mov		rdi, rcx			; lst = lst->next
	jmp		.loop
.return:
	mov		rax, rdi			; return current lst
.exit:
	leave
	ret

ft_list_add_back:
	push	rbp
	mov		rbp, rsp
	test	rdi, rdi			; check if address of list is NULL
	jz		.exit
	push	rdi					; save address of list
	push	rsi
	mov		rdi, 16				; size of struct
	call	malloc
	test	rax, rax			; if pointer to new struct == NULL
	jz		.exit
	pop		rsi
	mov		[rax], rsi			; save data pointer in struct
	pop		rcx					; put list** in rcx
	push	rax					; save pointer to new struct in stack
	mov		rdi, [rcx]
	call	ft_list_last
	test	rax, rax
	jnz		.add_back
	mov		rdi, rsi
	jmp		.exit
.add_back:
	mov		[rax+8], rcx
.exit:
	leave
	ret
