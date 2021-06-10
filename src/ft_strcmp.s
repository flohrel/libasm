# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_strcmp.s                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flohrel <flohrel@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/01 18:00:32 by flohrel           #+#    #+#              #
#    Updated: 2021/05/01 18:01:40 by flohrel          ###   ########.fr        #
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
	xor		rax, rax
	jmp		.L2

.L1:
	inc		rax

.L2:
	mov		cl, BYTE [rdi+rax]
	cmp		cl, 0
	jz		.compare
	cmp		BYTE [rsi+rax], cl
	je		.L1

.compare:
	cmp		BYTE [rsi+rax], cl
	ja		.greater
	jb		.lower

.equal:
	xor		rax, rax
	ret

.greater:
	mov		rax, -1
	ret

.lower:
	mov		rax, 1
	ret
