FROM golang:1.24-alpine AS builder

RUN apk add --no-cache git
RUN go install github.com/jentz/oidc-cli@latest

FROM alpine:3.23.3

RUN apk add --no-cache tini coreutils curl jq kubectl ca-certificates 

COPY --from=builder /go/bin/oidc-cli /usr/local/bin/oidc-cli

COPY ./idp/certs/public-certificate.pem /usr/local/share/ca-certificates/idp.crt
RUN update-ca-certificates

COPY ./user/decode-jwt.sh /decode-jwt.sh
RUN chmod +x /decode-jwt.sh

ENTRYPOINT ["tini", "--"]
CMD ["sleep", "infinity"]
