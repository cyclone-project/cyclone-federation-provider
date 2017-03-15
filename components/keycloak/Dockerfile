FROM jboss/keycloak-postgres:2.5.5.Final

USER root
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

USER jboss
COPY cy-conf.cli /opt/jboss/keycloak/cy-conf.cli
RUN /opt/jboss/keycloak/bin/jboss-cli.sh --file=/opt/jboss/keycloak/cy-conf.cli

ENTRYPOINT ["/docker-entrypoint.sh"]

