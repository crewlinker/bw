#!/usr/bin/env bash
#MISE description="Format all Go, shell, and YAML code"
set -euo pipefail

go mod tidy
golangci-lint fmt
find .mise-tasks -name '*.sh' -type f -print0 | xargs -0 shfmt -w
yamlfmt .github
