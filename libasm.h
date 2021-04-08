#ifndef LIBASM_H
# define LIBASM_H

#include <sys/types.h>
#include <errno.h>

ssize_t		ft_write(int, char *, size_t);
//ssize_t		ft_read(int, char *, size_t);
size_t		ft_strlen(const char *);
char		*ft_strcpy(const char *, const char *);
int			ft_strcmp(const char *, const char *);
//char		*ft_strdup(char *);

#endif
