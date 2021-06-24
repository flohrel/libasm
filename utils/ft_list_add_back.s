# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_list_add_back.s                                 :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flohrel <flohrel@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/06/19 15:21:04 by flohrel           #+#    #+#              #
#    Updated: 2021/06/19 15:21:06 by flohrel          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

	global	ft_list_add_back
	extern	malloc

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
