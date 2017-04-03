FROM jboss/keycloak-postgres:3.0.0.Final

USER root
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

USER jboss
COPY cy-conf.cli /opt/jboss/keycloak/cy-conf.cli
RUN /opt/jboss/keycloak/bin/jboss-cli.sh --file=/opt/jboss/keycloak/cy-conf.cli &&\
    rm -rf /opt/jboss/keycloak/standalone/configuration/standalone_xml_history/current

ENTRYPOINT ["/docker-entrypoint.sh"]

