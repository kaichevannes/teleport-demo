FROM alpine:3.23.3

RUN echo "@testing https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add --no-cache \
        ca-certificates=20251003-r0 \
        kubectl=1.34.2-r4 \
        kubectl-oidc_login@testing=1.35.2-r1 \
        tini=0.19.0-r3 \
        zlib=1.3.2-r0

COPY ./idp/certs/public-certificate.pem /usr/local/share/ca-certificates/idp.crt
RUN update-ca-certificates

COPY ./user/open-host-browser.sh /usr/local/bin/xdg-open
RUN chmod +x /usr/local/bin/xdg-open

ENTRYPOINT ["tini", "--"]
CMD ["sleep", "infinity"]
