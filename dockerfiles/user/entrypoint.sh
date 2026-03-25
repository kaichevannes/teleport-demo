#!/bin/sh
-set e

cp /idp-https-cert/public-certificate.pem /usr/local/share/ca-certificates/idp.crt
update-ca-certificates

exec "$@"
