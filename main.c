#include "libasm.h"
#include <string.h>
#include <stdio.h>

int	main(void)
{
	char s[15];

	printf("##################################\n");
	printf("######      ft_strlen     ########\n");
	printf("##################################\n");
	printf("string = \"Hello world!\"\n\n");
	printf("strlen(string) = %lu\n", strlen("Hello world!"));
	printf("ft_strlen(string) = %lu\n\n", ft_strlen("Hello world!"));
	printf("strlen("") = %lu\n", strlen(""));
	printf("ft_strlen("") = %lu\n\n", ft_strlen(""));

	printf("\n##################################\n");
	printf("######      ft_strcpy     ########\n");
	printf("##################################\n");
	printf("string = \"Hello world!\"\n\n");
	printf("strcpy(s, \"\") => s = %s\n", strcpy(s, ""));
	printf("ft_strcpy(s, \"\") => s = %s\n\n", ft_strcpy(s, ""));
	printf("strcpy(s, string) => s = %s\n", strcpy(s, "Hello world!"));
	printf("ft_strcpy(s, string) => s = %s\n\n", ft_strcpy(s, "Hello world!"));

	printf("\n##################################\n");
	printf("######      ft_strcmp     ########\n");
	printf("##################################\n");
	printf("string = \"Hello world!\"\n\n");
	printf("strcmp(\"Hello\", string) = %d\n", strcmp("Hello", "Hello world!"));
	printf("ft_strcmp(\"Hello\", string) = %d\n\n", ft_strcmp("Hello", "Hello world!"));
	printf("strcmp(\"Hello world!\", string) = %d\n", strcmp(s, "Hello world!"));
	printf("ft_strcmp(\"Hello world!\", string) = %d\n", ft_strcmp(s, "Hello world!"));
}
