FROM cycloneproject/keycloak-postgres

USER root
COPY entrypoint-wrapper.sh /opt/jboss/entrypoint-wrapper.sh
RUN chmod +x /opt/jboss/entrypoint-wrapper.sh

USER jboss
COPY cy-conf.cli /opt/jboss/keycloak/cy-conf.cli
RUN /opt/jboss/keycloak/bin/jboss-cli.sh --file=/opt/jboss/keycloak/cy-conf.cli &&\
    rm -rf /opt/jboss/keycloak/standalone/configuration/standalone_xml_history/current

ENTRYPOINT ["/opt/jboss/entrypoint-wrapper.sh"]

