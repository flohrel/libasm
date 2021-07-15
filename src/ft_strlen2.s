# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_strlen2.s                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flohrel <flohrel@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/01 18:00:52 by flohrel           #+#    #+#              #
#    Updated: 2021/07/03 12:28:37 by flohrel          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

; Determines the length of a C-style NUL-terminated string
;
; Inputs:	RDI = address of beginning of string buffer
; Outputs:	RAX = length of the string, excluding NUL terminator
; Clobbers:	RDX, flags

	global	ft_strlen

ft_strlen:
	push	rbp
	mov		rbp, rsp
	mov		QWORD [rbp-16], rdi
	mov		rax, QWORD [rbp-16]
	mov		QWORD [rbp-8], rax
	cmp		QWORD [rbp-8], 0
	je		.return
.loop:
	mov		rax, QWORD [rbp-8]
	lea		rdx, [rax+1]
	mov		QWORD [rbp-8], rdx
	movzx	eax, BYTE [rax]
	test	al, al
	jne		.loop
.return:
	mov		rax, QWORD [rbp-8]
	sub		rax, QWORD [rbp-16]
	sub		rax, 1
	pop		rbp
	ret
