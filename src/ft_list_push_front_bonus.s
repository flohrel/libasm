# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_list_push_front_bonus.s                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flohrel <flohrel@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/01 17:59:32 by flohrel           #+#    #+#              #
#    Updated: 2021/06/16 15:48:47 by flohrel          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

; Push new ptr to begining of list
;
; Inputs:	RDI = address of list
;			RSI = content of new node
; Outputs:
; Clobbers:	flags, RCX

	extern	malloc
	global	ft_list_push_front

ft_list_push_front:
	push	rbp						; preserve
	mov		rbp, rsp				;   stack
	test	rdi, rdi				; check if address of list is NULL
	jz		.exit
	push	rdi						; save address of list
	push	rsi
	mov		rdi, 16					; size of struct
	call	malloc
	test	rax, rax				; if pointer to new struct == NULL
	jz		.exit
	pop		rsi
	mov		[rax], rsi				; save data pointer in struct
	pop		rdi
	mov		rcx, [rdi]
	mov		[rax+8], rcx			;
	mov		[rdi], rax				;
.exit:
	leave
	ret
