Cyclone Federation Provider
===========================
[![Build Status](https://travis-ci.org/cyclone-project/cyclone-federation-provider.svg?branch=master)](https://travis-ci.org/cyclone-project/cyclone-federation-provider)

This repository contains the base configuration and demo examples for the cyclone federation provider. The cyclone federation provider allows users to use their existing IDP's SAML SSO (namely [eduGAIN](https://edugain.org) IDPs) with [openid-connect](https://openid.net/connect/) to connect to services. At the same time privacy concerns are taken seriously and user data is deleted after the last session ends. We utilize [docker, docker-compose and docker swarm](https://www.docker.com) extensively for all deployments and provide pre-built docker images tagged with cycloneproject/imageName on [docker hub](https://hub.docker.com).

## Structure
This repository is structured in 3 main directories: components, demo, and ha-demo. The components directory contains the base configuration for building the base images. The demo and ha-demo directories contain example configurations for single-machine (demo) and multi-machine (ha-demo, using docker swarm mode) deployments. Their purpose is to wire the components for interaction.

### Base Structure

The base configuration in the components/ directory for the cyclone federation provider consists of 5 components:

  - [Traefik](https://traefik.io): To reverse-proxy from outside connections to the containers and load-balance.
  - [Keycloak](http://keycloak.org): For openid-connect functionality, attribute mapping, client registration services, and connection to the federation through the samlbridge (SimpleSamlPHP) using SAML. It uses the [cyclone-client-registration](https://github.com/cyclone-project/cyclone-client-registration) module.
  This is the first user-facing component.
  - [SimpleSamlPHP](https://simplesamlphp.org): As a samlbridge to connect with the various IDPs in the federation (i.e. eduGAIN). This is the active participant in the SAML federation and allows us to add and maintain information on hundreds of IDPs. It allows the user to search and choose its home IDP by providing a discovery service frontend, filters the attributes received from said IDP, ensures that sufficient information is available to uniquely identify the user to a service, and chooses which piece of information to choose. Session information (NOT user data) is stored locally using phpsession.
  - [Postgresql](https://postgresql.org): The data store for Keycloak (and in ha-demo: the Samlbridge).
  - Cron: Runs two tasks periodically: (1) prompts SimpleSamlPHP to update IDP metadata hourly and (2) calls to the Keycloak REST API to determine and delete user data of users with no sessions.

Only three components build docker images (the rest uses pre-built images):

  - cycloneproject/keycloak-postgres-base
  - cycloneproject/samlbridge-base
  - cycloneproject/cron

![Provider Connection Architecture](docs/cyclone-diagram.png)
__Image:__ Provider Connection Architecture

### Demo Structure

Demo (in the demo/ directory) and base configurations are mostly the same. Main differences are a demo SAML IDP (the DemoIDP) as the 6th component, the provided kcexport_template.json file to configure Keycloak, and SAML metadata for the Samlbridge in samlbridge-sp-remote.php (to connect Samlbridge and Keycloak) and samlbridge-idp-remote.php (to connect Samlbridge and DemoIDP). Builds one additional docker image:

 - cycloneproject/samlidp-demo

The demo SamlIDP comes preconfigured with these users:

| | | | | |
|----------|------|-------|-------|-------|
| Username | user | user2 | user3 | user4 |
| Password | user | user  | user  | user  |
| displayName | user | user2 | user3 | user4 |
| eduPersonAffiliation | member,student | member,student | member,student | member,student |
| mail | user1@samlidp.com | user2@samlidp.com | user3@samlidp.com | user4@samlidp.com |
| schacHomeOrganization | admin | demo | demo | demo |
| eduPersonTargetedID | ✔ | ✔ | ✔ | ✘ |


### HA-Demo Structure

The HA-Demo (in the ha-demo/ directory) is structured with docker swarm mode in mind. It differs in few places from the demo structure to accomodate for the deployment of replicas. Certificates and kcexport.json are distributed using docker secrets. Other configuration either uses environment variables or is directly build into the images. Traefik, in addition to reverse-proxying, now also provides (sticky) load-balancing. Communication between containers/services is facilitated by a docker swarm mode overlay network. Keycloak does not use multicast (as is the default setting) for cluster discovery and management because the overlay network does not support it (currently, see [issue](https://github.com/docker/libnetwork/issues/552)). It uses the postgres database (JDBC_PING) and unicast instead. The Samlbridge is mostly stateless and uses postgres as a shared session store. Additional docker images:

  - cycloneproject/keycloak-postgres-ha-demo
  - cycloneproject/samlbridge-postgres-ha-demo

## Configuration
Configuration files are only provided where configuration differs from the default. These can be found in the respective components (e.g. keycloak) directory in the _components/_ directory and the base directory of demo and ha-demo. Additionally, a lot of the configuration is handled using environment variables. See components/.env for a documented list of variables. For the ha-demo, either set the variables in your environment or hardcode them into the ha-demo/docker-compose.yml file.

To configure a client, create one in the Keycloak Admin Console and retrieve Keycloak openid-connect endpoint information from:
```shell
http(s)://(keycloakhost)/auth/realms/(keycloakrealm)/.well-known/openid-configuration
```

## Deployment
Deploy using docker:
```shell
# change into directory
cd demo

# OPTIONAL: build images
# When building your own images make sure the image name matches in
# docker-compose.yml. If you deploy the demo examples with your own images,
# you will have to additionally build the base images from the components folder.
docker-compose build

# FOR DEMO AND HA-DEMO ONLY: prepare keycloak configuration to import on startup
# by replacing the host for the samlbridge with the correct one in provided demo
# kcexport_template.json, e.g. run (replace localhost with your value)
sed "s/%SSP_URL%/http:\/\/localhost\/samlbridge/g; s/%SSP_ALIAS%/DemoIDP/g" kcexport_template.json > kcexport.json

# FOR HA-DEMO ONLY: init (or join a swarm) and set env variable FP_BASEURL
# docker swarm mode does not use the .env file, therefore either set it
# as an env variable or hardcore in ha-demo/docker-compose.yml
# (replace localhost with the same value as above)
export FP_BASEURL=http://localhost
docker swarm init

# deploy either with docker-compose on a single machine (components/demo)
docker-compose up

# or (for ha-demo) with docker stack on all machines in the swarm
docker stack deploy -c docker-compose.yml cyclonedemo
```

Replace localhost with an appropiate value and open in your browser of choice. Choose DemoIDP to go through authentication. By default, the components are reachable at the following endpoints:

| Component  | Endpoint    |
|:----------:|:-----------:|
| Keycloak   | /auth       |
| Samlbridge | /samlbridge |
| DemoIDP    | /samlidp    |

## Example Authn/Authz with keycloak

__NOTE:__ This is just a simple example and in no way meant to be complete. Please see official documentation of the standard for more information. The underlying standard is [OpenId-Connect](http://openid.net/connect/) and this is an example for the [Authorization Code Flow](http://openid.net/specs/openid-connect-core-1_0.html#CodeFlowAuth).

1. A User tries to access a protected resource unauthenticated and is redirected to Keycloak
```
http(s)://(keycloakhost)/auth/realms/(keycloakrealm)/protocol/openid-connect/auth?client_id=(client_id)&redirect_uri=(redirect_uri)&response_type=code
```
where the user logs in through any of the supported methods.

2. After successful login, the user is redirected to (redirect_uri) with a code:
```
(redirect_uri)?code=(code)
```
which is used to retrieve a set of JSON Web Tokens (JWT) from Keycloak.
```http
    POST /auth/realms/(keycloakrealm)/protocol/openid-connect/token
    Content-Type: application/x-www-form-urlencoded

    grant_type: authorization_code
    code: (code)
    redirect_uri: (redirect_uri)
    client_id: (client_id)


    Response:
    {
        "access_token": (base64 encoded JWT),
        "expires_in": (time),
        "refresh_token": (base64 encoded JWT),
        "refresh_expires_in": (time),
        "token_type": "bearer",
        "id_token": (base64 encoded JWT),
        "not-before-policy": (policy),
        "session-state": (session-state)
    }
```
The access token is used to access the protected resource.

3. The access token is short-lived by default, therefore refresh tokens using the refresh token, which has a larger ttl, as necessary:
```http
    POST /auth/realms/(keycloakrealm)/protocol/openid-connect/token
    Content-Type: application/x-www-form-urlencoded

    grant_type : refresh_token
    refresh_token : (refresh_token)
    redirect_uri : (redirect_uri)
    client_id : (client_id)


    Response:
    {
        "access_token": (base64 encoded JWT),
        "expires_in": (time),
        "refresh_token": (base64 encoded JWT),
        "refresh_expires_in": (time),
        "token_type": "bearer",
        "id_token": (base64 encoded JWT),
        "not-before-policy": (policy),
        "session-state": (session-state)
    }
```

6. Log out by redirecting the user to: `http(s)://(keycloakhost)/auth/realms/(keycloakrealm)/tokens/logout?redirect_uri=(redirect_uri)`

