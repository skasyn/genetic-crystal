SRC	=	./main.cr

NAME	=	monkey

all:	$(NAME)

$(NAME):
		crystal build -o $(NAME) $(SRC)

clean:
	@$(RM) $(NAME)
	@echo -en "[32m[OK][0m"
	@echo -e "[91m [CLEANING][0m"

re:	clean all

.PHONY: all clean re
