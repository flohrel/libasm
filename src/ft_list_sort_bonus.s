# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_list_sort_bonus.s                               :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flohrel <flohrel@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/07/15 09:12:33 by flohrel           #+#    #+#              #
#    Updated: 2021/07/15 13:57:55 by flohrel          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

; Sort list with merge algorithm
;
; Inputs:	RDI = pointer to address of list begininng
;			RSI = compare function
; Outputs:
; Clobbers:	RCX, RDX, flags

	global	ft_list_sort
	extern	ft_list_size

ft_lstlast:
	push	rbp
	mov		rbp, rsp
	mov		QWORD [rbp-8], rdi
	cmp		QWORD [rbp-8], 0
	je		.return
	jmp		.loop
.next:
	mov		QWORD [rbp-8], rax
.loop:
	mov		rax, QWORD [rbp-8]
	mov		rax, QWORD [rax+8]
	test	rax, rax
	jne		.next
.return:
	mov		rax, QWORD [rbp-8]
	pop		rbp
	ret

ft_lstadd_back:
	push	rbp
	mov		rbp, rsp
	sub		rsp, 32
	mov		QWORD [rbp-24], rdi
	mov		QWORD [rbp-32], rsi
	mov		rax, QWORD [rbp-24]
	mov		rax, QWORD [rax]
	test	rax, rax
	jne		.add_back
	mov		rax, QWORD [rbp-24]
	mov		rdx, QWORD [rbp-32]
	mov		QWORD [rax], rdx
	jmp		.return
.add_back:
	mov		rax, QWORD [rbp-24]
	mov		rax, QWORD [rax]
	mov		rdi, rax
	call	ft_lstlast
	mov		QWORD [rbp-8], rax
	mov		rax, QWORD [rbp-8]
	mov		rdx, QWORD [rbp-32]
	mov		QWORD [rax+8], rdx
.return:
	leave
	ret

merge:
	push	rbp
	mov		rbp, rsp
	sub		rsp, 48
	mov		QWORD [rbp-24], rdi
	mov		QWORD [rbp-32], rsi
	mov		QWORD [rbp-40], rdx
	mov		QWORD [rbp-16], 0
	jmp		.loop
.cmp:
	mov		rax, QWORD [rbp-32]
	mov		rdx, QWORD [rax]
	mov		rax, QWORD [rbp-24]
	mov		rax, QWORD [rax]
	mov		rcx, QWORD [rbp-40]
	mov		rsi, rdx
	mov		rdi, rax
	call	rcx
	test	eax, eax
	jle		.left
	mov		rax, QWORD [rbp-32]
	mov		QWORD [rbp-8], rax
	mov		rax, QWORD [rbp-32]
	mov		rax, QWORD [rax+8]
	mov		QWORD [rbp-32], rax
	jmp		.add_back
.left:
	mov		rax, QWORD [rbp-24]
	mov		QWORD [rbp-8], rax
	mov		rax, QWORD [rbp-24]
	mov		rax, QWORD [rax+8]
	mov		QWORD [rbp-24], rax
.add_back:
	mov		rax, QWORD [rbp-8]
	mov		QWORD [rax+8], 0
	mov		rdx, QWORD [rbp-8]
	lea		rax, [rbp-16]
	mov		rsi, rdx
	mov		rdi, rax
	call	ft_lstadd_back
.loop:
	cmp		QWORD [rbp-24], 0
	je		.add_rest
	cmp		QWORD [rbp-32], 0
	jne		.cmp
.add_rest:
	cmp		QWORD [rbp-24], 0
	je		.left_add
	mov		rdx, QWORD [rbp-24]
	lea		rax, [rbp-16]
	mov		rsi, rdx
	mov		rdi, rax
	call	ft_lstadd_back
	jmp		.return
.left_add:
	mov		rdx, QWORD [rbp-32]
	lea		rax, [rbp-16]
	mov		rsi, rdx
	mov		rdi, rax
	call	ft_lstadd_back
.return:
	mov		rax, QWORD [rbp-16]
	leave
	ret

ft_list_sort:
	push	rbp
	mov		rbp, rsp
	sub		rsp, 64
	mov		QWORD [rbp-56], rdi
	mov		QWORD [rbp-64], rsi
	mov		rax, QWORD [rbp-56]
	mov		rax, QWORD [rax]
	mov		QWORD [rbp-16], rax
	mov		rax, QWORD [rbp-16]
	mov		rdi, rax
	call	ft_list_size
	mov		DWORD [rbp-20], eax
	cmp		DWORD [rbp-20], 1
	je		.return
	mov		rax, QWORD [rbp-16]
	mov		QWORD [rbp-32], rax
	mov		eax, DWORD [rbp-20]
	mov		edx, eax
	shr		edx, 31
	add		eax, edx
	sar		eax, 1
	mov		DWORD [rbp-4], eax
	jmp		.loop
.next:
	mov		rax, QWORD [rbp-16]
	mov		rax, QWORD [rax+8]
	mov		QWORD [rbp-16], rax
.loop:
	sub		DWORD [rbp-4], 1
	cmp		DWORD [rbp-4], 0
	jne		.next
	mov		rax, QWORD [rbp-16]
	mov		rax, QWORD [rax+8]
	mov		QWORD [rbp-40], rax
	mov		rax, QWORD [rbp-16]
	mov		QWORD [rax+8], 0
	mov		rdx, QWORD [rbp-64]
	lea		rax, [rbp-32]
	mov		rsi, rdx
	mov		rdi, rax
	call	ft_list_sort
	mov		rdx, QWORD [rbp-64]
	lea		rax, [rbp-40]
	mov		rsi, rdx
	mov		rdi, rax
	call	ft_list_sort
	mov		rcx, QWORD [rbp-40]
	mov		rax, QWORD [rbp-32]
	mov		rdx, QWORD [rbp-64]
	mov		rsi, rcx
	mov		rdi, rax
	call	merge
	mov		rdx, QWORD [rbp-56]
	mov		QWORD [rdx], rax
	jmp		.return
.return:
	leave
	ret
