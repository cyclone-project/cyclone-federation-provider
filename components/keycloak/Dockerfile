FROM jboss/keycloak-postgres:2.4.0.Final

COPY cy-* /opt/jboss/keycloak/

RUN /opt/jboss/keycloak/bin/jboss-cli.sh --file=/opt/jboss/keycloak/cy-conf.cli
