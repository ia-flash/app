export PROJECT_NAME=iaflash
export APP_PATH := $(shell pwd)
export APP_PORT=5000
export APP_VERSION	:= $(shell git rev-parse HEAD | cut -c1-8)
export EXEC_ENV=dev
export NGINX_PATH=${APP_PATH}/nginx
export TRAEFIK_PATH=${APP_PATH}/traefik
export LOG_LEVEL=DEBUG

export COMPOSE=docker-compose -p $(PROJECT_NAME) -f docker-compose.yml 

dummy               := $(shell touch artifacts)
include ./artifacts

nginx/dist:
	git clone --single-branch --depth=1 --branch builds https://github.com/ia-flash/frontend nginx/dist

traefik/acme.json:
	touch traefik/acme.json

dependencies: nginx/dist traefik/acme.json

build:
	$(COMPOSE) build

dev: dependencies
	$(COMPOSE) up

up: dependencies
	$(COMPOSE) up -d

stop:
	$(COMPOSE) stop

down:
	$(COMPOSE) down --remove-orphans

logs:
	$(COMPOSE) logs -f --tail 50

clean:
	rm -rf dist
