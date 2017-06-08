FROM alpine

RUN apk add --no-cache curl jq

COPY periodic /etc/periodic

CMD ["crond", "-f", "-d", "4"]

