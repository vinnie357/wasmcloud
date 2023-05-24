function demo_echo() {
if wash ctl get hosts  >/dev/null 2>&1; then
  # program_name exists, so run it
  myhost=$(wash ctl get hosts -o json | jq -r .hosts[0].id)
  wash ctl start actor wasmcloud.azurecr.io/echo:0.3.8
  wash ctl start provider --link-name echo wasmcloud.azurecr.io/httpserver:0.17.0
  myactor=$(wash ctl get inventory $myhost -o json | jq -r .inventory.actors[].id)
  myprovider=$(wash ctl get inventory $myhost -o json | jq -r .inventory.providers[].id)
  wash ctl link put --link-name echo $myactor $myprovider wasmcloud:httpserver address=0.0.0.0:8087
  curl -v localhost:8087/
else
  # program_name does not exist
  echo "Error: make sure nats is running"
  echo "try: docker compose up "
fi
}
