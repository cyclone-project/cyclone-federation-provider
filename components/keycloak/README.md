cycloneproject/keycloak-postgres-base
=====================================

Base Repository: [github.com/cyclone-project/cyclone-federation-provider](https://github.com/cyclone-project/cyclone-federation-provider)

This repository provides a docker image for Keycloak with postgresql as its datastore, extended with configuration to work behind a reverse proxy, an entrypoint-wrapper to enable full imports on first run (of the container), and themed for the cyclone-project.

Extends [cycloneproject/keycloak-postgres](https://hub.docker.com/r/cycloneproject/keycloak-postgres) which provides the cyclone client registration module to keycloak.

## How to use

__NOTE:__ You need to start/have a postgres instance running with the same options (where applicable, e.g. the POSTGRES_ options) as defined below.

### Use image directly
You can use this image directly. There is a number of configuration options through env variables.

- `KC_IMPORT`: Whether to import a provided kcexport.json file on first run
- `KEYCLOAK_USER` / `KEYCLOAK_PASSWORD`: Keycloak Admin User/Password to create at start
- `POSTGRES_DB`: Postgres database to use and create on start
- `POSTGRES_USER` / `POSTGRES_PASSWORD`: Postgres User/Password
- `POSTGRES_PORT_5432_TCP_ADDR` / `POSTGRES_PORT_5432_TCP_PORT`: Addr/Port where postgres is reachable

Run without import:
```shell
docker run --link postgres:postgres -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=admin -p 8080:8080 cycloneproject/keycloak-postgres-base
```

To run with import, set `KC_IMPORT=true` and provide an exported Keycloak configuration through a volume:
```shell
docker run --link postgres:postgres -e KC_IMPORT=true -v kcexport.json /opt/jboss/exports/kcexport.json -p 8080:8080 cycloneproject/keycloak-postgres-base
```
The endpoint is (by default) at /auth.

For most deployments it is easier to use docker-compose with an accompanying .env file for configuration. See the base repository for examples.

### Extend it
Extend from this image by using in your Dockerfile:
```shell
FROM cycloneproject/keycloak-postgres-base
```

