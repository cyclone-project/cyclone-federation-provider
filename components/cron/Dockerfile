FROM alpine

RUN apk add --no-cache curl

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["crond", "-f", "-d", "4"]

# mount your scripts here
VOLUME /etc/periodic
