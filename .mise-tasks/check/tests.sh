#!/usr/bin/env bash
#MISE description="Run unit tests"
#MISE depends=["dev:fmt"]
set -euo pipefail

go test ./...
