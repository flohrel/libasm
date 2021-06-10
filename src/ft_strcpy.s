# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_strcpy.s                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flohrel <flohrel@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/01 18:00:37 by flohrel           #+#    #+#              #
#    Updated: 2021/05/01 18:00:39 by flohrel          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

; Determines the length of a C-style NUL-terminated string
;
; Inputs:	RDI = address of string copy
;			RSI = address of source string
; Outputs:	RAX = address of string copy
; Clobbers:	CL, flags

	global	ft_strcpy

ft_strcpy:
	mov		rax, -1

loop:
	inc		rax
	mov		cl, [rsi+rax]
	mov		[rdi+rax], cl
	cmp		BYTE [rsi+rax], 0
	jnz		loop

exit:
	mov		rax, rdi
	ret
