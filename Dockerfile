FROM java

ENV KEYCLOAK_VERSION 1.7.0.Final

WORKDIR /opt/

RUN wget http://search.maven.org/remotecontent?filepath=org/keycloak/keycloak-server-dist/$KEYCLOAK_VERSION/keycloak-server-dist-$KEYCLOAK_VERSION.zip -O keycloak.zip

RUN unzip keycloak.zip

RUN mv keycloak-$KEYCLOAK_VERSION keycloak

ENV JBOSS_HOME /opt/keycloak

ADD ./keycloak-export.json /opt/keycloak-export.json

ENTRYPOINT ["/opt/keycloak/bin/standalone.sh", "-Dkeycloak.migration.action=import", "-Dkeycloak.migration.provider=singleFile", "-Dkeycloak.migration.file=/opt/keycloak-export.json", "-Dkeycloak.migration.strategy=OVERWRITE_EXISTING", "-b", "0.0.0.0"]

EXPOSE 8080
