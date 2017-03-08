#!/bin/sh

addargs=""

if [ ! -f /opt/jboss/firstrun ]; then
	if [ "$KC_IMPORT" = true ]; then
		echo "First run + Import adding import args\n"
		addargs="-Dkeycloak.migration.action=import -Dkeycloak.migration.provider=singleFile -Dkeycloak.migration.strategy=OVERWRITE_EXISTING -Dkeycloak.migration.file=/opt/jboss/exports/kcexport.json"
	fi
	date > /opt/jboss/firstrun
fi

echo "Running Keycloak with $@ $addargs"
exec /opt/jboss/docker-entrypoint.sh "$@ $addargs"
exit $?

