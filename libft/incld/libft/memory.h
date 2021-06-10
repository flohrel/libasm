/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   memory.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mtogbe <mtogbe@student.42.fr>              +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/05/14 17:34:47 by mtogbe            #+#    #+#             */
/*   Updated: 2021/05/26 19:01:51 by flohrel          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef MEMORY_H
# define MEMORY_H

# include <stdlib.h>
# include "type.h"
# include "string.h"
# include "list.h"

void			*ft_calloc(size_t nmemb, size_t size);
void			*lst_alloc(size_t nmemb, size_t size, t_list **lst);
void			free_ptr(void *ptr, t_list **head);
void			free_ptr_lst(t_list **lst);

#endif
