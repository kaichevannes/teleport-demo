# Generate key and certificate
openssl req -x509 -newkey rsa:2048 \
  -keyout private-key.pem -out public-certificate.pem \
  -days 10000 -nodes -subj "/CN=idp" \
  -addext "subjectAltName=DNS:idp,DNS:localhost"

# Convert to .pfx
openssl pkcs12 -export \
  -out private-certificate.pfx \
  -inkey private-key.pem \
  -in public-certificate.pem \
  -password "pass:pfx-password"
