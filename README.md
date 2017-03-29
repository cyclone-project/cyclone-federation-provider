# Cyclone Federation Provider
Base configuration and demo for the cyclone-federation-provider. It uses [Traefik](https://traefik.io/) to proxy to backend containers and is deployed with [Docker and Docker-Compose](https://www.docker.com/). [Keycloak](http://keycloak.org) with [PostgreSQL](https://www.postgresql.org) serves as the identity provider and [SimpleSamlPHP](https://simplesamlphp.org) as a samlbridge. The cron container prompts the samlbridge to refresh its metadata every hour and keycloak to delete users with no sessions (with some exceptions like the admin) for data-privacy reasons.


## Provider connection architecture
![architecture](https://raw.githubusercontent.com/cyclone-project/cyclone-federation-provider/master/docs/cyclone-diagram.png)


## Configuration
Most configuration is handled by environment variables (see .env file), some can be edited in each component's respective folder or overwritten by mounting as a docker volume.

The database is persisted (by default) in `data/keycloak/db`. The keycloak container can import pre-exported configuration. Its entrypoint is set to import from `/data/keycloak/exports/kcexport.json` if `KC_IMPORT` is set to `true` (and the container is run for the first time).


## Deploy the Demo
Replace the host for the samlbridge with the correct one in the provided demo kcexport_template.json, e.g. run
```
sed "s/%SSP_URL%/http:\/\/localhost\/samlbridge/g; s/%SSP_ALIAS%/DemoIDP/g" demo/kcexport_template.json > demo/kcexport.json
```
Configure keycloak to import, i.e. set KC_IMPORT=true, then deploy with docker-compose
```
docker-compose -f docker-compose.yml -f docker-compose.demo.yml up
```

The demo wires keycloak to the samlbridge and provides a demo saml idp.

The __admin username and password__ for keycloak is both `admin`. To connect with a client, create one inside the admin panel of keycloak using the `Cyclone Template` as client template.

__Demo users__ for the demo saml idp are `user`, `user1`, `user2`, `user3`, `user4` with the password `user`. Each user returns a slightly different set of information.

By default, the components are at the following endpoints:

| Component  | Endpoint    |
|:----------:|:-----------:|
| Keycloak   | /auth       |
| Samlbridge | /samlbridge |
| DemoIDP    | /samlidp    |


## Authn/Authz with keycloak

__NOTE:__ Underlying standard is [OpenId-Connect](http://openid.net/connect/), specifically the [Authorization Code Flow](http://openid.net/specs/openid-connect-core-1_0.html#CodeFlowAuth).

1. User tries to access a protected resource.

2. User is redirected to:
`http(s)://(keycloak)/auth/realms/(realm)/protocol/openid-connect/auth?client_id=(client_id)&redirect_uri=(redirect_uri)&response_type=code`

3. User login happens with any of the methods supported by keycloak.

4. After successful login, user is redirected to (redirect_uri) with a code:
`(redirect_uri)/?code=(code)`

5. Use this code to retrieve a set of JSON Web Tokens (JWT):
```http
    POST /auth/realms/(realm)/protocol/openid-connect/token
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

6. Refresh set of tokens, as necessary:
```http
    POST /auth/realms/(realm)/protocol/openid-connect/token
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

7. Log out by redirecting the user to: `http(s)://(keycloak)/auth/realms/(realm)/tokens/logout?redirect_uri=(redirect_uri)`
