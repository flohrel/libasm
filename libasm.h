#ifndef LIBASM_H
# define LIBASM_H

#include <sys/types.h>
#include <errno.h>

typedef struct		s_list
{
	void			*data;
	struct s_list	*next;
}					t_list;

ssize_t				ft_write(int, char *, size_t);
ssize_t				ft_read(int, char *, size_t);
size_t				ft_strlen(const char *);
char				*ft_strcpy(const char *, const char *);
int					ft_strcmp(const char *, const char *);
char				*ft_strdup(char *);

/*
**		BONUS
*/
int					ft_atoi_base(char *str, char *base);
void				ft_list_push_front(t_list **begin_list, void *data);

#endif
