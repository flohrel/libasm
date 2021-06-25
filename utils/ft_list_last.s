# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_list_last.s                                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flohrel <flohrel@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/06/19 15:22:39 by flohrel           #+#    #+#              #
#    Updated: 2021/06/25 05:00:55 by flohrel          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

	global	ft_list_last

ft_list_last:
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
