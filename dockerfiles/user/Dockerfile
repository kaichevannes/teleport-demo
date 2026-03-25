FROM golang:1.24-alpine AS builder

RUN apk add --no-cache git
RUN go install github.com/jentz/oidc-cli@latest

FROM alpine:3.23.3

RUN apk add --no-cache tini kubectl ca-certificates

COPY --from=builder /go/bin/oidc-cli /usr/local/bin/oidc-cli

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["tini", "--", "/entrypoint.sh"]

CMD ["sleep", "infinity"]
