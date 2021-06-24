# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_list_last.s                                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flohrel <flohrel@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/06/19 15:22:39 by flohrel           #+#    #+#              #
#    Updated: 2021/06/19 15:22:50 by flohrel          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

	global	ft_list_last

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

