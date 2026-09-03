#!/usr/bin/env bash
#MISE description="Build an unpublished snapshot release into dist/ to test the GoReleaser setup"
set -euo pipefail

goreleaser release --snapshot --clean --skip=publish
