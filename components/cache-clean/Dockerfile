FROM maven:3.3.3-jdk-7
COPY  . /usr/src/cache-clean
WORKDIR  /usr/src/cache-clean
CMD ["mvn", "clean", "install"]
CMD ["mvn", "exec:java", "-e"]
