#!/usr/bin/env bash
#MISE description="Initialize the repository for a developer"
set -euo pipefail

mise install
go mod download

echo
echo "Initialized. Verify the repository with: mise run 'check:*'"
