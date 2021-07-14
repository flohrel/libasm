# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_strcmp.s                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flohrel <flohrel@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/01 18:00:32 by flohrel           #+#    #+#              #
#    Updated: 2021/07/03 12:43:31 by flohrel          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

; Determines the length of a C-style NUL-terminated string
;
; Inputs:	RDI = address of first string
;			RSI = address of second string
; Outputs:	RAX = difference between strings (-1/0/1 if lt/eq/gt)
; Clobbers:	CL, flags

	global	ft_strcmp

ft_strcmp:
	push	rbp
	mov		rbp, rsp
	mov		QWORD [rbp-8], rdi
	mov		QWORD [rbp-16], rsi
	jmp		.loop
.cmp:
	mov		rax, QWORD [rbp-8]
	movzx	edx, BYTE [rax]
	mov		rax, QWORD [rbp-16]
	movzx	eax, BYTE [rax]
	cmp		dl, al
	jne		.return
	add		QWORD [rbp-8], 1
	add		QWORD [rbp-16], 1
.loop:
	mov		rax, QWORD [rbp-8]
	movzx	eax, BYTE [rax]
	test	al, al
	jne		.cmp
	jmp		.return
.return:
	mov		rax, QWORD [rbp-8]
	movzx	eax, BYTE [rax]
	movzx	edx, al
	mov		rax, QWORD [rbp-16]
	movzx	eax, BYTE [rax]
	movzx	ecx, al
	mov		eax, edx
	sub		eax, ecx
	pop		rbp
	ret
