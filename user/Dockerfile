FROM golang:1.26-alpine AS builder

RUN apk add --no-cache git=2.52.0-r0 && \
    go install github.com/jentz/oidc-cli@v0.1.21

FROM alpine:3.23.3

RUN apk add --no-cache \
        ca-certificates=20251003-r0 \
        coreutils=9.8-r1 \
        curl=8.17.0-r1 \
        jq=1.8.1-r0 \
        kubectl=1.34.2-r4 \
        tini=0.19.0-r3 \
        zlib=1.3.2-r0

COPY ./idp/certs/public-certificate.pem /usr/local/share/ca-certificates/idp.crt
RUN update-ca-certificates

COPY --from=builder /go/bin/oidc-cli /usr/local/bin/oidc-cli
COPY --chmod=755 ./user/decode-jwt.sh /decode-jwt.sh
COPY --chmod=755 ./user/open-host-browser.sh /usr/local/bin/xdg-open

ENTRYPOINT ["tini", "--"]
CMD ["sleep", "infinity"]
