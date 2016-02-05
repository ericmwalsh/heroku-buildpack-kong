#!/usr/bin/env bash

# Fail immediately on non-zero exit code.
set -e
# Fail immediately on non-zero exit code within a pipeline.
set -o pipefail
# Fail on undeclared variables.
set -u
# Debug, echo every command
set -x

SRC_DIR=$(pwd)
BIN_DIR=$(cd "$(dirname "$0")"; pwd)

# Get the private IP of the dyno.
# Fallback to localhost for the common runtime.
export KONG_CLUSTER_PRIVATE_IP="$(ip -4 -o addr show dev eth1 && (awk '{print $4}' | cut -d/ -f1) || echo '127.0.0.1')"

luajit $SRC_DIR/config/kong-12f.lua $SRC_DIR/config/kong.yml.etlua $SRC_DIR
