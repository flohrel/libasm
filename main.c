/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */

/*                                                    +:+ +:+         +:+     */
/*   By: flohrel <flohrel@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/06/25 04:44:07 by flohrel           #+#    #+#             */
/*   Updated: 2021/07/15 14:06:01 by flohrel          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <stdint.h>
#include "libasm.h"
#include "ansi_colors.h"

void	*ft_memset(void *s, int c, size_t n)
{
	char	*str;

	str = (char *)s;
	while (n--)
		*str++ = c;
	return (s);
}

void	*ft_calloc(size_t nmemb, size_t size)
{
	char	*ptr;
	size_t	tsize;
	size_t	maxsqrt;

	if ((SIZE_MAX / 641u / 6700417u) >= 4294967295u)
		maxsqrt = 65535;
	else
		maxsqrt = 4294967295;
	if (((nmemb > maxsqrt) || (size > maxsqrt))
		&& ((SIZE_MAX / nmemb) < size))
		return (NULL);
	tsize = nmemb * size;
	ptr = malloc(tsize);
	if (!ptr)
		return (ptr);
	ft_memset(ptr, 0, tsize);
	return (ptr);
}

void	ft_lstdelone(t_list *lst, void (*del)(void *))
{
	if (lst && del)
	{
		del(lst->content);
		free(lst);
	}
}

void	ft_lstclear(t_list **lst, void (*del)(void *))
{
	t_list	*lptr;
	t_list	*next;

	if (*lst && del)
	{
		lptr = *lst;
		while (lptr)
		{
			next = lptr->next;
			ft_lstdelone(lptr, del);
			lptr = next;
		}
		*lst = NULL;
	}
}

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

void	print_header(char *str)
{
	int	i;
	int	len;

	len = strlen(str) + 20;
	printf(MAG);
	while (i++ < len)
		printf("#");
	printf("\n");
	printf("#####     "GRN"%s"MAG"     #####\n", str);
	while (--i)
		printf("#");
	printf("\n");
	printf(RESET);
}

void	list_test(void)
{
	t_list	*lst;
	int		nb;
	int		*ref;

	lst = NULL;
	ref = ft_calloc(1, sizeof(*ref));
	if (!ref)
		clean_exit(&lst);
	*ref = ft_atoi_base(, "0123456789");
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
}

int	main(void)
{
	char	s[15];


	return (0);
}
