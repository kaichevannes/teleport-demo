# Generate key and certificate
openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:P-256 \
  -keyout server-ca.key -out server-ca.crt \
  -days 10000 -nodes -subj "/CN=cluster" \
  -addext "subjectAltName=DNS:cluster,DNS:localhost"
