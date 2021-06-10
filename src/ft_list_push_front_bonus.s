# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_list_push_front_bonus.s                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flohrel <flohrel@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/01 17:59:32 by flohrel           #+#    #+#              #
#    Updated: 2021/05/27 13:03:35 by flohrel          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

	extern	malloc
	global	ft_list_push_front

ft_list_push_front:
	cmp		rsi, 0					;; check if pointer to list pointer is NULL
	jz		.exit
	cmp		rdi, 0					;; check if pointer to data is NULL
	jz		.exit
	push	rdi						;; save address of list
	mov		rdi, 16					;; size of struct
	call	malloc
	cmp		rax, 0					;; if pointer to new struct == NULL
	jz		.exit
	mov		[rax], rsi				;; save data pointer in struct
	mov		rcx, [rdi]				;; save old first
	mov		[rax+8], rcx			;; next = old first
	mov		[rdi], rax				;; new first = new struct
.exit:
	ret
