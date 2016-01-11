# Cyclone Federation Provider

## Components:
[Keycloak](http://keycloak.org) in combination with [MongoDB](https://www.mongodb.org/) and [SimpleSamlPHP](https://simplesamlphp.org) as a samlbridge.

Please see the documentation for [Keycloak](http://keycloak.org/docs), [MongoDB](https://docs.mongodb.org/manual/), [SimpleSamlPHP](https://simplesamlphp.org/docs/stable/) and [Docker](http://docs.docker.com/) for more information.

## Configuration
Configure Keycloak and SimpleSamlPHP by editing the files in `components/keycloak/config` or `components/samlbridge/config` respectively. 

The Keycloak database is persisted (by default) in `data/keycloak/db`. Import configuration for keycloak by adding the `keycloak-export.json` to data/keycloak/exports and editing docker-compose.yml.

__The provided keycloak-export.json includes:__

Default Users for Keycloak:

| Username | Password |
|:--------:|:--------:|
|admin     | admin    |
|owner     | owner    |
|user      | user     |
|guest     | guest    |

Default Clients for Keycloak:

| Client Id  | Redirect Uri |
|:----------:|:------------:|
| slipstream | *            |
| portal     | *            |
| test       | *            |

## Deployment
Build and run with [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/) by executing `docker-compose up`.

By default, Keycloak listens at `http://localhost:9080` and SimpleSamlPHP at `http://localhost:8080/samlbridge`

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
