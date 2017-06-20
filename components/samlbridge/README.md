cycloneproject/samlbridge-base
==============================

Base Repository: [github.com/cyclone-project/cyclone-federation-provider](https://github.com/cyclone-project/cyclone-federation-provider)

This repository provides a docker image for SimplesamlPHP, backed by apache httpd, with added configurability through env variables, defaults and a theme for the cyclone project. It acts as a Samlbridge, serving as an Identity Provider (IDP) to one side, in our case Keycloak, and a Service Provider (SP) to a SAML Federation. It is configured to periodically (prompted by a separate cron container) refresh metadata from the SAML Federation and import IDP Metadata ONLY (through symlinking).

Furthermore, it filters received attributes and requires (using the SmartID module) at least one of the following from which the SmartID module chooses one as the identifying attribute (in the given order):

  - eduPersonUniqueID
  - eduPersonTargetedID
  - eduPersonPrincipalName
  - mail

The eduPersonTargetedID is further converted into a string for consumption by Keycloak.

## How to use

### Use image directly
You can use this image directly. There is a number of configuration options through env variables.

```shell
# Base entrypoint for calls to the individual components
# i.e. this is where the reverse proxy listens and which we expect
# the baseurl of the components to be, e.g.
# $FP_BASEURL/auth = Keycloak
# $FP_BASEURL/samlbridge = SimpleSamlPHP
FP_BASEURL

# Shared Secret between the samlbridge and cron container
# Used by cron to prompt samlbridge to update idp metadata
SAMLBRIDGE_CRON

# Samlbridge admin user password
SAMLBRIDGE_PASSWORD

# Samlbridge secret salt used to generate secure hashes
SAMLBRIDGE_SALT

# Samlbridge technical contact information
SAMLBRIDGE_CONTACTGIVENNAME
SAMLBRIDGE_CONTACTSURNAME
SAMLBRIDGE_CONTACTEMAIL

# URL of the organization responsible for the samlbridge
SAMLBRIDGE_ORGURL

# Displayed name of the organization responsible for the samlbridge
SAMLBRIDGE_ORGDISPLAYNAME

# Name of the organization responsible for the samlbridge
# Does not need to be suitable to display to end users
SAMLBRIDGE_ORGNAME

# Identifier of the authority that has registered this samlbridge
SAMLBRIDGE_REG_AUTHORITY

# Instant when this samlbridge was registered (e.g. 2015-01-01T08:00:00Z)
SAMLBRIDGE_REG_INSTANT
```
For more flexibility either overwrite configuration by providing your own files and mounting them into the container or extending the image.

Run example:
```shell
docker run -e SAMLBRIDGE_PASSWORD=admin -p 80:80 cycloneproject/samlbridge-base
```

For most deployments it is easier to use docker-compose with an accompanying .env file for configuration. See the base repository for examples.

### Extend it
Extend from this image by using in your Dockerfile:
```shell
FROM cycloneproject/keycloak-postgres-base
```

