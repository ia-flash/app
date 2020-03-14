#######################
# Step 1: Base target #
#######################
FROM traefik:2.2 as dev
ARG LOG_LEVEL

COPY acme.json /acme.json

EXPOSE 80

CMD ["traefik", "--log.level=${LOG_LEVEL}", "--entryPoints.http.address=:80", "--entryPoints.https.address=:443", "--providers.docker=true", "--providers.docker.watch=true", "--providers.docker.endpoint=unix:///var/run/docker.sock", "--providers.docker.exposedByDefault=false"]

################################
# Step 2: "production" target #
################################
FROM dev as prod

EXPOSE 443
