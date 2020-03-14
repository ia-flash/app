#######################
# Step 1: Base target #
#######################
FROM nginx:latest as dev

COPY dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

LABEL traefik.enable="true"
LABEL traefik.http.routers.nginx.entrypoints="http"
LABEL traefik.http.routers.nginx.rule="Host(`localhost`)"
LABEL traefik.http.services.nginx.loadbalancer.server.port="80"

################################
# Step 2: "production" target #
################################

FROM dev as prod

LABEL traefik.http.routers.nginx.middlewares="https-redirect@file"
LABEL traefik.http.routers.nginx-secure.entrypoints="https"
LABEL traefik.http.routers.nginx-secure.rule="Host(`localhost`)"
LABEL traefik.http.routers.nginx-secure.tls="true"
LABEL traefik.http.routers.nginx-secure.tls.certresolver="http"
LABEL traefik.http.routers.nginx-secure.service="nginx"

EXPOSE 443
