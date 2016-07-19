FROM alpine

RUN apk add --no-cache curl

COPY periodic /etc/periodic
RUN chmod -R +x /etc/periodic

CMD ["crond", "-f", "-d", "4"]
