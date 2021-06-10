# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_strlen.s                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flohrel <flohrel@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/01 18:00:52 by flohrel           #+#    #+#              #
#    Updated: 2021/05/01 18:00:54 by flohrel          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

; Determines the length of a C-style NUL-terminated string
;
; Inputs:	RDI = address of beginning of string buffer
; Outputs:	RAX = length of the string, excluding NUL terminator

	global	ft_strlen

ft_strlen:
	push	rbp
	mov		rbp, rsp
	mov		rcx, -1
	mov		rsi, rdi
	xor		al, al
	repne	scasb
	sub		rdi, rsi
	dec		rdi
	mov		rax, rdi
	leave
	ret
