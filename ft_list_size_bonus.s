# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_list_size_bonus.s                               :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flohrel <flohrel@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/02 06:34:30 by flohrel           #+#    #+#              #
#    Updated: 2021/05/02 06:43:25 by flohrel          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

	global	ft_list_size

ft_list_size:
	xor		rax, rax
.loop:
	cmp		rdi, 0
	jz		.exit
	mov		rdi, [rdi+8]
	inc		rax
	jmp		loop
.exit
	ret
