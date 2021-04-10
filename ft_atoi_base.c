/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_atoi_base.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: flohrel <flohrel@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/09/13 12:52:41 by flohrel           #+#    #+#             */
/*   Updated: 2020/09/21 13:33:37 by flohrel          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

int	ft_isspace(char *c)
{
	return (*c == '\t' || *c == '\n' || *c == '\v'
			|| *c == '\f' || *c == '\r' || *c == ' ');
}

int	ft_isnum_base(char *c, char *base)
{
	int i;

	i = 0;
	while (base[i])
	{
		if (*c == base[i])
			return (i);
		i++;
	}
	return (-1);
}

int	ft_isvalid(char *base)
{
	char	*ptr;
	int		bsize;

	if (!base)
		return (0);
	bsize = 0;
	while (*base)
	{
		if (*base == '+' || *base == '-' || *base < 33 || *base > 126)
			return (0);
		ptr = base + 1;
		while (*ptr)
		{
			if (*ptr == *base)
				return (0);
			ptr++;
		}
		base++;
		bsize++;
	}
	return (bsize);
}

int	ft_atoi_base(char *str, char *base)
{
	int ret;
	int sign;
	int val;
	int bsize;

	if ((bsize = ft_isvalid(base)) < 2)
		return (0);
	while (ft_isspace(str))
		str++;
	sign = 1;
	while (*str == '+' || *str == '-')
	{
		if (*str == '-')
			sign *= -1;
		str++;
	}
	ret = 0;
	while ((val = ft_isnum_base(str, base)) > -1)
	{
		ret = (ret * bsize) + val;
		str++;
	}
	return (sign * ret);
}
