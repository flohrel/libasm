	global	ft_list_sort

ft_lstlast:
	push	rbp
	mov		rbp, rsp
	mov		QWORD [rbp-8], rdi
	cmp		QWORD [rbp-8], 0
	je		.L2
	jmp		.L3
.L4:
	mov		rax, QWORD [rbp-8]
	mov		rax, QWORD [rax+8]
	mov		QWORD [rbp-8], rax
.L3:
	mov		rax, QWORD [rbp-8]
	mov		rax, QWORD [rax+8]
	test	rax, rax
	jne		.L4
.L2:
	mov		rax, QWORD [rbp-8]
	pop		rbp
	ret

ft_lstadd_back:
	push	rbp
	mov		rbp, rsp
	sub		rsp, 32
	mov		QWORD [rbp-24], rdi
	mov		QWORD [rbp-32], rsi
	mov		rax, QWORD [rbp-24]
	mov		rax, QWORD [rax]
	test	rax, rax
	jne		.L7
	mov		rax, QWORD [rbp-24]
	mov		rdx, QWORD [rbp-32]
	mov		QWORD [rax], rdx
	jmp		.L9
.L7:
	mov		rax, QWORD [rbp-24]
	mov		rax, QWORD [rax]
	mov		rdi, rax
	call	ft_lstlast
	mov		QWORD [rbp-8], rax
	mov		rax, QWORD [rbp-8]
	mov		rdx, QWORD [rbp-32]
	mov		QWORD [rax+8], rdx
.L9:
	nop
	leave
	ret

ft_lstsize:
	push	rbp
	mov		rbp, rsp
	sub		rsp, 16
	mov		QWORD [rbp-8], rdi
	cmp		QWORD [rbp-8], 0
	jne		.L11
	mov		eax, 0
	jmp		.L12
.L11:
	mov		rax, QWORD [rbp-8]
	mov		rax, QWORD [rax+8]
	mov		rdi, rax
	call	ft_lstsize
	add		eax, 1
.L12:
	leave
	ret

merge:
	push	rbp
	mov		rbp, rsp
	sub		rsp, 48
	mov		QWORD [rbp-24], rdi
	mov		QWORD [rbp-32], rsi
	mov		QWORD [rbp-40], rdx
	mov		QWORD [rbp-16], 0
	jmp		.L14
.L18:
	mov		rax, QWORD [rbp-32]
	mov		rdx, QWORD [rax]
	mov		rax, QWORD [rbp-24]
	mov		rax, QWORD [rax]
	mov		rcx, QWORD [rbp-40]
	mov		rsi, rdx
	mov		rdi, rax
	call	rcx
	test	eax, eax
	jle		.L15
	mov		rax, QWORD [rbp-32]
	mov		QWORD [rbp-8], rax
	mov		rax, QWORD [rbp-32]
	mov		rax, QWORD [rax+8]
	mov		QWORD [rbp-32], rax
	jmp		.L16
.L15:
	mov		rax, QWORD [rbp-24]
	mov		QWORD [rbp-8], rax
	mov		rax, QWORD [rbp-24]
	mov		rax, QWORD [rax+8]
	mov		QWORD [rbp-24], rax
.L16:
	mov		rax, QWORD [rbp-8]
	mov		QWORD [rax+8], 0
	mov		rdx, QWORD [rbp-8]
	lea		rax, [rbp-16]
	mov		rsi, rdx
	mov		rdi, rax
	call	ft_lstadd_back
.L14:
	cmp		QWORD [rbp-24], 0
	je		.L17
	cmp		QWORD [rbp-32], 0
	jne		.L18
.L17:
	cmp		QWORD [rbp-24], 0
	je		.L19
	mov		rdx, QWORD [rbp-24]
	lea		rax, [rbp-16]
	mov		rsi, rdx
	mov		rdi, rax
	call	ft_lstadd_back
	jmp		.L20
.L19:
	mov		rdx, QWORD [rbp-32]
	lea		rax, [rbp-16]
	mov		rsi, rdx
	mov		rdi, rax
	call	ft_lstadd_back
.L20:
	mov		rax, QWORD [rbp-16]
	leave
	ret

ft_list_sort:
	push	rbp
	mov		rbp, rsp
	sub		rsp, 64
	mov		QWORD [rbp-56], rdi
	mov		QWORD [rbp-64], rsi
	mov		rax, QWORD [rbp-56]
	mov		rax, QWORD [rax]
	mov		QWORD [rbp-16], rax
	mov		rax, QWORD [rbp-16]
	mov		rdi, rax
	call	ft_lstsize
	mov		DWORD [rbp-20], eax
	cmp		DWORD [rbp-20], 1
	je		.L27
	mov		rax, QWORD [rbp-16]
	mov		QWORD [rbp-32], rax
	mov		eax, DWORD [rbp-20]
	mov		edx, eax
	shr		edx, 31
	add		eax, edx
	sar		eax, 1
	mov		DWORD [rbp-4], eax
	jmp		.L25
.L26:
	mov		rax, QWORD [rbp-16]
	mov		rax, QWORD [rax+8]
	mov		QWORD [rbp-16], rax
.L25:
	sub		DWORD [rbp-4], 1
	cmp		DWORD [rbp-4], 0
	jne		.L26
	mov		rax, QWORD [rbp-16]
	mov		rax, QWORD [rax+8]
	mov		QWORD [rbp-40], rax
	mov		rax, QWORD [rbp-16]
	mov		QWORD [rax+8], 0
	mov		rdx, QWORD [rbp-64]
	lea		rax, [rbp-32]
	mov		rsi, rdx
	mov		rdi, rax
	call	ft_merge_lstsort
	mov		rdx, QWORD [rbp-64]
	lea		rax, [rbp-40]
	mov		rsi, rdx
	mov		rdi, rax
	call	ft_merge_lstsort
	mov		rcx, QWORD [rbp-40]
	mov		rax, QWORD [rbp-32]
	mov		rdx, QWORD [rbp-64]
	mov		rsi, rcx
	mov		rdi, rax
	call	merge
	mov		rdx, QWORD [rbp-56]
	mov		QWORD [rdx], rax
	jmp		.L22
.L27:
	nop
.L22:
	leave
	ret
