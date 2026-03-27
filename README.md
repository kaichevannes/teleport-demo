# Demo

## Prerequisites
Docker (`curl -fsSL https://get.docker.com | sh`)

## Run
```
./link-host-browser.sh &
docker compose up -d
```

## Demo

### User container
1. Exec into the user container
```
docker exec -it demo-user sh
```
2. Get an OIDC token response from the mock Identity Provider
```
oidc-cli authorization_code -issuer https://localhost:8443 -client-id mock-client -scopes "openid profile email groups offline_access" -prompt login -pkce > response
```
3. Show the encoded token response
```
cat response
```
4. Decode the access_token and id_token JWTs
```
cat response | jq -r '.access_token' | /decode-jwt.sh
cat response | jq -r '.id_token' | /decode-jwt.sh
```
5. Get a new token using the refresh_token
```
curl -X POST https://localhost:8443/connect/token -d "grant_type"="refresh_token" -d "refresh_token"="$(cat response | jq -r '.refresh_token')" -d "client_id"="mock-client" > alice-response
```
6. Run the command again to show one time use
```
curl -X POST https://localhost:8443/connect/token -d "grant_type"="refresh_token" -d "refresh_token"="$(cat response | jq -r '.refresh_token')" -d "client_id"="mock-client"
```
7. Get tokens for bob and charlie
```
oidc-cli authorization_code -issuer https://localhost:8443 -client-id mock-client -scopes "openid profile email groups offline_access" -prompt login -pkce > bob-response
oidc-cli authorization_code -issuer https://localhost:8443 -client-id mock-client -scopes "openid profile email groups offline_access" -prompt login -pkce > charlie-response
```
8. Get pods using alices token
```
kubectl get pods --token "$(cat alice-response | jq -r '.id_token')"
```
9. Show the same command works for bob but not for charlie
```
kubectl get pods --token "$(cat bob-response | jq -r '.id_token')"
kubectl get pods --token "$(cat charlie-response | jq -r '.id_token')"
```
10. Deploy the nginx application with alice
```
kubectl create deployment nginx --image=nginx:latest --token "$(cat alice-response | jq -r '.id_token')"
```
11. Exit user container
```
exit
```

### Kubelogin container
1. Exec into the Kubelogin container
```
docker exec -it demo-kubelogin sh
```
2. Get pods as bob
```
kubectl get pods
```
3. Expose the deployment
```
kubectl expose deployment nginx --port=80 --token "$(cat response | jq -r '.id_token')"
```
4. Portforward the deployment
```
kubectl port-forward svc/nginx 8081:80 --token "$(cat response | jq -r '.id_token')"
```
5. Navigate to http://localhost:8081
6. Try to delete the deployment as bob (insufficient permissions)
```
kubectl delete deployment nginx
```
7. Delete bob's id_token from Kubelogin
```
kubectl oidc-login clean
```
8. Delete the deployment as alice
```
kubectl delete deployment nginx
```
9. Confirm there are no pods
```
kubectl get pods
```

## Cleanup
```
fg <C-c>
docker compose down
```
