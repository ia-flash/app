# The Makefile defines all builds/tests steps

# include .env file
include docker/env.list

# compose command to merge production file and and dev/tools overrides
COMPOSE?=docker-compose -p $(PROJECT_NAME) -f docker-compose.yml 

export 

docker/env.list: 
	cp docker/env.list.sample docker/env.list

dist:
	git clone --single-branch --branch builds https://github.com/ia-flash/frontend dist

build: docker/env.list
	$(COMPOSE) build

dev: dist
	$(COMPOSE) up

up: dist
	$(COMPOSE) up -d

stop:
	$(COMPOSE) stop

down:
	$(COMPOSE) down --remove-orphans

logs:
	$(COMPOSE) logs -f --tail 50

clean:
	rm -rf dist
