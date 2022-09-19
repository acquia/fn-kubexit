#!/usr/bin/env bash

set -x

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

export KUBEXIT_VERSION=v0.3.2
cd "$SCRIPT_DIR" || exit 1
rm -rf mirror
git clone --depth 1 --branch "${KUBEXIT_VERSION}" https://github.com/karlkfi/kubexit.git mirror
cd "$SCRIPT_DIR/mirror" || exit 1
for patch in $(ls ../patches/*.patch | sort -n)
do
  git apply --reject --whitespace=fix "$patch"
  git commit -a -m "$patch"
done