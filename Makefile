###############
## Variables ##
###############

NAME		=	libasm.a

OBJDIR		=	obj

SRC			=	ft_strlen.s \
				ft_strcpy.s \
				ft_strcmp.s \
				ft_write.s \
				ft_read.s \
				ft_strdup.s \
				ft_atoi_base.s
OBJ			=	$(SRC:%.s=$(OBJDIR)/%.o)

ASM			=	nasm
ASMFLAGS	=	-felf64
CC			=	gcc
CFLAGS		=	-Wall -Werror -Wextra
RM			=	/bin/rm -rf
AR			=	ar
ARFLAGS		=	rcs

ifeq ($(UNAME),Linux)
	ASMFLAGS := -felf64
endif
ifeq ($(UNAME),Darwin)
	ASMFLAGS := -fmacho64
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

debug:			CFLAGS += -fsanitize=address -g3
debug:			re

clean:
				$(RM) $(OBJ) test

fclean:			clean
				$(RM) $(NAME) $(OBJDIR)

re:				fclean all

test:			$(NAME)
				$(CC) $(CFLAGS) main.c -L. -lasm -o test
				./test
