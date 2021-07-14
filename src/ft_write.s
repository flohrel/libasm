# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_write.s                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flohrel <flohrel@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/01 18:01:00 by flohrel           #+#    #+#              #
#    Updated: 2021/07/03 12:34:35 by flohrel          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

; Print characters from a file descriptor
;
; Inputs:	RDI = file descriptor
;			RSI = address of string
;			RDX = nb of bytes to write
; Outputs:	RAX = return value (-1 if error, else number of bytes printed)
; Clobbers:	flags

	extern	__errno_location
	global	ft_write

ft_write:
	mov		rax, 1						;; system call 1 = write
	syscall
	cmp		rax, 0						;; check write return value
	jl		.error						;; jump to error if negative
	ret									;; else return
.error:
	neg		rax							;; get absolute value of syscall return
	mov		rdi, rax					;; pass value as 1st parameter
	call	__errno_location wrt ..plt	;; get errno pointer
	mov		[rax], rdi					;; set errno
	mov		rax, -1						;; set write return value to -1
	ret
