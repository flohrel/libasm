#ifndef LIBASM_H
# define LIBASM_H

#include <sys/types.h>
#include <stdlib.h>
#include <errno.h>

typedef struct s_list	t_list;

struct s_list
{
	void	*content;
	t_list	*next;
};

ssize_t	ft_write(int, char *, size_t);
ssize_t	ft_read(int, char *, size_t);
size_t	ft_strlen(const char *);
char	*ft_strcpy(const char *, const char *);
int		ft_strcmp(const char *, const char *);
char	*ft_strdup(char *);

/*
**		BONUS
*/
int		ft_atoi_base(char *str, char *base);
void	ft_list_push_front(t_list **begin_list, void *data);
int		ft_list_size(t_list *lst);
void	ft_list_sort(t_list **lst, int (*cmp)(void *, void *));
void	ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(),
		void (*free_fct)(void *));


#endif
