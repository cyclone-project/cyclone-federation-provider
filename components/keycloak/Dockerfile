FROM java

ENV KEYCLOAK_VERSION=1.9.4.Final \
    JBOSS_HOME=/home/cyclone/keycloak

RUN useradd -ms /bin/bash cyclone
USER cyclone

WORKDIR /home/cyclone

RUN wget https://downloads.jboss.org/keycloak/$KEYCLOAK_VERSION/keycloak-$KEYCLOAK_VERSION.zip \
 && unzip keycloak-$KEYCLOAK_VERSION.zip \
 && rm keycloak-$KEYCLOAK_VERSION.zip \
 && mv keycloak-$KEYCLOAK_VERSION keycloak

COPY config/keycloak-server.json keycloak/standalone/configuration/keycloak-server.json
COPY config/standalone.xml       keycloak/standalone/configuration/standalone.xml
COPY theme/cyclone               keycloak/themes/cyclone

ENTRYPOINT ["keycloak/bin/standalone.sh"]

EXPOSE 8080
