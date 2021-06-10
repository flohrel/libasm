# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_list_sort_bonus.s                               :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flohrel <flohrel@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/02 06:43:57 by flohrel           #+#    #+#              #
#    Updated: 2021/06/10 13:13:18 by flohrel          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

	global	ft_list_sort

ft_list_sort:
	push	rbp					; preserve
	mov		rbp, rsp			;    stack
	test	rdi, rdi			; test list not a NULL ptr
	jz		.exit
	mov		r8, [rdi]			; pointer to begining of list in r8
	push	rdi					; save start of list in stack
	test	rsi, rsi			; test cmp func not a NULL ptr
	jz		.exit
	mov		rdx, rsi			; ptr to cmp func in rdx
	push	rsi					; save sort func ptr in stack
.loop:
	mov		r9, [r8 + 8]		; get next lst
	test	r9, r9				; test if NULL
	jz		.exit
	
.exit:
	leave
	ret
