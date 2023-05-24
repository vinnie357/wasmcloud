#!/bin/bash
echo "---installing wash-cli---"
if command -v wash >/dev/null 2>&1; then
  # program_name exists, so run it
  wash --version
else
  # program_name does not exist
  echo "Error: trying to install wash"
  curl -s https://packagecloud.io/install/repositories/wasmcloud/core/script.deb.sh | sudo bash
  sudo apt install wash openssl -y
  wash --version
fi
echo "---wash-cli done---"
