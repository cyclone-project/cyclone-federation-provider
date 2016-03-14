# Cyclone User Cache Clean

This container includes a java service which tracks which users in Keycloak don't have session and deletes them from the database.
It runs with a Task service with an interval defined by the PERIOD env variable.
This is supposed to be a temporal replacement as according to Keycloak mailing list there is a plan to officially implement
this option.

## Cache Clear Process

1. It fetches all the users from the mongoDB database.
2. Through Keycloak API it connects using the Admin Client and fetches which sessions are enabled for each of the users
3. Deletes from the database any user with 0 sessions and that is not excluded.
4. Waits PERIOD milliseconds until next run

## Configuration
### Docker container configuration
The configuration of the container is done through ENV variables:

* __KEYCLOAK_ADMIN_USER__: keycloak user with admin rights
* __KEYCLOAK_ADMIN_PASS__: keycloak password for the user
* __KEYCLOAK_ADMIN_CLIENT__: client to which connect to get API access. Default and preconfigured one in Keycloak is `admin-cli`
* __KEYCLOAK_REALM__: which realm to administrate
* __PERIOD__: how often (in milliseconds) the task should run.
* __EXCLUDED_USERS__: semicolon separated names of the user accounts that should not be deleted (admin accounts for example)

All the the ENV variables but PERIOD are required. The default value for PERIOD is 60 seconds.
At least an excluded user should be provided.
See a configuration example in `docker-compose.yml`

### Keycloak configuration
In Keycloak, **you should disable the user cache**, so Keycloak doesn't cache the already deleted users in its cache.
You can find the setting in `Realm Settings -> Cache -> UserCache`. Also, having a user cache is useless as we are clearing the data
of the user automatically from the database after its use.

## Run Maven project
Install and compile project `mvn clean install`
Execute project `mvn exec:java`

## References

* How to use Keycloak API CLI: http://www.first8.nl/blog/programmatically-adding-users-in-keycloak/
* MongoDB Java Driver: http://mongodb.github.io/mongo-java-driver/3.0/driver/




