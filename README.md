# wasmcloud

just messing around with wasmcloud in codespaces.

## install

### wash

```bash
curl -s https://packagecloud.io/install/repositories/wasmcloud/core/script.deb.sh | sudo bash
sudo apt install wash openssl -y
```

### optional rust

```bash
. .devcontainer/scripts/rust.sh
```

### with docker compose

all services

volume mounts acting up needed the files, and tempo wasn't mounting directly so gave it a folder.

```bash
mkdir -p ./config/grafana ./config/tempo
curl -s https://raw.githubusercontent.com/wasmCloud/examples/main/docker/grafana-datasources.yaml -o ./config/grafana/grafana-datasources.yaml
curl -s https://raw.githubusercontent.com/wasmCloud/examples/main/docker/tempo.yaml -o ./config/tempo/tempo.yaml
#curl -s  https://raw.githubusercontent.com/wasmCloud/examples/main/docker/docker-compose.yml -O docker-compose.yml

docker compose up
```

## with wash

run with wash limited services

```bash
wash up

```

### check it out

https://wasmcloud.com/docs/tour/hello_world

```bash
wash ctl get hosts
myhost=$(wash ctl get hosts -o json | jq -r .hosts[0].id)

wash ctl get inventory $myhost

#wash ctl start actor [OPTIONS] <actor-ref>
wash ctl start actor wasmcloud.azurecr.io/echo:0.3.8

#wash ctl start provider [OPTIONS] <provider-ref>
wash ctl start provider --link-name echo wasmcloud.azurecr.io/httpserver:0.17.0

#wash ctl link put --link-name <LINK_NAME> [OPTIONS] <actor-id> <provider-id> <contract-id> [values].
myactor=$(wash ctl get inventory $myhost -o json | jq -r .inventory.actors[].id)
myprovider=$(wash ctl get inventory $myhost -o json | jq -r .inventory.providers[].id)

wash ctl link put --link-name echo $myactor $myprovider wasmcloud:httpserver address=0.0.0.0:8087
```

### try it echo

```bash
# echo
curl -v localhost:8087/
```

### try it hello

https://wasmcloud.com/docs/fundamentals/actors/create-actor/run

Requires rust installed.

```bash
. .devcontainer/scripts/rush.sh
```

```bash
wash new actor hello --template-name hello

cd hello
wash build
```

build fails from the example going to look at it.
