#!/bin/bash
# install tools for container standup
echo "cwd: $(pwd)"
echo "---getting tools---"
. .devcontainer/scripts/rust.sh
. .devcontainer/scripts/wash.sh
. .devcontainer/scripts/preCommit.sh
echo "---tools done---"
