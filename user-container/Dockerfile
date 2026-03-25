FROM golang:1.24-alpine AS builder

RUN apk add --no-cache git
RUN go install github.com/jentz/oidc-cli@latest

FROM alpine:3.23.3

RUN apk add --no-cache kubectl

COPY --from=builder /go/bin/oidc-cli /usr/local/bin/oidc-cli
