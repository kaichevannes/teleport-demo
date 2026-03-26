# Demo

## Prerequisites
Docker (`curl -fsSL https://get.docker.com | sh`)

## Run
```
./link-host-browser.sh &
docker compose up -d
```

## Demo
```
docker exec -it demo-user
```

## Cleanup
`fg <C-c>`
`docker compose down`
