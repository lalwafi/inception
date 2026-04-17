DIR = /home/${USER}

all: inception

inception:
	mkdir -p ${DIR}/data/mariadb
	mkdir -p ${DIR}/data/wordpress
	docker-compose -f ./srcs/docker-compose.yml up --build -d

down:
	docker-compose -f ./srcs/docker-compose.yml down

up:
	docker-compose -f ./srcs/docker-compose.yml up -d

clean:
	docker-compose -f ./srcs/docker-compose.yml down --rmi all -v --remove-orphans 2>/dev/null || true

fclean: clean
	sudo rm -rf ${DIR}/data/*
	docker rmi -f $$(docker images -a -q) 2> /dev/null || true
	docker volume prune -f

re: fclean all

.PHONY: all inception down up clean fclean re
