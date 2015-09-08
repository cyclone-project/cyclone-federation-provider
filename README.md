# Cyclone Federation Provider
Basically, [Keycloak](http://keycloak.org) preconfigured in a docker container.  Build and run with [Docker](https://www.docker.com/). 

Please see [Keycloak docs](http://keycloak.org/docs) and [Docker docs](http://docs.docker.com/) for more in-depth documentation on Keycloak or Docker respectively.

Listens at `http://localhost:8080` by default.

Preconfigured Users:

| Username | Password |
|:--------:|:--------:|
|admin     | admin    |
|owner     | owner    |
|user      | user     |
|guest     | guest    |

Preconfigured clients:

| Client Id  | Redirect Uri |
|:----------:|:------------:|
| slipstream | *            |
| portal     | *            |
| test       | *            |


## Authentication with keycloak

__NOTE:__ This authentication flow uses [OpenId-Connect](http://openid.net/connect/) as provided by Keycloak, specifically [authentication using the authorization code flow](http://openid.net/specs/openid-connect-core-1_0.html#CodeFlowAuth). Keycloak also supports authentication with SAML, if configured.

1. Go or redirect user to: (optionally set `kc_idp_hint` to choose Idp for user, if brokered)
    ```http
    /auth/realms/master/protocol/openid-connect/auth?client_id=(client_id)&redirect_uri=(redirect_uri)&response_type=code
    ```
2. User logs into keycloak or a brokered idp and is sent to the redirect_uri with a code: `(redirect_uri)/?code=(code)`
3. Use this code to retrieve the actual json web tokens (jwts) by requesting: 
    ```http
    POST /auth/realms/master/protocol/openid-connect/token
    Content-Type: application/x-www-form-urlencoded

    grant_type : authorization_code
    code : (code)
    redirect_uri : (redirect_uri)
    client_id : (client_id)

    Response:
    {
        "access_token": "(base64-encoded jwt)",
        "expires_in": "(access_token expiration time)",
        "refresh_expires_in": "(refresh token expiration time)",
        "refresh_token": "(base64-encoded jwt)",
        "token_type": "bearer",
        "id_token": "(base64-encoded jwt)",
        "not-before-policy": "(not-before-policy)",
        "session-state": "(session-state)"
    }
    ```
4. Some user information is included in the access_token and id_token already (if configured), some can be retrieved by requesting:
    ```http
    GET /auth/realms/master/protocol/openid-connect/userinfo
    Authorization: Bearer (access_token)

    Response:
    {
        "email": "(email)",
        "name": "(name)",
        "preferred_username": "(preferred_username)",
        ...
    }
    ```

5. Use refresh_token to retrieve new tokens before expiration:
    ```http
    POST /auth/realms/master/protocol/openid-connect/token
    Content-Type: application/x-www-form-urlencoded

    grant_type : refresh_token
    refresh_token : (refresh_token)
    redirect_uri : (redirect_uri)
    client_id : (client_id)

    Response:
    {
        "access_token": "(base64-encoded jwt)",
        "expires_in": "(access_token expiration time)",
        "refresh_expires_in": "(refresh token expiration time)",
        "refresh_token": "(base64-encoded jwt)",
        "token_type": "bearer",
        "id_token": "(base64-encoded jwt)",
        "not-before-policy": "(not-before-policy)",
        "session-state": "(session-state)"
    }
    ```
6. To log out of the SSO session, point user's browser to
    ```http
    /auth/realms/master/tokens/logout?redirect_uri=(redirect_uri)
    ```

## JSON Web Token (JWT)

More in-depth documentation here: [IETF RFC 7519](https://tools.ietf.org/html/rfc7519).

The JWT returned from Keycloak generally follow this scheme: `(base64 header).(base64 data).(signature)`.

The header returned from Keycloak generally looks like this:
```json
{
    "alg":"RS256"
}
```

The payload or data contains this (among others):
```json
{
    "jti":"(a uuid)",
    "exp":"(expiration time)",
    "iat":"(issue time)",
    "iss":"(issuer)",
    ...

}
```
Additional information depends on the type of token:  

* the access_token contains scopes and permissions for the user and, if configured, user-related information
* the id_token contains user-related information
