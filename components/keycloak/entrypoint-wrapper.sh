#!/bin/bash

addargs=""

# check if firstrun file exists (if KC_IMPORT is set)
# this way we can import on startup (if needed) to bootstrap a fresh container
# with full configuration and prevent repeated imports which would overwrite
# current state on restarts, etc.
if [ ! -f /opt/jboss/firstrun ]; then
	if [ "$KC_IMPORT" = true ]; then
		addargs="$addargs -Dkeycloak.migration.action=import -Dkeycloak.migration.provider=singleFile -Dkeycloak.migration.strategy=OVERWRITE_EXISTING -Dkeycloak.migration.file=/opt/jboss/exports/kcexport.json"
	fi
	date > /opt/jboss/firstrun
fi

until curl "$POSTGRES_PORT_5432_TCP_ADDR:$POSTGRES_PORT_5432_TCP_PORT" 2>&1 | grep 52
do
	echo "waiting for db..."
	sleep 5
done

echo "Running Keycloak with $@ $addargs"
exec /opt/jboss/docker-entrypoint.sh $@ $addargs
exit $?

