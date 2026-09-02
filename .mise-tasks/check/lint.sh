#!/usr/bin/env bash
#MISE description="Lint all Go, shell, and GitHub Actions code"
#MISE depends=["dev:fmt"]
set -euo pipefail

find .mise-tasks -name '*.sh' -type f -print0 | xargs -0 shellcheck
golangci-lint config verify
golangci-lint run ./...
actionlint
zizmor --offline --strict-collection .
