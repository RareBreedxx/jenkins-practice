FROM alpine:latest

WORKDIR /app

COPY system_check.sh /app/system_check.sh

RUN chmod +x /app/system_check.sh

CMD ["/app/system_check.sh"]

