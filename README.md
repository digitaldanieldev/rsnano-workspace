# RSNANO-WORKSPACE DOCKERIZED
This container can be used for development of rsnano-node: https://github.com/simpago/rsnano-node
Because development requires the use of the 'nightly' toolchain instead of the 'stable' version I decided to separate this whole environment from my system. 

It contains Rust, rust code-server, the rust nightly toolchain, rust-analyzer, vscode, vim, and some rust-related vscode extensions.

The container uses system storage that can be accessed using any other IDE that you happen to use. 

## Before running docker-compose up
### set container volume location
In docker-compose.yml set the 'device' parameters under 'volumes':
for example, device: "/sda1/dockerdata/rsnano-workspace/data" and "/sda1/dockerdata/rsnano-workspace/home"

### set timezone 
In Dockerfile set the TZ variable to match your own timezone

## Container access
### interactive session in container
```sh
docker exec -ti rsnano-workspace-ide-1 bash
```

### access vscode
```sh
http://localhost:8041/?folder=/home/rustnanodev/rsnano-node
```
## Deployment
The scripts that are accessible as described below can also be run from inside the container. Start an interactive session and then run ./[insert script name here].sh: ./git-fetch.sh for example.
### run at first install
```sh
docker exec rsnano-workspace-ide-1 /home/rustnanodev/git-clone.sh bash
```
### check for changes in the repository and download only those
```sh
docker exec rsnano-workspace-ide-1 /home/rustnanodev/git-fetch.sh bash
```
### build rsnano-node
```sh
docker exec rsnano-workspace-ide-1 /home/rustnanodev/rsnano-build.sh bash
```
### nano-node diagnostics
```sh
docker exec rsnano-workspace-ide-1 /home/rustnanodev/nano-node-diagnostics.sh bash
```
### nano-node tests
```sh
docker exec rsnano-workspace-ide-1 /home/rustnanodev/nano-node-cpp-tests.sh bash
docker exec rsnano-workspace-ide-1 /home/rustnanodev/nano-node-rust-tests.sh bash
```
