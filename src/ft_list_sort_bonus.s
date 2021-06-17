# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_list_sort_bonus.s                               :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flohrel <flohrel@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/02 06:43:57 by flohrel           #+#    #+#              #
#    Updated: 2021/06/15 05:58:41 by flohrel          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

	extern	ft_list_size
	global	ft_list_sort

ft_list_sort:
	push	rbp						; preserve
	mov		rbp, rsp				;    stack
	test	rdi, rdi				; test lst not a NULL ptr
	jz		.exit
	test	rsi, rsi				; test cmp not a NULL ptr
	jz		.exit
	call	merge_sort
	mov		[rdi], rax
.exit:
	leave
	ret

merge_sort:
	push	rbp						; preserve
	mov		rbp, rsp				;    stack
	push	rdi
	mov		rdi, [rsp]			; put *lst in rdi
	call	ft_list_size
	cmp		rax, 1				; test if size == 1
	jz		.return
	mov		rdx, 2
	div		rdx
	mov		r8, rax
	mov		r9, rdi				; r9 is left
.loop:
	sub		r8, 1
	test	r8, r8
	jz		.next
	mov		rdi, [rdi+8]
	jmp		.loop
.next:
	mov		r10, [rdi+8]		; r10 is right
	mov		QWORD [rdi+8], 0	; end left with NULL
	lea		rdi, [r9]
	call	merge_sort
	lea		rdi, [r10]
	call	merge_sort
	mov		rdi, r9
	mov		rdx, rsi
	mov		rsi, r10
	call	merge
.return:
	leave
	ret

merge:
	push	rbp						; preserve
	mov		rbp, rsp				;    stack
	sub		rsp, 16					; two local vars
	xor		rsp, rsp				; set merged list pointer to NULL
.loop:
	test	rsi, rsi
	jz		.L3
	test	rdi, rdi
	jz		.L4
	call	rdx
	cmp		rax, 0
	jg		.L1
	jmp		.L2
.L1:
	mov		[rsp+8], rsi
	mov		rsi, [rsi+8]
	jmp		.next
.L2:
	mov		[rsp+8], rdi
	mov		rdi, [rdi+8]
	jmp		.next
.next:
	mov		rcx, [rsp+8]
	mov		r11, [rcx+8]
	xor		r11, r11
	push	rsi
	push	rdi
	mov		rsi, [rsp+8]
	lea		rdi, [rsp]
	call	ft_lst_add_back
	pop		rdi
	pop		rsi
	jmp		.loop
.L3:
	mov		rsi, rdi
.L4:
	mov		rdi, [rsp]
	call	ft_lst_add_back
	mov		rax, rsp
	leave
	ret

ft_lst_last:
	push	rbp
	mov		rbp, rsp
	mov		rax, rdi
	cmp		rax, 0
	je		.exit
.loop:
	mov		rax, [rax+8]
	test	rax, rax
	jne		.loop
.exit:
	leave
	ret

ft_lst_add_back:
	push	rbp
	mov		rbp, rsp
	test	rsi, rsi
	jz		.exit
	push	rsi
	mov		rsi, [rsp]
	test	rsi, rsi
	jz		.L1
	call	ft_lst_last
	mov		[rax+8], rsi
	jmp		.exit
.L1:
	mov		rsi, rdi
.exit:
	leave
	ret
