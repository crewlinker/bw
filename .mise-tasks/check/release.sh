#!/usr/bin/env bash
#MISE description="Validate the GoReleaser configuration"
set -euo pipefail

goreleaser check
