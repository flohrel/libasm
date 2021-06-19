#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include "libasm.h"

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
//	ft_list_push_front(lst, nb);
	ft_list_add_back(lst, nb);
}

int	main(int argc, char **argv)
{
	t_list	*lst;
	int		nb;

	(void)argv;
	lst = NULL;
	if (argc > 2)
	{
		while (*(++argv))
		{
			nb = ft_atoi_base(*argv, "0123456789");
			lst_add(&lst, nb);
		}
		display_list(lst);
//		ft_list_sort(&lst, int_cmp);
	}
	clean_exit(&lst);
}
