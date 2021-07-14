/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: flohrel <flohrel@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/06/25 04:44:07 by flohrel           #+#    #+#             */
/*   Updated: 2021/07/14 16:21:39 by flohrel          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include "libasm.h"
#include "utils/utils.h"

void	clean_exit(t_list **lst)
{
	ft_lstclear(lst, free);
	exit(0);
}

void	display_list(t_list *lst)
{
	while (lst != NULL)
	{
		printf("%d ", *(int *)lst->content);
		lst = lst->next;
	}
	printf("\n");
}

int	int_cmp(void *nb1, void *nb2)
{
	return (*(int *)nb1 - *(int *)nb2);
}

void	lst_add(t_list **lst, int value)
{
	int		*nb;

	nb = ft_calloc(1, sizeof(*nb));
	if (!nb)
		clean_exit(lst);
	*nb = value;
	ft_list_push_front(lst, nb);
}

/*void	ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(),
		void (*free_fct)(void *))
{
	t_list	*prev;
	t_list	*lst;
	t_list	*tmp;

	lst = *begin_list;
	while (lst != NULL)
	{
		tmp = lst;
		lst = lst->next;
		if (cmp(tmp->content, data_ref) == 0)
		{
			if (tmp == *begin_list)
				*begin_list = lst;
			else
				prev->next = lst;
			free_fct(tmp->content);
			free(tmp);
		}
		else
			prev = tmp;
	}
}*/

/*char	**str_init(void)
{
	char	**strs;
	char	*str;
}*/

int	main(int argc, char **argv)
{
	t_list	*lst;
	int		nb;
	int		*ref;


	(void)argc;

	lst = NULL;
	ref = ft_calloc(1, sizeof(*ref));
	if (!ref)
		clean_exit(&lst);
	*ref = ft_atoi_base(argv[1], "0123456789");
	if (argc > 2)
	{
		while (*(++argv))
		{
			nb = ft_atoi_base(*argv, "0123456789");
			lst_add(&lst, nb);
		}
		display_list(lst);
		ft_list_sort(&lst, int_cmp);
		display_list(lst);
		ft_list_remove_if(&lst, ref, int_cmp, free);
		display_list(lst);
	}
	clean_exit(&lst);
	return (0);
}
