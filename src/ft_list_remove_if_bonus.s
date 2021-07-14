# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_list_remove_if_bonus.s                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flohrel <flohrel@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/06/25 05:45:44 by flohrel           #+#    #+#              #
#    Updated: 2021/07/14 16:22:33 by flohrel          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

	global	ft_list_remove_if
	extern	free

ft_list_remove_if:
	push	rbp
	mov		rbp, rsp
	sub		rsp, 64
	mov		QWORD [rbp-40], rdi
	mov		QWORD [rbp-48], rsi
	mov		QWORD [rbp-56], rdx
	mov		QWORD [rbp-64], rcx
	mov		rax, QWORD [rbp-40]
	mov		rax, QWORD [rax]
	mov		QWORD [rbp-16], rax
	jmp		.cmp
.loop:
	mov		rax, QWORD [rbp-16]
	mov		QWORD [rbp-24], rax
	mov		rax, QWORD [rbp-16]
	mov		rax, QWORD [rax+8]
	mov		QWORD [rbp-16], rax
	mov		rax, QWORD [rbp-24]
	mov		rax, QWORD [rax]
	mov		rdx, QWORD [rbp-48]
	mov		rcx, QWORD [rbp-56]
	mov		rsi, rdx
	mov		rdi, rax
	mov		eax, 0
	call	rcx
	test	eax, eax
	jne		.next
	mov		rax, QWORD [rbp-40]
	mov		rax, QWORD [rax]
	cmp		QWORD [rbp-24], rax
	jne		.join
	mov		rax, QWORD [rbp-40]
	mov		rdx, QWORD [rbp-16]
	mov		QWORD [rax], rdx
	jmp		.free
.join:
	mov		rax, QWORD [rbp-8]
	mov		rdx, QWORD [rbp-16]
	mov		QWORD [rax+8], rdx
.free:
	mov		rax, QWORD [rbp-24]
	mov		rax, QWORD [rax]
	mov		rdx, QWORD [rbp-64]
	mov		rdi, rax
	call	rdx
	mov		rax, QWORD [rbp-24]
	mov		rdi, rax
	call	free
	jmp		.cmp
.next:
	mov		rax, QWORD [rbp-24]
	mov		QWORD [rbp-8], rax
.cmp:
	cmp		QWORD [rbp-16], 0
	jne		.loop
	leave
	ret
