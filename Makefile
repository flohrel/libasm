###############
## Variables ##
###############

NAME		=	libasm.a

VPATH		=	src
OBJDIR		=	obj

SRC			=	ft_strlen.s \
				ft_strcpy.s \
				ft_strcmp.s \
				ft_write.s \
				ft_read.s \
				ft_strdup.s
BONUS		=	ft_atoi_base.s \
				ft_list_push_front_bonus.s \
				ft_list_size_bonus.s
				#ft_list_sort_bonus.s
OBJ			=	$(SRC:%.s=$(OBJDIR)/%.o)
BOBJ		=	$(BONUS:%.s=$(OBJDIR)/%.o)

ASM			=	nasm
ASMFLAGS	:=	-I./incld
CC			=	gcc
CFLAGS		=	-Wall -Werror -Wextra
RM			=	/bin/rm -rf
AR			=	ar
ARFLAGS		=	rcs
UNAME		:=	$(shell uname -s)

ifeq ($(UNAME),Linux)
	ASMFLAGS += -felf64
endif
ifeq ($(UNAME),Darwin)
	ASMFLAGS += -fmacho64
endif


###########
## Rules ##
###########

.PHONY:			all clean debug fclean re test

all:			$(NAME)

$(OBJDIR)/%.o:	%.s | $(OBJDIR)
				$(ASM) $(ASMFLAGS) $< -o $@

$(NAME):		$(OBJ)
				$(AR) $(ARFLAGS) $@ $^

$(OBJDIR):
				mkdir $(OBJDIR)

bonus:			$(NAME) $(BOBJ)
				$(AR) $(ARFLAGS) $(NAME) $(BOBJ)

debug:			CFLAGS += -fsanitize=address -g3
debug:			re

clean:
				$(RM) $(OBJ) $(BOBJ) test

fclean:			clean
				$(RM) $(NAME) $(OBJDIR)

re:				fclean all

test:			$(NAME)
				$(CC) $(CFLAGS) main.c -L. -lasm -o test
				./test
