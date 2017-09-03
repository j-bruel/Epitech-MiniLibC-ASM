##
## Makefile for Makefile in asm_minilibc
##
## Made by bruel_a
## Login   <jonathan.bruel@epitech.eu>
##
## Started on  Mon Mar  6 21:00:26 2017 bruel_a
## Last update Fri Mar 24 13:33:55 2017 bruel_a
##

##
## !*********!
## ! Sources !
## !*********!
##

SRC =			src/strlen.asm \
			src/strchr.asm \
			src/strcspn.asm \
			src/memset.asm \
			src/memcpy.asm \
			src/memmove.asm \
			src/strcmp.asm \
			src/strncmp.asm \
			src/strcasecmp.asm \
			src/rindex.asm \
			src/strstr.asm \
			src/strpbrk.asm

##
## !*******!
## ! Bonus !
## !*******!
##

SRC +=			src/strnlen.asm \
			src/index.asm \
			src/strchrnul.asm \
			src/strrchr.asm \
			src/putstr.asm \
			src/putnstr.asm

##
## !*********!
## !  Utils  !
## !*********:
##

CC =			ld

ASM =			nasm

RM =			rm -f

NAME =			libasm.so

OBJ =			$(SRC:.asm=.o)

CFLAGS	=		-shared -fPIC
ASMFLAGS =		-f elf64

%.o: %.asm
			$(ASM) -o $@ $< $(ASMFLAGS)

##
## !***************!
## ! Instructions  !
## !***************!
##

all:			$(NAME)

$(NAME):		$(OBJ)
			$(CC) $(CFLAGS) -o $(NAME) $(OBJ)

clean:
			$(RM) $(OBJ)

fclean:			clean
			$(RM) $(NAME)

re:			fclean all

.PHONY:			all clean fclean re
