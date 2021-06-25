# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_read.s                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flohrel <flohrel@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/01 18:00:26 by flohrel           #+#    #+#              #
#    Updated: 2021/06/25 05:50:52 by flohrel          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

; Read characters from a file descriptor
;
; Inputs:	RDI = file descriptor
;			RSI = address of string
;			RDX = size of string
; Outputs:	RAX = return value (-1 if error, 0 if EOF, or nb bytes read)
; Clobbers:	flags

	extern	__errno_location
	global	ft_read

ft_read:
	xor		rax, rax					;; system call 0 = read
	syscall
	cmp		rax, 0						;; check return value
	jl		error						;; jump to error if negative
	ret									;; else return

error:
	neg		rax							;; get absolute value of syscall return
	mov		rdi, rax					;; pass value as 1st parameter
	call	__errno_location wrt ..plt	;; get errno pointer
	mov		[rax], rdi					;; set errno
	mov		rax, -1						;; set write return value to -1
	ret
