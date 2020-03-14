#########
#  APP  #
#########

export PROJECT_NAME=main
export APP_PORT=5000
export LOG_LEVEL=DEBUG

#############
#  Traefik  #
#############

export TRAEFIK_FRONTEND_RULE=PathPrefix:/
export ACME_ENABLE=false
export ACME_EMAIL=user@example.com
export ACME_DOMAINS=example.com,www.example.com
export DOCKER_DOMAIN="dev.example"
export TRAEFIK_DEFAULT_ENTRYPOINTS=http
export TRAEFIK_ENTRYPOINT_HTTP=--entryPoints="Name:http Address::80"

############
#  Docker  #
############

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
