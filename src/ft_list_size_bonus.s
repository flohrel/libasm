# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_list_size_bonus.s                               :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flohrel <flohrel@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/02 06:34:30 by flohrel           #+#    #+#              #
#    Updated: 2021/07/15 13:57:07 by flohrel          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

; Get size of linked list
;
; Inputs:	RDI = address of list
; Outputs:	RAX = size of list
; Clobbers:	flags

	global	ft_list_size

ft_list_size:
	push	rbp
	mov		rbp, rsp
	sub		rsp, 16
	mov		QWORD [rbp-8], rdi
	cmp		QWORD [rbp-8], 0
	jne		.recur
	mov		eax, 0
	jmp		.return
.recur:
	mov		rax, QWORD [rbp-8]
	mov		rax, QWORD [rax+8]
	mov		rdi, rax
	call	ft_list_size
	add		eax, 1
.return:
	leave
	ret


