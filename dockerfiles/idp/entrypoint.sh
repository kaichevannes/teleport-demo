#!/bin/sh
set -e
PASSWORD=$(openssl rand -hex 16)

# Generate key and certificate
openssl req -x509 -newkey rsa:2048 \
  -keyout /tmp/private-key.pem -out /idp-https-cert/public-certificate.pem \
  -days 10000 -nodes -subj "/CN=idp" \
  -addext "subjectAltName=DNS:idp,DNS:localhost"

# Convert to .pfx
openssl pkcs12 -export \
  -out /tmp/private-certificate.pfx \
  -inkey /tmp/private-key.pem \
  -in /idp-https-cert/public-certificate.pem \
  -password "pass:$PASSWORD"

export ASPNETCORE_URLS="https://+:443;http://+:80"
export ASPNETCORE_Kestrel__Certificates__Default__Password="$PASSWORD"
export ASPNETCORE_Kestrel__Certificates__Default__Path="/tmp/private-certificate.pfx"

exec "$@"
