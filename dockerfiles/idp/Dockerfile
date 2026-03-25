FROM ghcr.io/soluto/oidc-server-mock:0.12.1

RUN apk add --no-cache openssl

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

HEALTHCHECK --interval=1s --timeout=1s --retries=20 \
  CMD test -f /idp-https-cert/public-certificate.pem

ENTRYPOINT ["/entrypoint.sh"]

CMD ["dotnet", "OpenIdConnectServerMock.dll"]
