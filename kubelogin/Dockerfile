FROM alpine:3.23.3

RUN echo "@testing https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add --no-cache tini kubectl kubectl-oidc_login@testing ca-certificates

COPY ./idp/certs/public-certificate.pem /usr/local/share/ca-certificates/idp.crt
RUN update-ca-certificates

ENTRYPOINT ["tini", "--"]
CMD ["sleep", "infinity"]
