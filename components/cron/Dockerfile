FROM alpine

RUN apk add --no-cache curl jq
CMD ["crond", "-f", "-d", "4"]
VOLUME /etc/periodic
