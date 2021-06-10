# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_list_sort_bonus.s                               :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flohrel <flohrel@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/02 06:43:57 by flohrel           #+#    #+#              #
#    Updated: 2021/06/10 15:41:26 by flohrel          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

	extern	ft_list_size
	global	ft_list_sort

ft_list_sort:
	push	rbp					; preserve
	mov		rbp, rsp			;    stack
	test	rdi, rdi			; test list not a NULL ptr
	jz		.exit
#	mov		r8, [rdi]			; pointer to begining of list in r8
#	push	rdi					; save start of list in stack
	test	rsi, rsi			; test cmp func not a NULL ptr
	jz		.exit
#	mov		rdx, rsi			; ptr to cmp func in rdx
#	push	rsi					; save sort func ptr in stack
	call	merge_sort

merge_sort:
	call	ft_list_size
	cmp		rax, 1
	jz		.return
	idiv	rax, 2
	mov		rdx, [rdi+8*rax]
	mov		QWORD [rdi+8*rax], 0
.return:
	mov		rax, rdi
	ret

.exit:
	leave
	ret
