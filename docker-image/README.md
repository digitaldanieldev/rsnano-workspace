
# Rsnano dockerized workspace and IDE

## before docker-compose up
### set the location for the container data
In docker-compose.yml set the 'device' parameters under 'volumes':
for example, device: "/sda1/dockerdata/rust-nano/data" and "/sda1/dockerdata/rust-nano/home"

### set the correct timezone 
In Dockerfile set the TZ variable to match your own timezone

## login to container
### interactive session in container
docker exec -ti rust-nano-ide-rustnanocoder-1 bash

### access vscode
http://localhost:8041/?folder=/home/rustnanodev/rsnano-node

## deployment
### run at first install
docker exec rust-nano-ide-rustnanocoder-1 /home/rustnanodev/git-clone.sh bash
### check for changes in the repository and download only those
docker exec rust-nano-ide-rustnanocoder-1 /home/rustnanodev/git-fetch.sh bash

### build rsnano-node
docker exec rust-nano-ide-rustnanocoder-1 /home/rustnanodev/rsnano-build.sh bash

### nano-node diagnostics
docker exec rust-nano-ide-rustnanocoder-1 /home/rustnanodev/nano-node-diagnostics.sh bash

### nano-node tests
docker exec rust-nano-ide-rustnanocoder-1 /home/rustnanodev/nano-node-cpp-tests.sh bash
docker exec rust-nano-ide-rustnanocoder-1 /home/rustnanodev/nano-node-rust-tests.sh bash

