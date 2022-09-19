#!/usr/bin/env bash

set -x

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

export KUBEXIT_VERSION=v0.3.2
cd "$SCRIPT_DIR/mirror" || exit 1
git diff > "$SCRIPT_DIR/patches/$(date +%s).patch"