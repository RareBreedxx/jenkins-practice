FROM alpine:latest

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

COPY system_check.sh /app/system_check.sh
RUN chmod +x /app/system_check.sh

USER appuser

CMD ["/app/system_check.sh"]

