# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_list_sort_bonus.s                               :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flohrel <flohrel@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/02 06:43:57 by flohrel           #+#    #+#              #
#    Updated: 2021/06/19 20:47:04 by flohrel          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

	extern	malloc
	extern	ft_list_size
	global	ft_list_sort

ft_list_sort:
	push	rbp
	mov		rbp, rsp
	test	rdi, rdi			; test lst not a NULL ptr
	jz		.exit
	test	rsi, rsi			; test cmp not a NULL ptr
	jz		.exit
	call	merge_sort
.exit:
	leave
	ret

merge_sort:
	push	rbp
	mov		rbp, rsp
	push	rdi
	mov		rdi, [rdi]			; put *lst in rdi
	push	rdi
	call	ft_list_size
	pop		rdi
	cmp		rax, 1				; test if size == 1
	jz		.return
	xor		rdx, rdx
	mov		rcx, 2
	div		rcx
	mov		r8, rdi				; r8 is left
.loop:
	dec		rax
	test	rax, rax
	jz		.return
	mov		rdi, [rdi+8]
	jmp		.loop
.next:
	mov		r9, [rdi+8]			; r9 is right
	mov		QWORD [rdi+8], 0	; end left with NULL
	lea		rdi, [r8]
	call	merge_sort
	lea		rdi, [r9]
	call	merge_sort
	mov		rdi, r8
	mov		rdx, rsi
	mov		rsi, r9
	call	merge
	pop		rdi
	mov		[rdi], rax
.return:
	leave
	ret

merge:
	push	rbp
	mov		rbp, rsp
	sub		rsp, 16				; two local vars
	xor		rsp, rsp			; set merged list pointer to NULL
.loop:
	test	rsi, rsi
	jz		.L3
	test	rdi, rdi
	jz		.L4
	push	rsi
	push	rdi
	mov		rsi, [rsi]
	mov		rdi, [rdi]
	call	rdx
	pop		rdi
	pop		rsi
	cmp		rax, 0
	jg		.L2
.L1:
	mov		[rsp+8], rdi
	mov		rdi, [rdi+8]
	jmp		.next
.L2:
	mov		[rsp+8], rsi
	mov		rsi, [rsi+8]
.next:
	mov		rcx, [rsp+8]
	mov		r11, [rcx+8]
	xor		r11, r11
	push	rsi
	push	rdi
	mov		rsi, [rsp+8]
	lea		rdi, [rsp]
	call	ft_list_add_back
	pop		rdi
	pop		rsi
	jmp		.loop
.L3:
	mov		rsi, rdi
.L4:
	lea		rdi, [rsp]
	call	ft_list_add_back
	mov		rax, rsp
	leave
	ret

ft_list_last:
	push	rbp
	mov		rbp, rsp
	test	rdi, rdi			; cmp lst to NULL
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
	pop		rcx					; put list in rcx
	mov		rdi, [rcx]			; dereference list in rdi
	mov		rsi, rax			; move pointer to new struct in rsi
	call	ft_list_last
	test	rax, rax
	jnz		.add_back
	mov		[rcx], rsi
	jmp		.exit
.add_back:
	mov		[rax+8], rsi
.exit:
	leave
	ret
