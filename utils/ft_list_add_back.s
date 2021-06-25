# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_list_add_back.s                                 :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flohrel <flohrel@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/06/19 15:21:04 by flohrel           #+#    #+#              #
#    Updated: 2021/06/25 05:13:52 by flohrel          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

	extern	ft_list_last
	global	ft_list_add_back

ft_list_add_back:
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
	call	ft_list_last
	mov		QWORD [rbp-8], rax
	mov		rax, QWORD [rbp-8]
	mov		rdx, QWORD [rbp-32]
	mov		QWORD [rax+8], rdx
.L9:
	leave
	ret
