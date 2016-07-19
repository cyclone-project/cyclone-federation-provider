FROM java

ENV KEYCLOAK_VERSION=2.0.0.Final \
    JBOSS_HOME=/home/cyclone/keycloak

RUN useradd -ms /bin/bash cyclone
USER cyclone

WORKDIR /home/cyclone

RUN wget https://downloads.jboss.org/keycloak/$KEYCLOAK_VERSION/keycloak-$KEYCLOAK_VERSION.tar.gz \
 && tar -xvf keycloak-$KEYCLOAK_VERSION.tar.gz \
 && rm keycloak-$KEYCLOAK_VERSION.tar.gz \
 && mv keycloak-$KEYCLOAK_VERSION keycloak

ENTRYPOINT ["keycloak/bin/standalone.sh"]
CMD ["-b", "0.0.0.0"]

EXPOSE 8080

COPY config/        /home/cyclone/keycloak/standalone/configuration/
COPY theme/cyclone  /home/cyclone/keycloak/themes/cyclone
