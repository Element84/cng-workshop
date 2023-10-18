#!/usr/bin/env bash

set -euo pipefail

find_this () {
    THIS="${1:?'must provide script path, like "${BASH_SOURCE[0]}" or "$0"'}"
    trap "echo >&2 'FATAL: could not resolve parent directory of ${THIS}'" EXIT
    [ "${THIS:0:1}"  == "/" ] || THIS="$(pwd -P)/${THIS}"
    THIS_DIR="$(dirname -- "${THIS}")"
    THIS_DIR="$(cd -P -- "${THIS_DIR}" && pwd)"
    THIS="${THIS_DIR}/$(basename -- "${THIS}")"
    trap "" EXIT
}

find_this "${BASH_SOURCE[0]}"

ROOT="${THIS_DIR}/.."

aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/q2i2x3t4
docker build -t e84-sandbox/coiled-demo --progress plain "$ROOT"
docker tag e84-sandbox/coiled-demo:latest public.ecr.aws/q2i2x3t4/e84-sandbox/coiled-demo:latest
docker push public.ecr.aws/q2i2x3t4/e84-sandbox/coiled-demo:latest
