FROM alpine:3.23.3

RUN echo "@testing https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add --no-cache tini kubectl kubectl-oidc_login@testing ca-certificates

COPY ./idp/certs/public-certificate.pem /usr/local/share/ca-certificates/idp.crt
RUN update-ca-certificates

COPY ./user/open-host-browser.sh /usr/local/bin/xdg-open
RUN chmod +x /usr/local/bin/xdg-open

ENTRYPOINT ["tini", "--"]
CMD ["sleep", "infinity"]
