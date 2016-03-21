FROM maven:3.3.3-jdk-7
COPY  . /usr/src/cache-clean
WORKDIR  /usr/src/cache-clean
RUN ["mvn", "package", "dependency:copy-dependencies"]
CMD ["mvn", "exec:exec"]
